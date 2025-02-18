<template>
  <div>
    <app-template
      ref="template"
      :breadcrumbs="breadcrumbs"
      :side-bar-active-panel="sideBarActivePanel"
      :side-bar-available-panels="sideBarAvailablePanels"
      :side-bar-open="sideBarOpen"
      :side-bar-loading="sideBarLoading"
      :show-batch-actions="!!selectedUsers.length"
      :batch-actions="batchActions"
      :batch-action-items="selectedUsers"
    >
      <template #topbarActions>
        <div class="admin-settings-app-bar-actions">
          <div v-if="selectedUsers.length" class="oc-flex oc-flex-middle">
            <span v-text="selectedUsersText" />
            <oc-button
              id="users-clear-selection"
              v-oc-tooltip="$gettext('Clear selection')"
              :aria-label="$gettext('Clear selection')"
              class="oc-ml-m oc-py-s"
              appearance="outline"
              @click="unselectAllUsers"
            >
              <oc-icon name="close" />
            </oc-button>
          </div>
          <div v-else>
            <oc-button
              v-if="!createUsersDisabled"
              variation="primary"
              appearance="filled"
              data-test-id="create-user-btn"
              @click="toggleCreateUserModal"
            >
              <oc-icon name="add" />
              <span v-text="$gettext('New user')" />
            </oc-button>
          </div>
        </div>
      </template>
      <template #mainContent>
        <app-loading-spinner v-if="loadResourcesTask.isRunning || !loadResourcesTask.last" />
        <div v-else>
          <UsersList
            :users="users"
            :roles="roles"
            :class="{ 'users-table-squashed': sideBarOpen }"
            :selected-users="selectedUsers"
            @toggle-select-user="toggleSelectUser"
            @select-users="selectUsers"
            @un-select-all-users="unselectAllUsers"
          >
            <template #contextMenu>
              <context-actions :items="selectedUsers" />
            </template>
            <template #filter>
              <div class="oc-flex oc-flex-middle oc-ml-m oc-mb-m oc-mt-m">
                <div class="oc-mr-m oc-flex oc-flex-middle">
                  <oc-icon name="filter-2" class="oc-mr-xs" />
                  <span v-text="$gettext('Filter:')" />
                </div>
                <item-filter
                  :allow-multiple="true"
                  :filter-label="$gettext('Groups')"
                  :filterable-attributes="['displayName']"
                  :items="groups"
                  :option-filter-label="$gettext('Filter groups')"
                  :show-option-filter="true"
                  class="oc-mr-s"
                  display-name-attribute="displayName"
                  filter-name="groups"
                  @selection-change="filterGroups"
                >
                  <template #image="{ item }">
                    <avatar-image :width="32" :userid="item.id" :user-name="item.displayName" />
                  </template>
                  <template #item="{ item }">
                    <div v-text="item.displayName" />
                  </template>
                </item-filter>
                <item-filter
                  :allow-multiple="true"
                  :filter-label="$gettext('Roles')"
                  :filterable-attributes="['displayName']"
                  :items="roles"
                  :option-filter-label="$gettext('Filter roles')"
                  :show-option-filter="true"
                  display-name-attribute="displayName"
                  filter-name="roles"
                  @selection-change="filterRoles"
                >
                  <template #image="{ item }">
                    <avatar-image
                      :width="32"
                      :userid="item.id"
                      :user-name="$gettext(item.displayName)"
                    />
                  </template>
                  <template #item="{ item }">
                    <div v-text="$gettext(item.displayName)" />
                  </template>
                </item-filter>
              </div>
            </template>
          </UsersList>
        </div>
      </template>
    </app-template>
    <groups-modal
      v-if="addToGroupsModalIsOpen"
      :title="addToGroupsModalTitle"
      :groups="writableGroups"
      :users="selectedUsers"
      @cancel="() => (addToGroupsModalIsOpen = false)"
      @confirm="addUsersToGroups"
    />
    <groups-modal
      v-if="removeFromGroupsModalIsOpen"
      :title="removeFromGroupsModalTitle"
      :groups="writableGroups"
      :users="selectedUsers"
      @cancel="() => (removeFromGroupsModalIsOpen = false)"
      @confirm="removeUsersFromGroups"
    />
    <login-modal
      v-if="editLoginModalIsOpen"
      :users="selectedUsers"
      @cancel="() => (editLoginModalIsOpen = false)"
      @confirm="editLoginForUsers"
    />
    <create-user-modal
      v-if="createUserModalOpen"
      @cancel="toggleCreateUserModal"
      @confirm="createUser"
    />
    <quota-modal
      v-if="quotaModalIsOpen"
      :cancel="closeQuotaModal"
      :spaces="selectedPersonalDrives"
      :max-quota="maxQuota"
      :warning-message="quotaModalWarningMessage"
      :warning-message-contextual-helper-data="quotaWarningMessageContextualHelperData"
      resource-type="user"
    />
  </div>
</template>

<script lang="ts">
import isEqual from 'lodash-es/isEqual'
import isEmpty from 'lodash-es/isEmpty'
import omit from 'lodash-es/omit'
import UsersList from '../components/Users/UsersList.vue'
import CreateUserModal from '../components/Users/CreateUserModal.vue'
import ContextActions from '../components/Users/ContextActions.vue'
import DetailsPanel from '../components/Users/SideBar/DetailsPanel.vue'
import EditPanel from '../components/Users/SideBar/EditPanel.vue'
import QuotaModal from 'web-pkg/src/components/Spaces/QuotaModal.vue'
import {
  queryItemAsString,
  useAccessToken,
  useCapabilityCreateUsersDisabled,
  useCapabilitySpacesMaxQuota,
  useClientService,
  useLoadingService,
  useRoute,
  useRouteQuery,
  useRouter,
  useStore
} from 'web-pkg/src/composables'
import { computed, defineComponent, ref, onBeforeUnmount, onMounted, unref, watch } from 'vue'
import { useTask } from 'vue-concurrency'
import { eventBus } from 'web-pkg/src/services/eventBus'
import { mapActions, mapMutations, mapState } from 'vuex'
import AppTemplate from '../components/AppTemplate.vue'
import { useSideBar } from 'web-pkg/src/composables/sideBar'
import ItemFilter from 'web-pkg/src/components/ItemFilter.vue'
import AppLoadingSpinner from 'web-pkg/src/components/AppLoadingSpinner.vue'
import { toRaw } from 'vue'
import { SpaceResource } from 'web-client/src'
import { useGettext } from 'vue3-gettext'
import { diff } from 'deep-object-diff'
import { format } from 'util'
import GroupsModal from '../components/Users/GroupsModal.vue'
import LoginModal from '../components/Users/LoginModal.vue'
import {
  useUserActionsDelete,
  useUserActionsRemoveFromGroups,
  useUserActionsAddToGroups,
  useUserActionsEditLogin,
  useUserActionsEditQuota
} from '../composables/actions/users'
import { configurationManager } from 'web-pkg'
import { Drive, Group, User } from 'web-client/src/generated'
import { isPersonalSpaceResource } from 'web-client/src/helpers'

export default defineComponent({
  name: 'UsersView',
  components: {
    AppLoadingSpinner,
    AppTemplate,
    UsersList,
    CreateUserModal,
    ContextActions,
    ItemFilter,
    QuotaModal,
    GroupsModal,
    LoginModal
  },
  setup() {
    const { $gettext, $ngettext } = useGettext()
    const router = useRouter()
    const route = useRoute()
    const store = useStore()
    const accessToken = useAccessToken({ store })
    const clientService = useClientService()
    const loadingService = useLoadingService()
    const createUsersDisabled = useCapabilityCreateUsersDisabled()

    const { actions: deleteActions } = useUserActionsDelete({ store })
    const { actions: removeFromGroupsActions } = useUserActionsRemoveFromGroups()
    const { actions: addToGroupsActions } = useUserActionsAddToGroups()
    const { actions: editLoginActions } = useUserActionsEditLogin()
    const {
      actions: editQuotaActions,
      modalOpen: quotaModalIsOpen,
      closeModal: closeQuotaModal
    } = useUserActionsEditQuota()

    const users = ref([])
    const groups = ref([])
    const roles = ref([])
    const selectedUsers = ref<User[]>([])
    const additionalUserDataLoadedForUserIds = ref([])
    const applicationId = ref()
    const selectedUserIds = computed(() =>
      unref(selectedUsers).map((selectedUser) => selectedUser.id)
    )
    const sideBarLoading = ref(false)
    const createUserModalOpen = ref(false)
    const addToGroupsModalIsOpen = ref(false)
    const removeFromGroupsModalIsOpen = ref(false)
    const editLoginModalIsOpen = ref(false)
    const template = ref()
    let loadResourcesEventToken
    let addToGroupsActionEventToken
    let removeFromGroupsActionEventToken
    let editLoginActionEventToken
    let editQuotaActionEventToken
    const addToGroupsModalTitle = computed(() => {
      return $ngettext(
        'Add user "%{user}" to groups',
        'Add %{userCount} users to groups ',
        unref(selectedUsers).length,
        {
          user: unref(selectedUsers)[0].displayName,
          userCount: unref(selectedUsers).length.toString()
        }
      )
    })
    const removeFromGroupsModalTitle = computed(() => {
      return $ngettext(
        'Remove user "%{user}" from groups',
        'Remove %{userCount} users from groups ',
        unref(selectedUsers).length,
        {
          user: unref(selectedUsers)[0].displayName,
          userCount: unref(selectedUsers).length.toString()
        }
      )
    })

    const filters = {
      groups: {
        param: useRouteQuery('q_groups'),
        query: `memberOf/any(m:m/id eq '%s')`,
        ids: ref([])
      },
      roles: {
        param: useRouteQuery('q_roles'),
        query: `appRoleAssignments/any(m:m/appRoleId eq '%s')`,
        ids: ref([])
      }
    }

    const loadGroupsTask = useTask(function* (signal) {
      const groupsResponse = yield clientService.graphAuthenticated.groups.listGroups('displayName')
      groups.value = groupsResponse.data.value
    })

    const loadAppRolesTask = useTask(function* (signal) {
      const applicationsResponse =
        yield clientService.graphAuthenticated.applications.listApplications()
      roles.value = applicationsResponse.data.value[0].appRoles
      applicationId.value = applicationsResponse.data.value[0].id
    })

    const loadUsersTask = useTask(function* (signal) {
      const filter = Object.values(filters)
        .reduce((acc, f) => {
          const str = unref(f.ids)
            .map((id) => format(f.query, id))
            .join(' or ')
          if (str) {
            acc.push(`(${str})`)
          }
          return acc
        }, [])
        .filter(Boolean)
        .join(' and ')

      const usersResponse = yield clientService.graphAuthenticated.users.listUsers(
        'displayName',
        filter
      )
      users.value = usersResponse.data.value || []
    })

    const loadResourcesTask = useTask(function* (signal) {
      yield loadUsersTask.perform()
      yield loadGroupsTask.perform()
      yield loadAppRolesTask.perform()
    })

    /**
     * This function reloads the user with expanded attributes,
     * this is necessary as we don't load all the data while listing the users
     * for performance reasons
     */
    const loadAdditionalUserDataTask = useTask(function* (signal, user, forceReload = false) {
      /**
       * Prevent load additional user data multiple times if not needed
       */
      if (!forceReload && unref(additionalUserDataLoadedForUserIds).includes(user.id)) {
        return
      }

      const { data } = yield clientService.graphAuthenticated.users.getUser(user.id)
      unref(additionalUserDataLoadedForUserIds).push(user.id)

      Object.assign(user, data)
    })

    const resetPagination = () => {
      return router.push({ ...unref(route), query: { ...unref(route).query, page: '1' } })
    }

    const filterGroups = (groups) => {
      filters.groups.ids.value = groups.map((g) => g.id)
      loadUsersTask.perform()
      selectedUsers.value = []
      additionalUserDataLoadedForUserIds.value = []
      return resetPagination()
    }
    const filterRoles = (roles) => {
      filters.roles.ids.value = roles.map((r) => r.id)
      loadUsersTask.perform()
      selectedUsers.value = []
      additionalUserDataLoadedForUserIds.value = []
      return resetPagination()
    }

    const selectedPersonalDrives = ref([])
    watch(selectedUserIds, async () => {
      sideBarLoading.value = true
      // Load additional user data
      const requests = unref(selectedUsers).map((user) => loadAdditionalUserDataTask.perform(user))
      const results = await Promise.allSettled<Array<unknown>>(requests)
      const failedRequests = results.filter((result) => result.status === 'rejected')
      if (failedRequests.length > 0) {
        console.debug('Failed to load additional user data', failedRequests)
      }

      selectedPersonalDrives.value.splice(0, unref(selectedPersonalDrives).length)
      unref(selectedUsers).forEach((user) => {
        const drive = toRaw(user.drive)
        if (drive === undefined || drive.id === undefined) {
          return
        }
        const spaceResource = {
          id: drive.id,
          name: user.displayName,
          spaceQuota: drive.quota
        } as SpaceResource
        selectedPersonalDrives.value.push(spaceResource)
      })

      sideBarLoading.value = false
    })

    const batchActions = computed(() => {
      return [
        ...unref(deleteActions),
        ...unref(editQuotaActions),
        ...unref(addToGroupsActions),
        ...unref(removeFromGroupsActions),
        ...unref(editLoginActions)
      ].filter((item) => item.isEnabled({ resources: unref(selectedUsers) }))
    })

    const updateSpaceQuota = ({ spaceId, quota }) => {
      const userIndex = unref(users).findIndex((u) => u.drive?.id === spaceId)
      if (userIndex) {
        unref(users)[userIndex].drive.quota = quota
      }

      const selectedIndex = unref(selectedUsers).findIndex((u) => u.drive?.id === spaceId)
      if (selectedIndex) {
        unref(selectedUsers)[selectedIndex].drive.quota = quota
      }
    }

    const usersWithoutDrive = computed(() => {
      return unref(selectedUsers).filter(
        ({ drive }) => !isPersonalSpaceResource(drive as SpaceResource)
      )
    })

    const quotaModalWarningMessage = computed(() => {
      return usersWithoutDrive.value.length
        ? $gettext('Quota will only be applied to users who logged in at least once.')
        : ''
    })

    const quotaWarningMessageContextualHelperData = computed(() => {
      return usersWithoutDrive.value.length
        ? {
            title: $gettext('Unaffected users'),
            text: [...usersWithoutDrive.value]
              .sort((u1, u2) => u1.displayName.localeCompare(u2.displayName))
              .map((user) => user.displayName)
              .join(', ')
          }
        : {}
    })

    onMounted(async () => {
      for (const f in filters) {
        filters[f].ids.value = queryItemAsString(unref(filters[f].param))?.split('+') || []
      }

      await loadResourcesTask.perform()
      loadResourcesEventToken = eventBus.subscribe('app.admin-settings.list.load', () => {
        loadResourcesTask.perform()
        selectedUsers.value = []
      })

      addToGroupsActionEventToken = eventBus.subscribe(
        'app.admin-settings.users.actions.add-to-groups',
        () => {
          addToGroupsModalIsOpen.value = true
        }
      )
      removeFromGroupsActionEventToken = eventBus.subscribe(
        'app.admin-settings.users.actions.remove-from-groups',
        () => {
          removeFromGroupsModalIsOpen.value = true
        }
      )
      editLoginActionEventToken = eventBus.subscribe(
        'app.admin-settings.users.actions.edit-login',
        () => {
          editLoginModalIsOpen.value = true
        }
      )
      editQuotaActionEventToken = eventBus.subscribe(
        'app.admin-settings.users.user.quota.updated',
        updateSpaceQuota
      )
    })

    onBeforeUnmount(() => {
      eventBus.unsubscribe('app.admin-settings.list.load', loadResourcesEventToken)
      eventBus.unsubscribe(
        'app.admin-settings.users.actions.add-to-groups',
        addToGroupsActionEventToken
      )
      eventBus.unsubscribe(
        'app.admin-settings.users.actions.remove-from-groups',
        removeFromGroupsActionEventToken
      )
      eventBus.unsubscribe('app.admin-settings.users.actions.edit-login', editLoginActionEventToken)
      eventBus.unsubscribe('app.admin-settings.users.user.quota.updated', editQuotaActionEventToken)
    })

    const updateLocalUsers = (usersToUpdate: User[]) => {
      for (const _user of usersToUpdate) {
        const userIndex = unref(users).findIndex((user) => user.id === _user.id)
        unref(users)[userIndex] = _user
        const selectedUserIndex = unref(selectedUsers).findIndex((user) => user.id === _user.id)
        if (selectedUserIndex >= 0) {
          // FIXME: why do we need to update selectedUsers?
          unref(selectedUsers)[selectedUserIndex] = _user
        }
      }
    }

    const addUsersToGroups = async ({ users: affectedUsers, groups: groupsToAdd }) => {
      try {
        const client = clientService.graphAuthenticated
        const usersToFetch = []
        const addUsersToGroupsRequests = []
        groupsToAdd.reduce((acc, group) => {
          for (const user of affectedUsers) {
            if (!user.memberOf.find((userGroup) => userGroup.id === group.id)) {
              acc.push(client.groups.addMember(group.id, user.id, configurationManager.serverUrl))
              if (!usersToFetch.includes(user.id)) {
                usersToFetch.push(user.id)
              }
            }
          }
          return acc
        }, addUsersToGroupsRequests)
        const usersResponse = await loadingService.addTask(async () => {
          await Promise.all(addUsersToGroupsRequests)
          return Promise.all(usersToFetch.map((userId) => client.users.getUser(userId)))
        })
        updateLocalUsers(usersResponse.map((r) => r.data))
        await store.dispatch('showMessage', {
          title: $gettext('Users were added to groups successfully')
        })
        addToGroupsModalIsOpen.value = false
      } catch (e) {
        console.error(e)
        await store.dispatch('showMessage', {
          title: $gettext('Failed add users to group'),
          status: 'danger'
        })
      }
    }

    const removeUsersFromGroups = async ({ users: affectedUsers, groups: groupsToRemove }) => {
      try {
        const client = clientService.graphAuthenticated
        const usersToFetch = []
        const removeUsersToGroupsRequests = []
        groupsToRemove.reduce((acc, group) => {
          for (const user of affectedUsers) {
            if (user.memberOf.find((userGroup) => userGroup.id === group.id)) {
              acc.push(client.groups.deleteMember(group.id, user.id))
              if (!usersToFetch.includes(user.id)) {
                usersToFetch.push(user.id)
              }
            }
          }
          return acc
        }, removeUsersToGroupsRequests)
        const usersResponse = await loadingService.addTask(async () => {
          await Promise.all(removeUsersToGroupsRequests)
          return Promise.all(usersToFetch.map((userId) => client.users.getUser(userId)))
        })
        updateLocalUsers(usersResponse.map((r) => r.data))
        await store.dispatch('showMessage', {
          title: $gettext('Users were removed from groups successfully')
        })
        removeFromGroupsModalIsOpen.value = false
      } catch (e) {
        console.error(e)
        await store.dispatch('showMessage', {
          title: $gettext('Failed remove users from group'),
          status: 'danger'
        })
      }
    }

    const editLoginForUsers = async ({
      users: affectedUsers,
      value
    }: {
      users: User[]
      value: boolean
    }) => {
      try {
        affectedUsers = affectedUsers.filter(({ id }) => store.getters.user.uuid !== id)
        const client = clientService.graphAuthenticated
        const promises = affectedUsers.map((u) =>
          client.users.editUser(u.id, { accountEnabled: value })
        )
        const usersResponse = await loadingService.addTask(async () => {
          await Promise.all(promises)
          return Promise.all(affectedUsers.map((u) => client.users.getUser(u.id)))
        })
        updateLocalUsers(usersResponse.map((r) => r.data))
        await store.dispatch('showMessage', { title: $gettext('Login was edited successfully') })
        editLoginModalIsOpen.value = false
      } catch (e) {
        console.error(e)
        return store.dispatch('showMessage', {
          title: $gettext('Failed to edit login'),
          status: 'danger'
        })
      }
    }

    const writableGroups = computed<Group[]>(() => {
      return unref(groups).filter((g) => !g.groupTypes?.includes('ReadOnly'))
    })

    return {
      ...useSideBar(),
      maxQuota: useCapabilitySpacesMaxQuota(),
      template,
      selectedUsers,
      sideBarLoading,
      users,
      roles,
      groups,
      applicationId,
      loadResourcesTask,
      loadAdditionalUserDataTask,
      clientService,
      accessToken,
      createUserModalOpen,
      addToGroupsModalTitle,
      addToGroupsModalIsOpen,
      removeFromGroupsModalTitle,
      removeFromGroupsModalIsOpen,
      editLoginModalIsOpen,
      editLoginForUsers,
      batchActions,
      filterGroups,
      filterRoles,
      quotaModalIsOpen,
      quotaModalWarningMessage,
      quotaWarningMessageContextualHelperData,
      closeQuotaModal,
      selectedPersonalDrives,
      addUsersToGroups,
      removeUsersFromGroups,
      writableGroups,
      createUsersDisabled
    }
  },
  computed: {
    ...mapState({ currentUser: 'user' }),

    selectedUsersText() {
      return this.$gettext('%{count} users selected', {
        count: this.selectedUsers.length.toString()
      })
    },
    breadcrumbs() {
      return [
        { text: this.$gettext('Administration Settings'), to: { path: '/admin-settings' } },
        {
          text: this.$gettext('Users'),
          onClick: () => eventBus.publish('app.admin-settings.list.load')
        }
      ]
    },
    sideBarAvailablePanels() {
      return [
        {
          app: 'DetailsPanel',
          icon: 'user',
          title: this.$gettext('User details'),
          component: DetailsPanel,
          default: true,
          enabled: true,
          componentAttrs: {
            user: this.selectedUsers.length === 1 ? this.selectedUsers[0] : null,
            users: this.selectedUsers,
            roles: this.roles
          }
        },
        {
          app: 'EditPanel',
          icon: 'pencil',
          title: this.$gettext('Edit user'),
          component: EditPanel,
          default: false,
          enabled: this.selectedUsers.length === 1,
          componentAttrs: {
            user: this.selectedUsers.length === 1 ? this.selectedUsers[0] : null,
            roles: this.roles,
            groups: this.groups,
            onConfirm: this.editUser
          }
        }
      ].filter((p) => p.enabled)
    }
  },
  methods: {
    ...mapActions(['showMessage']),
    ...mapMutations('runtime/spaces', ['UPDATE_SPACE_FIELD']),

    selectUsers(users) {
      this.selectedUsers = users
    },
    toggleSelectUser(toggledUser) {
      const isUserSelected = this.selectedUsers.find((user) => user.id === toggledUser.id)

      if (!isUserSelected) {
        return this.selectedUsers.push(this.users.find((u) => u.id === toggledUser.id))
      }

      this.selectedUsers = this.selectedUsers.filter((user) => user.id !== toggledUser.id)
    },
    unselectAllUsers() {
      this.selectedUsers = []
    },
    toggleCreateUserModal() {
      this.createUserModalOpen = !this.createUserModalOpen
    },
    async createUser(user) {
      try {
        const client = this.clientService.graphAuthenticated
        const { id: createdUserId } = (await client.users.createUser(user))?.data
        const { data: createdUser } = await client.users.getUser(createdUserId)
        this.users.push(createdUser)

        this.toggleCreateUserModal()
        this.showMessage({
          title: this.$gettext('User was created successfully')
        })
      } catch (error) {
        console.error(error)
        this.showMessage({
          title: this.$gettext('Failed to create user'),
          status: 'danger'
        })
      }
    },
    async editUser({ user, editUser }) {
      try {
        const client = this.clientService.graphAuthenticated
        const graphEditUserPayloadExtractor = (user) => {
          return omit(user, ['drive', 'appRoleAssignments', 'memberOf'])
        }
        const graphEditUserPayload = diff(
          graphEditUserPayloadExtractor(user),
          graphEditUserPayloadExtractor(editUser)
        )

        if (!isEmpty(graphEditUserPayload)) {
          await client.users.editUser(editUser.id, graphEditUserPayload)
        }

        if (!isEqual(user.drive?.quota?.total, editUser.drive?.quota?.total)) {
          await this.updateUserDrive(editUser)
        }

        if (!isEqual(user.memberOf, editUser.memberOf)) {
          await this.updateUserGroupAssignments(user, editUser)
        }

        if (
          !isEqual(user.appRoleAssignments[0]?.appRoleId, editUser.appRoleAssignments[0]?.appRoleId)
        ) {
          await this.updateUserAppRoleAssignments(user, editUser)
        }

        const { data: updatedUser } = await client.users.getUser(user.id)
        const userIndex = this.users.findIndex((user) => user.id === updatedUser.id)
        this.users[userIndex] = updatedUser
        const selectedUserIndex = this.selectedUsers.findIndex((user) => user.id === updatedUser.id)
        if (selectedUserIndex >= 0) {
          // FIXME: why do we need to update selectedUsers?
          this.selectedUsers[selectedUserIndex] = updatedUser
        }

        eventBus.publish('sidebar.entity.saved')

        return updatedUser
      } catch (error) {
        console.error(error)
        this.showMessage({
          title: this.$gettext('Failed to edit user'),
          status: 'danger'
        })
      }
    },

    async updateUserDrive(editUser) {
      const client = this.clientService.graphAuthenticated
      const updateDriveResponse = await client.drives.updateDrive(
        editUser.drive.id,
        { quota: { total: editUser.drive.quota.total } } as Drive,
        {}
      )

      if (editUser.id === this.currentUser.uuid) {
        // Load current user quota
        this.UPDATE_SPACE_FIELD({
          id: editUser.drive.id,
          field: 'spaceQuota',
          value: updateDriveResponse.data.quota
        })
      }
    },
    updateUserAppRoleAssignments(user, editUser) {
      const client = this.clientService.graphAuthenticated
      return client.users.createUserAppRoleAssignment(user.id, {
        appRoleId: editUser.appRoleAssignments[0].appRoleId,
        resourceId: this.applicationId,
        principalId: editUser.id
      })
    },
    updateUserGroupAssignments(user, editUser) {
      const client = this.clientService.graphAuthenticated
      const groupsToAdd = editUser.memberOf.filter(
        (editUserGroup) => !user.memberOf.some((g) => g.id === editUserGroup.id)
      )
      const groupsToDelete = user.memberOf.filter(
        (editUserGroup) => !editUser.memberOf.some((g) => g.id === editUserGroup.id)
      )
      const requests = []

      for (const groupToAdd of groupsToAdd) {
        requests.push(
          client.groups.addMember(groupToAdd.id, user.id, configurationManager.serverUrl)
        )
      }
      for (const groupToDelete of groupsToDelete) {
        requests.push(client.groups.deleteMember(groupToDelete.id, user.id))
      }

      return Promise.all(requests)
    }
  }
})
</script>
