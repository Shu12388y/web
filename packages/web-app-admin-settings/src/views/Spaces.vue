<template>
  <div>
    <app-template
      ref="template"
      :loading="loadResourcesTask.isRunning || !loadResourcesTask.last"
      :breadcrumbs="breadcrumbs"
      :side-bar-active-panel="sideBarActivePanel"
      :side-bar-available-panels="sideBarAvailablePanels"
      :side-bar-open="sideBarOpen"
      :is-side-bar-header-compact="selectedSpaces.length === 1"
      :show-batch-actions="!!selectedSpaces.length"
      :batch-actions="batchActions"
      :batch-action-items="selectedSpaces"
    >
      <template #sideBarHeader>
        <space-info
          v-if="selectedSpaces.length === 1"
          :space-resource="selectedSpaces[0]"
          class="sidebar-panel__space_info"
        />
      </template>
      <template #topbarActions>
        <div class="admin-settings-app-bar-actions">
          <div v-if="selectedSpaces.length >= 1" class="oc-flex oc-flex-middle">
            <oc-button
              id="spaces-clear-selection"
              v-oc-tooltip="$gettext('Clear selection')"
              :aria-label="$gettext('Clear selection')"
              class="oc-py-s"
              appearance="outline"
              @click="unselectAllSpaces"
            >
              <oc-icon name="close" />
            </oc-button>
          </div>
        </div>
      </template>
      <template #mainContent>
        <quota-modal
          v-if="quotaModalIsOpen"
          :cancel="closeQuotaModal"
          :spaces="selectedSpaces"
          :max-quota="maxQuota"
        />
        <no-content-message
          v-if="!spaces.length"
          id="admin-settings-spaces-empty"
          class="spaces-empty"
          icon="layout-grid"
        >
          <template #message>
            <span v-translate>No spaces in here</span>
          </template>
        </no-content-message>
        <div v-else>
          <SpacesList
            :spaces="spaces"
            :class="{ 'spaces-table-squashed': sideBarOpen }"
            :selected-spaces="selectedSpaces"
            @toggle-select-space="toggleSelectSpace"
            @select-spaces="selectSpaces"
            @un-select-all-spaces="unselectAllSpaces"
          >
            <template #contextMenu>
              <context-actions :items="selectedSpaces" />
            </template>
          </SpacesList>
        </div>
      </template>
    </app-template>
  </div>
</template>

<script lang="ts">
import NoContentMessage from 'web-pkg/src/components/NoContentMessage.vue'
import {
  useAccessToken,
  useCapabilitySpacesMaxQuota,
  useClientService,
  useStore
} from 'web-pkg/src/composables'
import {
  computed,
  defineComponent,
  getCurrentInstance,
  onBeforeUnmount,
  onMounted,
  ref,
  unref
} from 'vue'
import { useTask } from 'vue-concurrency'
import { eventBus } from 'web-pkg/src/services/eventBus'
import AppTemplate from '../components/AppTemplate.vue'
import { buildSpace } from 'web-client/src/helpers'
import { configurationManager } from 'web-pkg'
import SpacesList from '../components/Spaces/SpacesList.vue'
import SpaceDetails from 'web-pkg/src/components/sideBar/Spaces/Details/SpaceDetails.vue'
import SpaceDetailsMultiple from 'web-pkg/src/components/sideBar/Spaces/Details/SpaceDetailsMultiple.vue'
import SpaceNoSelection from 'web-pkg/src/components/sideBar/Spaces/SpaceNoSelection.vue'
import ContextActions from '../components/Spaces/ContextActions.vue'
import MembersPanel from '../components/Spaces/SideBar/MembersPanel.vue'
import SpaceInfo from 'web-pkg/src/components/sideBar/Spaces/SpaceInfo.vue'
import ActionsPanel from '../components/Spaces/SideBar/ActionsPanel.vue'
import QuotaModal from 'web-pkg/src/components/Spaces/QuotaModal.vue'
import { useSideBar } from 'web-pkg/src/composables/sideBar'
import { useGettext } from 'vue3-gettext'
import {
  useSpaceActionsDelete,
  useSpaceActionsDisable,
  useSpaceActionsRestore,
  useSpaceActionsEditQuota
} from 'web-pkg/src/composables/actions/spaces'
import { SpaceAction } from 'web-pkg/src/composables/actions'

export default defineComponent({
  name: 'SpacesView',
  components: {
    SpacesList,
    AppTemplate,
    NoContentMessage,
    ContextActions,
    SpaceInfo,
    QuotaModal
  },
  provide() {
    return {
      resource: computed(() => this.selectedSpaces[0])
    }
  },
  setup() {
    const instance = getCurrentInstance().proxy as any
    const store = useStore()
    const accessToken = useAccessToken({ store })
    const spaces = ref([])
    const clientService = useClientService()
    const { $gettext } = useGettext()
    const { sideBarOpen, sideBarActivePanel } = useSideBar()

    const loadResourcesEventToken = ref(null)
    let updateQuotaForSpaceEventToken
    const template = ref(null)
    const selectedSpaces = ref([])

    const loadResourcesTask = useTask(function* (signal) {
      const {
        data: { value: drivesResponse }
      } = yield clientService.graphAuthenticated.drives.listAllDrives(
        'name asc',
        'driveType eq project'
      )
      const drives = drivesResponse.map((space) =>
        buildSpace({ ...space, serverUrl: configurationManager.serverUrl })
      )
      spaces.value = drives
    })

    const breadcrumbs = computed(() => [
      { text: $gettext('Administration Settings'), to: { path: '/admin-settings' } },
      {
        text: $gettext('Spaces'),
        onClick: () => eventBus.publish('app.admin-settings.list.load')
      }
    ])

    const selectSpaces = (paginatedSpaces) => {
      selectedSpaces.value = [...paginatedSpaces]
    }

    const toggleSelectSpace = (toggledSpace) => {
      const isSpaceSelected = unref(selectedSpaces).find((s) => s.id === toggledSpace.id)
      if (!isSpaceSelected) {
        return selectedSpaces.value.push(toggledSpace)
      }

      selectedSpaces.value = unref(selectedSpaces).filter((s) => s.id !== toggledSpace.id)
    }

    const unselectAllSpaces = () => {
      selectedSpaces.value = []
    }

    const { actions: deleteActions } = useSpaceActionsDelete({ store })
    const { actions: disableActions } = useSpaceActionsDisable({ store })
    const {
      actions: editQuotaActions,
      modalOpen: quotaModalIsOpen,
      closeModal: closeQuotaModal
    } = useSpaceActionsEditQuota({ store })
    const { actions: restoreActions } = useSpaceActionsRestore({ store })

    const batchActions = computed((): SpaceAction[] => {
      return [
        ...unref(editQuotaActions),
        ...unref(restoreActions),
        ...unref(deleteActions),
        ...unref(disableActions)
      ].filter((item) => item.isEnabled({ resources: unref(selectedSpaces) }))
    })

    const sideBarAvailablePanels = computed(() => {
      return [
        {
          app: 'SpaceNoSelection',
          icon: 'layout-grid',
          title: $gettext('Details'),
          component: SpaceNoSelection,
          default: true,
          enabled: unref(selectedSpaces).length === 0
        },
        {
          app: 'SpaceDetails',
          icon: 'layout-grid',
          title: $gettext('Details'),
          component: SpaceDetails,
          default: true,
          enabled: unref(selectedSpaces).length === 1,
          componentAttrs: {
            showSpaceImage: false,
            showShareIndicators: false
          }
        },
        {
          app: 'SpaceDetailsMultiple',
          icon: 'layout-grid',
          title: $gettext('Details'),
          component: SpaceDetailsMultiple,
          default: true,
          enabled: unref(selectedSpaces).length > 1,
          componentAttrs: {
            selectedSpaces: unref(selectedSpaces)
          }
        },
        {
          app: 'SpaceActions',
          icon: 'slideshow-3',
          title: $gettext('Actions'),
          component: ActionsPanel,
          default: false,
          enabled: unref(selectedSpaces).length === 1
        },
        {
          app: 'SpaceMembers',
          icon: 'group',
          title: $gettext('Members'),
          component: MembersPanel,
          default: false,
          enabled: unref(selectedSpaces).length === 1
        }
      ].filter((p) => p.enabled)
    })

    onMounted(async () => {
      await loadResourcesTask.perform()
      loadResourcesEventToken.value = eventBus.subscribe('app.admin-settings.list.load', () => {
        loadResourcesTask.perform()
        selectedSpaces.value = []
      })

      updateQuotaForSpaceEventToken = eventBus.subscribe(
        'app.admin-settings.spaces.space.quota.updated',
        ({ spaceId, quota }) => {
          const space = unref(spaces).find((s) => s.id === spaceId)
          if (space) {
            space.spaceQuota = quota
          }
        }
      )
    })

    onBeforeUnmount(() => {
      eventBus.unsubscribe('app.admin-settings.list.load', unref(loadResourcesEventToken))
      eventBus.unsubscribe(
        'app.admin-settings.spaces.space.quota.updated',
        updateQuotaForSpaceEventToken
      )
    })

    return {
      maxQuota: useCapabilitySpacesMaxQuota(),
      sideBarOpen,
      sideBarActivePanel,
      spaces,
      loadResourcesTask,
      accessToken,
      breadcrumbs,
      batchActions,
      selectedSpaces,
      sideBarAvailablePanels,
      template,
      selectSpaces,
      toggleSelectSpace,
      unselectAllSpaces,
      quotaModalIsOpen,
      closeQuotaModal
    }
  }
})
</script>
