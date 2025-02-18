# UI Test suite types
FULL = 1
FEDERATED = 2
NOTIFICATIONS = 3

ALPINE_GIT = "alpine/git:latest"
DEEPDIVER_DOCKER_ORACLE_XE_11G = "deepdiver/docker-oracle-xe-11g:latest"
DRONE_CLI_ALPINE = "drone/cli:alpine"
MINIO_MC = "minio/mc:RELEASE.2021-10-07T04-19-58Z"
OC_CI_ALPINE = "owncloudci/alpine:latest"
OC_CI_BAZEL_BUILDIFIER = "owncloudci/bazel-buildifier"
OC_CI_CORE_NODEJS = "owncloudci/core:nodejs14"
OC_CI_DRONE_ANSIBLE = "owncloudci/drone-ansible:latest"
OC_CI_DRONE_CANCEL_PREVIOUS_BUILDS = "owncloudci/drone-cancel-previous-builds"
OC_CI_DRONE_SKIP_PIPELINE = "owncloudci/drone-skip-pipeline"
OC_CI_GOLANG = "owncloudci/golang:1.19"
OC_CI_HUGO = "owncloudci/hugo:0.89.4"
OC_CI_NODEJS = "owncloudci/nodejs:18"
OC_CI_PHP = "owncloudci/php:7.4"
OC_CI_WAIT_FOR = "owncloudci/wait-for:latest"
OC_TESTING_MIDDLEWARE = "owncloud/owncloud-test-middleware:1.8.3"
OC_UBUNTU = "owncloud/ubuntu:20.04"
PLUGINS_DOCKER = "plugins/docker:18.09"
PLUGINS_DOWNSTREAM = "plugins/downstream"
PLUGINS_GH_PAGES = "plugins/gh-pages:1"
PLUGINS_GIT_ACTION = "plugins/git-action:1"
PLUGINS_GITHUB_RELEASE = "plugins/github-release:1"
PLUGINS_S3 = "plugins/s3"
PLUGINS_S3_CACHE = "plugins/s3-cache:1"
PLUGINS_SLACK = "plugins/slack:1"
SELENIUM_STANDALONE_CHROME = "selenium/standalone-chrome:104.0-20220812"
SELENIUM_STANDALONE_FIREFOX = "selenium/standalone-firefox:104.0-20220812"
SONARSOURCE_SONAR_SCANNER_CLI = "sonarsource/sonar-scanner-cli:4.7.0"
THEGEEKLAB_DRONE_GITHUB_COMMENT = "thegeeklab/drone-github-comment:1"
TOOLHIPPIE_CALENS = "toolhippie/calens:latest"

OC10_VERSION = "latest"

WEB_PUBLISH_NPM_PACKAGES = ["babel-preset", "eslint-config", "extension-sdk", "prettier-config", "tsconfig", "web-client", "web-pkg"]
WEB_PUBLISH_NPM_ORGANIZATION = "@ownclouders"

dir = {
    "base": "/var/www/owncloud",
    "federated": "/var/www/owncloud/federated",
    "server": "/var/www/owncloud/server",
    "web": "/var/www/owncloud/web",
    "ocis": "/var/www/owncloud/ocis-build",
    "commentsFile": "/var/www/owncloud/web/comments.file",
    "app": "/srv/app",
    "config": "/srv/config",
    "ocisConfig": "/srv/config/drone/config-ocis.json",
    "oc10IntegrationAppOauthConfig": "/srv/config/drone/config-oc10-integration-app-oauth.json",
    "oc10IdentifierRegistrationConfig": "/srv/config/drone/identifier-registration-oc10.yml",
    "ocisIdentifierRegistrationConfig": "/srv/config/drone/identifier-registration.yml",
    "oc10OpenIdConfig": "/srv/config/drone/config-oc10-openid.json",
    "ocisRevaDataRoot": "/srv/app/tmp/ocis/owncloud/data/",
    "testingDataDir": "/srv/app/testing/data/",
    "setupServerAndAppScript": "tests/drone/setup-server-and-app.sh",
    "oc10OauthConfig": "tests/drone/config-oc10-oauth.json",
}

config = {
    "app": "web",
    "rocketchat": {
        "channel": "builds",
        "from_secret": "private_rocketchat",
    },
    "branches": [
        "master",
    ],
    "pnpmlint": True,
    "e2e": {
        "oC10": {
            "db": "mysql:5.5",
            "earlyFail": True,
            "skip": False,
        },
        "oCIS": {
            "earlyFail": True,
            "skip": False,
        },
    },
    "acceptance": {
        "webUI": {
            "type": FULL,
            "suites": {
                "oC10Basic": [
                    "webUIAccount",
                    "webUILogin",
                    "webUIPrivateLinks",
                    "webUIWebdavLockProtection",
                ],
                "oC10FileFolderOperations": [
                    "webUICreateFilesFolders",
                    "webUIDeleteFilesFolders",
                ],
                "oC10RenameFolder": [
                    "webUIRenameFolders",
                ],
                "oC10RenameFile": [
                    "webUIRenameFiles",
                ],
                "oC10MoveFileFolder": [
                    "webUIMoveFilesFolders",
                ],
                "oC10Files1": [
                    "webUIFiles",
                    "webUIUpload",
                ],
                "oC10Files2": [
                    "webUIFilesList",
                    "webUIFilesSearch",
                ],
                "oC10Files3": [
                    "webUIPreview",
                    "webUIFilesDetails",
                ],
                "oC10Files4": [
                    "webUIFilesCopy",
                    "webUIFavorites",
                ],
                "oC10Files5": [
                    "webUITextEditor",
                    "webUIFilesActionMenu",
                ],
                "oC10SharingAccept": [
                    "webUISharingAcceptShares",
                    "webUISharingAcceptSharesToRoot",
                ],
                "oC10Sharing1": [
                    "webUISharingAutocompletion",
                    "webUISharingExpirationDate",
                    "webUIRestrictSharing",
                ],
                "oC10Sharing2": [
                    "webUIResharingToRoot",
                    "webUISharingInternalUsersBlacklisted",
                    "webUIOperationsWithFolderShares",
                ],
                "oC10SharingIntGroups": [
                    "webUISharingInternalGroups",
                    "webUISharingInternalGroupsEdgeCases",
                ],
                "oC10SharingIntGroupsToRoot": [
                    "webUISharingInternalGroupsToRoot",
                    "webUISharingInternalGroupsToRootEdgeCases",
                ],
                "oC10SharingIntUsers1": [
                    "webUISharingInternalUsersToRootCollaborator",
                    "webUISharingInternalUsersToRoot",
                    "webUISharingInternalUsersToRootPreviews",
                ],
                "oC10SharingIntUsers2": [
                    "webUISharingInternalUsers",
                    "webUISharingInternalUsersCollaborator",
                ],
                "oc10SharingIntUsers3": [
                    "webUISharingInternalUsersToRootBlacklisted",
                    "webUISharingInternalUsersShareWithPage",
                    "webUISharingInternalUsersToRootShareWithPage",
                ],
                "oC10SharingSharingInd": [
                    "webUISharingInternalGroupsSharingIndicator",
                    "webUISharingInternalGroupsToRootSharingIndicator",
                    "webUISharingInternalUsersSharingIndicator",
                    "webUISharingInternalUsersToRootSharingIndicator",
                ],
                "oC10Trashbin": [
                    "webUITrashbinDelete",
                    "webUITrashbinFilesFolders",
                    "webUITrashbinRestore",
                ],
                "oC10SharingPermission": [
                    "webUISharingPermissionsUsers",
                ],
                "webUISharingPermissionToRoot": "oC10SharingPermToRoot",
                "oC10SharingFilePerm": [
                    "webUISharingFilePermissionMultipleUsers",
                    "webUISharingFilePermissionsGroups",
                ],
                "oC10SharingFolderPermissions": [
                    "webUISharingFolderAdvancedPermissionMultipleUsers",
                    "webUISharingFolderPermissionMultipleUsers",
                    "webUISharingFolderPermissionsGroups",
                ],
                "oC10SharingPublic1": [
                    "webUISharingPublicBasic",
                ],
                "oC10SharingPublic2": [
                    "webUISharingPublicExpire",
                    "webUISharingPublicManagement",
                ],
                "oC10SharingPublic3": [
                    "webUISharingPublicDifferentRoles",
                ],
                "oC10Resharing": [
                    "webUIResharing1",
                    "webUIResharing2",
                ],
            },
            "extraEnvironment": {
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-with-oc10-server-oauth2-login.md" % dir["web"],
            },
            "screenShots": True,
        },
        # These suites have all or most of their scenarios expected to fail.
        # Eliminate wasted CI time by not retrying the failing scenarios.
        "webUINoRetry": {
            "type": FULL,
            "suites": {
                "webUISharingFolderAdvancedPermissionsGroups": "oC10SharingFolderAdvPermsGrp",
            },
            "extraEnvironment": {
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-with-oc10-server-oauth2-login.md" % dir["web"],
            },
            "screenShots": True,
            "retry": False,
        },
        "webUIFederation": {
            "type": FEDERATED,
            "suites": {
                "webUISharingExternal": "oC10SharingExternal",
                "webUISharingExternalToRoot": "oC10SharingExternalRoot",
            },
            "extraEnvironment": {
                "REMOTE_BACKEND_HOST": "http://federated",
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-with-oc10-server-oauth2-login.md" % dir["web"],
            },
            "notificationsAppNeeded": True,
            "federatedServerNeeded": True,
            "federatedServerVersion": OC10_VERSION,
        },
        "webUI-XGA": {
            "type": FULL,
            "suites": {
                "oC10XGAPortrait1": [
                    "webUIAccount",
                    "webUICreateFilesFolders",
                    "webUIDeleteFilesFolders",
                    "webUIFavorites",
                    "webUIFiles",
                    "webUIFilesActionMenu",
                    "webUIFilesCopy",
                    "webUIFilesDetails",
                    "webUIFilesList",
                    "webUIFilesSearch",
                    "webUILogin",
                    "webUIPreview",
                    "webUIPrivateLinks",
                    "webUIRenameFiles",
                    "webUIRenameFolders",
                    "webUIRestrictSharing",
                    "webUIUpload",
                ],
                "oC10XGAPortrait2": [
                    "webUIOperationsWithFolderShares",
                    "webUISharingAcceptShares",
                    "webUISharingAcceptSharesToRoot",
                    "webUITextEditor",
                    "webUIWebdavLockProtection",
                    "webUIMoveFilesFolders",
                    "webUIResharing1",
                    "webUIResharing2",
                    "webUIResharingToRoot",
                    "webUISharingAutocompletion",
                    "webUISharingFilePermissionMultipleUsers",
                    "webUISharingFilePermissionsGroups",
                    "webUISharingFolderAdvancedPermissionMultipleUsers",
                    "webUISharingFolderAdvancedPermissionsGroups",
                    "webUISharingFolderPermissionMultipleUsers",
                    "webUISharingFolderPermissionsGroups",
                    "webUISharingInternalGroups",
                    "webUISharingInternalGroupsEdgeCases",
                    "webUISharingInternalGroupsSharingIndicator",
                    "webUISharingInternalGroupsToRoot",
                    "webUISharingInternalGroupsToRootEdgeCases",
                    "webUISharingInternalGroupsToRootSharingIndicator",
                    "webUISharingInternalUsers",
                    "webUISharingInternalUsersCollaborator",
                    "webUISharingInternalUsersShareWithPage",
                    "webUISharingInternalUsersBlacklisted",
                    "webUISharingExpirationDate",
                ],
                "oC10XGAPortrait3": [
                    "webUISharingInternalUsersSharingIndicator",
                    "webUISharingInternalUsersToRoot",
                    "webUISharingInternalUsersToRootCollaborator",
                    "webUISharingInternalUsersToRootPreviews",
                    "webUISharingInternalUsersToRootShareWithPage",
                    "webUISharingInternalUsersToRootBlacklisted",
                    "webUISharingInternalUsersToRootSharingIndicator",
                    "webUISharingPermissionsUsers",
                    "webUISharingPermissionToRoot",
                    "webUISharingPublicBasic",
                    "webUISharingPublicManagement",
                    "webUISharingPublicDifferentRoles",
                    "webUISharingPublicExpire",
                    "webUITrashbinDelete",
                    "webUITrashbinFilesFolders",
                    "webUITrashbinRestore",
                ],
            },
            "extraEnvironment": {
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-XGA-with-oc10-server-oauth2-login.md" % dir["web"],
                "SCREEN_RESOLUTION": "768x1024",
            },
            "filterTags": "@smokeTest and not @skipOnXGAPortraitResolution and not @skip and not @skipOnOC10 and not @notToImplementOnOC10",
        },
        "webUI-iPhone": {
            "type": FULL,
            "suites": {
                "oC10iPhone1": [
                    "webUIAccount",
                    "webUICreateFilesFolders",
                    "webUIDeleteFilesFolders",
                    "webUIFavorites",
                    "webUIFiles",
                    "webUIFilesActionMenu",
                    "webUIFilesCopy",
                    "webUIFilesDetails",
                    "webUIFilesList",
                    "webUIFilesSearch",
                    "webUILogin",
                    "webUIOperationsWithFolderShares",
                    "webUIPreview",
                    "webUIPrivateLinks",
                    "webUIRenameFiles",
                    "webUIRenameFolders",
                    "webUIRestrictSharing",
                ],
                "oC10iPhone2": [
                    "webUISharingAcceptShares",
                    "webUISharingAcceptSharesToRoot",
                    "webUITextEditor",
                    "webUISharingInternalUsersBlacklisted",
                    "webUIWebdavLockProtection",
                    "webUIMoveFilesFolders",
                    "webUIResharing1",
                    "webUIResharing2",
                    "webUIResharingToRoot",
                    "webUISharingAutocompletion",
                    "webUISharingFilePermissionMultipleUsers",
                    "webUISharingFilePermissionsGroups",
                    "webUISharingFolderAdvancedPermissionMultipleUsers",
                    "webUISharingFolderAdvancedPermissionsGroups",
                    "webUISharingFolderPermissionMultipleUsers",
                    "webUISharingFolderPermissionsGroups",
                    "webUISharingInternalGroups",
                    "webUISharingInternalGroupsEdgeCases",
                    "webUISharingInternalGroupsSharingIndicator",
                    "webUISharingInternalGroupsToRoot",
                    "webUISharingInternalGroupsToRootEdgeCases",
                    "webUISharingInternalGroupsToRootSharingIndicator",
                    "webUISharingInternalUsers",
                    "webUISharingExpirationDate",
                ],
                "oC10iPhone3": [
                    "webUISharingInternalUsersCollaborator",
                    "webUISharingInternalUsersShareWithPage",
                    "webUISharingInternalUsersSharingIndicator",
                    "webUISharingInternalUsersToRootCollaborator",
                    "webUISharingInternalUsersToRootPreviews",
                    "webUISharingInternalUsersToRootShareWithPage",
                    "webUISharingInternalUsersToRootSharingIndicator",
                    "webUISharingInternalUsersToRoot",
                    "webUISharingInternalUsersToRootBlacklisted",
                    "webUISharingPermissionsUsers",
                    "webUISharingPermissionToRoot",
                    "webUISharingPublicBasic",
                    "webUISharingPublicManagement",
                    "webUISharingPublicDifferentRoles",
                    "webUISharingPublicExpire",
                    "webUITrashbinDelete",
                    "webUITrashbinFilesFolders",
                    "webUITrashbinRestore",
                    "webUIUpload",
                ],
            },
            "extraEnvironment": {
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-Iphone-oc10-server-oauth2-login.md" % dir["web"],
                "SCREEN_RESOLUTION": "375x812",
            },
            "filterTags": "@smokeTest and not @skipOnIphoneResolution and not @skip and not @skipOnOC10 and not @notToImplementOnOC10",
        },
        "webUI-ocis": {
            "type": FULL,
            "servers": [
                "",
            ],
            "suites": {
                "oCISBasic": [
                    "webUIPrivateLinks",
                    "webUIPreview",
                    "webUIAccount",
                    "webUILogin",
                ],
                "webUIWebdavLockProtection": "oCISWebdavLockProtection",
                "oCISSharingBasic": [
                    "webUISharingAcceptShares",
                    "webUIRestrictSharing",
                ],
                "webUIFavorites": "oCISFavorites",
                "oCISFiles1": [
                    "webUICreateFilesFolders",
                    "webUIDeleteFilesFolders",
                ],
                "oCISFiles2": [
                    "webUIFilesList",
                    "webUIFilesDetails",
                    "webUIFilesSearch",
                ],
                "oCISFiles3": [
                    "webUIRenameFiles",
                ],
                "oCISFiles4": [
                    "webUIFiles",
                    "webUIRenameFolders",
                ],
                "oCISFiles5": [
                    "webUIFilesCopy",
                    "webUIFilesActionMenu",
                    "webUITextEditor",
                ],
                "oCISSharingInternal1": [
                    "webUISharingInternalGroups",
                    "webUISharingInternalGroupsEdgeCases",
                ],
                "oCISSharingInternal2": [
                    "webUISharingInternalUsers",
                    "webUISharingInternalUsersBlacklisted",
                    "webUISharingInternalUsersCollaborator",
                    "webUISharingExpirationDate",
                ],
                "oCISSharingInternal3": [
                    "webUISharingInternalGroupsSharingIndicator",
                    "webUISharingInternalUsersSharingIndicator",
                    "webUISharingInternalUsersShareWithPage",
                    "webUIOperationsWithFolderShares",
                ],
                "oCISSharingAutocompletionResharing": [
                    "webUISharingAutocompletion",
                    "webUIResharing1",
                    "webUIResharing2",
                ],
                "oCISSharingPerm1": [
                    "webUISharingPermissionsUsers",
                    "webUISharingFolderPermissionsGroups",
                ],
                "oCISSharingPerm2": [
                    "webUISharingFilePermissionsGroups",
                    "webUISharingFilePermissionMultipleUsers",
                    "webUISharingFolderPermissionMultipleUsers",
                    "webUISharingFolderAdvancedPermissionMultipleUsers",
                    "webUISharingFolderAdvancedPermissionsGroups",
                ],
                "oCISSharingPublic1": [
                    "webUISharingPublicBasic",
                ],
                "oCISSharingPublic2": [
                    "webUISharingPublicExpire",
                    "webUISharingPublicManagement",
                ],
                "oCISSharingPublic3": [
                    "webUISharingPublicDifferentRoles",
                ],
                "oCISUploadMove": [
                    "webUIUpload",
                    "webUIMoveFilesFolders",
                ],
                "oCISTrashbinJourney": [
                    "webUITrashbinDelete",
                    "webUITrashbinFilesFolders",
                    "webUITrashbinRestore",
                    "webUIUserJourney",
                ],
            },
            "extraEnvironment": {
                "NODE_TLS_REJECT_UNAUTHORIZED": "0",
                "SERVER_HOST": "https://ocis:9200",
                "BACKEND_HOST": "https://ocis:9200",
                "RUN_ON_OCIS": "true",
                "TESTING_DATA_DIR": "%s" % dir["testingDataDir"],
                "OCIS_REVA_DATA_ROOT": "%s" % dir["ocisRevaDataRoot"],
                "WEB_UI_CONFIG": "%s" % dir["ocisConfig"],
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-with-ocis-server-ocis-storage.md" % dir["web"],
            },
            "runningOnOCIS": True,
            "filterTags": "not @skip and not @skipOnOCIS and not @notToImplementOnOCIS",
            "screenShots": True,
        },
        "webUI-oc10-integration": {
            "type": FULL,
            "suites": {
                "oC10IntegrationApp1": [
                    "webUIAccount",
                    "webUICreateFilesFolders",
                    "webUIDeleteFilesFolders",
                    "webUIFavorites",
                    "webUIFiles",
                    "webUIFilesActionMenu",
                    "webUIFilesCopy",
                    "webUIFilesDetails",
                    "webUIFilesList",
                    "webUIFilesSearch",
                    "webUILogin",
                    "webUIOperationsWithFolderShares",
                    "webUIPreview",
                    "webUIPrivateLinks",
                    "webUIRenameFiles",
                    "webUIRenameFolders",
                    "webUIRestrictSharing",
                    "webUISharingAcceptShares",
                    "webUISharingAcceptSharesToRoot",
                    "webUITextEditor",
                    "webUISharingInternalUsersBlacklisted",
                    "webUIWebdavLockProtection",
                    "webUIMoveFilesFolders",
                    "webUIResharing1",
                    "webUIResharing2",
                    "webUIResharingToRoot",
                    "webUISharingAutocompletion",
                    "webUISharingFilePermissionMultipleUsers",
                    "webUISharingFilePermissionsGroups",
                    "webUISharingFolderAdvancedPermissionMultipleUsers",
                    "webUISharingFolderAdvancedPermissionsGroups",
                    "webUISharingFolderPermissionMultipleUsers",
                    "webUISharingFolderPermissionsGroups",
                    "webUISharingInternalGroups",
                    "webUISharingInternalGroupsEdgeCases",
                    "webUISharingInternalGroupsSharingIndicator",
                    "webUISharingInternalGroupsToRoot",
                    "webUISharingInternalGroupsToRootEdgeCases",
                    "webUISharingInternalGroupsToRootSharingIndicator",
                ],
                "oC10IntegrationApp2": [
                    "webUISharingInternalUsers",
                    "webUISharingExpirationDate",
                    "webUISharingInternalUsersCollaborator",
                    "webUISharingInternalUsersShareWithPage",
                    "webUISharingInternalUsersSharingIndicator",
                    "webUISharingInternalUsersToRootCollaborator",
                    "webUISharingInternalUsersToRootPreviews",
                    "webUISharingInternalUsersToRootShareWithPage",
                    "webUISharingInternalUsersToRootSharingIndicator",
                    "webUISharingInternalUsersToRoot",
                    "webUISharingInternalUsersToRootBlacklisted",
                    "webUISharingPermissionsUsers",
                    "webUISharingPermissionToRoot",
                    "webUISharingPublicBasic",
                    "webUISharingPublicManagement",
                    "webUISharingPublicDifferentRoles",
                    "webUISharingPublicExpire",
                    "webUITrashbinDelete",
                    "webUITrashbinFilesFolders",
                    "webUITrashbinRestore",
                    "webUIUpload",
                ],
            },
            "extraEnvironment": {
                "WEB_UI_CONFIG": "%s" % dir["oc10IntegrationAppOauthConfig"],
                "SERVER_HOST": "http://owncloud/index.php/apps/web/index.html",
                "EXPECTED_FAILURES_FILE": "%s/tests/acceptance/expected-failures-with-oc10-server-oauth2-login-and-web-integration-app.md" % dir["web"],
            },
            "filterTags": "not @skip and not @skipOnOC10 and not @notToImplementOnOC10 and not @openIdLogin and @smokeTest",
            "oc10IntegrationAppIncluded": True,
            "screenShots": True,
        },
    },
    "build": True,
}

# UI Test Suites
# These list contains all the test suites that are present
# When adding new test suites, make sure to update these lists
federatedTestSuites = [
    "webUISharingExternal",
]

federatedRootTestSuites = [
    "webUISharingExternalToRoot",
]

rootSharingTestSuites = [
    "webUIResharingToRoot",
    "webUISharingAcceptSharesToRoot",
    "webUISharingInternalGroupsToRoot",
    "webUISharingInternalGroupsToRootEdgeCases",
    "webUISharingInternalGroupsToRootSharingIndicator",
    "webUISharingInternalUsersToRoot",
    "webUISharingInternalUsersToRootBlacklisted",
    "webUISharingInternalUsersToRootCollaborator",
    "webUISharingInternalUsersToRootPreviews",
    "webUISharingInternalUsersToRootShareWithPage",
    "webUISharingInternalUsersToRootSharingIndicator",
    "webUISharingPermissionToRoot",
]

basicTestSuites = [
    "webUIAccount",
    "webUICreateFilesFolders",
    "webUIDeleteFilesFolders",
    "webUIFavorites",
    "webUIFiles",
    "webUIFilesActionMenu",
    "webUIFilesCopy",
    "webUIFilesDetails",
    "webUIFilesList",
    "webUIFilesSearch",
    "webUILogin",
    "webUIMoveFilesFolders",
    "webUIOperationsWithFolderShares",
    "webUIPreview",
    "webUIPrivateLinks",
    "webUIRenameFiles",
    "webUIRenameFolders",
    "webUIResharing1",
    "webUIResharing2",
    "webUIRestrictSharing",
    "webUISharingAcceptShares",
    "webUISharingAutocompletion",
    "webUISharingExpirationDate",
    "webUISharingFilePermissionMultipleUsers",
    "webUISharingFilePermissionsGroups",
    "webUISharingFolderAdvancedPermissionMultipleUsers",
    "webUISharingFolderAdvancedPermissionsGroups",
    "webUISharingFolderPermissionMultipleUsers",
    "webUISharingFolderPermissionsGroups",
    "webUISharingInternalGroups",
    "webUISharingInternalGroupsEdgeCases",
    "webUISharingInternalGroupsSharingIndicator",
    "webUISharingInternalUsers",
    "webUISharingInternalUsersBlacklisted",
    "webUISharingInternalUsersCollaborator",
    "webUISharingInternalUsersShareWithPage",
    "webUISharingInternalUsersSharingIndicator",
    "webUISharingPermissionsUsers",
    "webUISharingPublicBasic",
    "webUISharingPublicDifferentRoles",
    "webUISharingPublicExpire",
    "webUISharingPublicManagement",
    "webUITextEditor",
    "webUITrashbinDelete",
    "webUITrashbinFilesFolders",
    "webUITrashbinRestore",
    "webUIUpload",
    "webUIWebdavLockProtection",
]

ocisSpecificTestSuites = [
    "webUIUserJourney",
]

# minio mc environment variables
minio_mc_environment = {
    "CACHE_BUCKET": {
        "from_secret": "cache_public_s3_bucket",
    },
    "MC_HOST": {
        "from_secret": "cache_s3_endpoint",
    },
    "AWS_ACCESS_KEY_ID": {
        "from_secret": "cache_s3_access_key",
    },
    "AWS_SECRET_ACCESS_KEY": {
        "from_secret": "cache_s3_secret_key",
    },
}

go_step_volumes = [{
    "name": "server",
    "path": dir["app"],
}, {
    "name": "gopath",
    "path": "/go",
}, {
    "name": "configs",
    "path": dir["config"],
}]

web_workspace = {
    "base": dir["base"],
    "path": config["app"],
}

def checkTestSuites():
    for testGroupName, test in config["acceptance"].items():
        suites = []
        for key, items in test["suites"].items():
            if (type(items) == "list"):
                suites += items
            elif (type(items) == "string"):
                suites.append(key)
            else:
                print("Error: invalid value for suite, it must be a list or string")
                return False

        expected = []
        if (test["type"] == FULL):
            expected += basicTestSuites
            if ("runningOnOCIS" not in test or test["runningOnOCIS"] != True):
                expected += rootSharingTestSuites
        elif (test["type"] == FEDERATED):
            expected += federatedTestSuites + federatedRootTestSuites

        if ("runningOnOCIS" in test and test["runningOnOCIS"] == True):
            expected += ocisSpecificTestSuites

        if (sorted(suites) != sorted(expected)):
            print("Error: Suites dont match " + testGroupName)
            print(Diff(sorted(suites), sorted(expected)))

    return True

def Diff(li1, li2):
    li_dif = [i for i in li1 + li2 if i not in li1 or i not in li2]
    return li_dif

def main(ctx):
    uiSuitesCheck = checkTestSuites()
    if (uiSuitesCheck == False):
        print("Errors detected. Review messages above.")
        return []

    before = beforePipelines(ctx)

    stages = pipelinesDependsOn(stagePipelines(ctx), before)

    if (stages == False):
        print("Errors detected. Review messages above.")
        return []

    after = pipelinesDependsOn(afterPipelines(ctx), stages)

    pipelines = before + stages + after

    deploys = example_deploys(ctx)
    if ctx.build.event != "cron":
        # run example deploys on cron even if some prior pipelines fail
        deploys = pipelinesDependsOn(deploys, pipelines)

    pipelines = pipelines + deploys + pipelinesDependsOn(
        [
            purgeBuildArtifactCache(ctx),
        ],
        pipelines,
    )

    pipelineSanityChecks(ctx, pipelines)
    return pipelines

def beforePipelines(ctx):
    return cancelPreviousBuilds() + \
           checkStarlark() + \
           licenseCheck(ctx) + \
           documentation(ctx) + \
           changelog(ctx) + \
           pnpmCache(ctx) + \
           cacheOcisPipeline(ctx) + \
           pipelinesDependsOn(buildCacheWeb(ctx), pnpmCache(ctx)) + \
           pipelinesDependsOn(pnpmlint(ctx), pnpmCache(ctx))

def stagePipelines(ctx):
    unit_test_pipelines = unitTests(ctx)
    e2e_pipelines = e2eTests(ctx)
    acceptance_pipelines = acceptance(ctx)
    return unit_test_pipelines + pipelinesDependsOn(e2e_pipelines + acceptance_pipelines, unit_test_pipelines)

def afterPipelines(ctx):
    return build(ctx) + pipelinesDependsOn(notify(), build(ctx))

def pnpmCache(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "cache-pnpm",
        "workspace": {
            "base": dir["base"],
            "path": config["app"],
        },
        "steps": skipIfUnchanged(ctx, "cache") +
                 installPnpm() +
                 rebuildBuildArtifactCache(ctx, "pnpm", ".pnpm-store") +
                 rebuildBuildArtifactCache(ctx, "playwright", ".playwright"),
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def pnpmlint(ctx):
    pipelines = []

    if "pnpmlint" not in config:
        return pipelines

    if type(config["pnpmlint"]) == "bool":
        if not config["pnpmlint"]:
            return pipelines

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "lint",
        "workspace": {
            "base": dir["base"],
            "path": config["app"],
        },
        "steps": skipIfUnchanged(ctx, "lint") +
                 restoreBuildArtifactCache(ctx, "pnpm", ".pnpm-store") +
                 installPnpm() +
                 lint(),
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    pipelines.append(result)

    return pipelines

def cancelPreviousBuilds():
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "cancel-previous-builds",
        "clone": {
            "disable": True,
        },
        "steps": [{
            "name": "cancel-previous-builds",
            "image": OC_CI_DRONE_CANCEL_PREVIOUS_BUILDS,
            "settings": {
                "DRONE_TOKEN": {
                    "from_secret": "drone_token",
                },
            },
        }],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }]

def build(ctx):
    pipelines = []

    if "build" not in config:
        return pipelines

    if type(config["build"]) == "bool":
        if not config["build"]:
            return pipelines

    steps = restoreBuildArtifactCache(ctx, "pnpm", ".pnpm-store") + installPnpm() + buildRelease(ctx)

    if determineReleasePackage(ctx) == None:
        steps += buildDockerImage()

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "build",
        "workspace": {
            "base": dir["base"],
            "path": config["app"],
        },
        "steps": steps,
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
            ],
        },
    }

    pipelines.append(result)

    return pipelines

def changelog(ctx):
    pipelines = []
    repo_slug = ctx.build.source_repo if ctx.build.source_repo else ctx.repo.slug

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "changelog",
        "clone": {
            "disable": True,
        },
        "steps": [
            {
                "name": "clone",
                "image": PLUGINS_GIT_ACTION,
                "settings": {
                    "actions": [
                        "clone",
                    ],
                    "remote": "https://github.com/%s" % (repo_slug),
                    "branch": ctx.build.source if ctx.build.event == "pull_request" else "master",
                    "path": "/drone/src",
                    "netrc_machine": "github.com",
                    "netrc_username": {
                        "from_secret": "github_username",
                    },
                    "netrc_password": {
                        "from_secret": "github_token",
                    },
                },
            },
            {
                "name": "generate",
                "image": TOOLHIPPIE_CALENS,
                "commands": [
                    "calens >| CHANGELOG.md",
                ],
            },
            {
                "name": "diff",
                "image": OC_CI_ALPINE,
                "commands": [
                    "git diff",
                ],
            },
            {
                "name": "output",
                "image": TOOLHIPPIE_CALENS,
                "commands": [
                    "cat CHANGELOG.md",
                ],
            },
            {
                "name": "publish",
                "image": PLUGINS_GIT_ACTION,
                "settings": {
                    "actions": [
                        "commit",
                        "push",
                    ],
                    "message": "Automated changelog update [skip ci]",
                    "branch": "master",
                    "author_email": "devops@owncloud.com",
                    "author_name": "ownClouders",
                    "netrc_machine": "github.com",
                    "netrc_username": {
                        "from_secret": "github_username",
                    },
                    "netrc_password": {
                        "from_secret": "github_token",
                    },
                },
                "when": {
                    "ref": {
                        "exclude": [
                            "refs/pull/**",
                            "refs/tags/**",
                        ],
                    },
                },
            },
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/pull/**",
            ],
        },
    }

    pipelines.append(result)

    return pipelines

def buildCacheWeb(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "cache-web",
        "workspace": {
            "base": dir["base"],
            "path": config["app"],
        },
        "steps": skipIfUnchanged(ctx, "cache") +
                 restoreBuildArtifactCache(ctx, "pnpm", ".pnpm-store") +
                 [{
                     "name": "build-web",
                     "image": OC_CI_NODEJS,
                     "commands": [
                         "pnpm config set store-dir ./.pnpm-store",
                         "make dist",
                     ],
                 }] +
                 rebuildBuildArtifactCache(ctx, "web-dist", "dist"),
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def unitTests(ctx):
    sonar_env = {
        "SONAR_TOKEN": {
            "from_secret": "sonar_token",
        },
    }
    if ctx.build.event == "pull_request":
        sonar_env.update({
            "SONAR_PULL_REQUEST_BASE": "%s" % (ctx.build.target),
            "SONAR_PULL_REQUEST_BRANCH": "%s" % (ctx.build.source),
            "SONAR_PULL_REQUEST_KEY": "%s" % (ctx.build.ref.replace("refs/pull/", "").split("/")[0]),
        })

    repo_slug = ctx.build.source_repo if ctx.build.source_repo else ctx.repo.slug

    fork_handling = []
    if ctx.build.source_repo != "" and ctx.build.source_repo != ctx.repo.slug:
        fork_handling = [
            "git remote add fork https://github.com/%s.git" % (ctx.build.source_repo),
            "git fetch fork",
        ]

    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "unit-tests",
        "workspace": {
            "base": dir["base"],
            "path": config["app"],
        },
        "clone": {
            "disable": True,  # Sonarcloud does not apply issues on already merged branch
        },
        "steps": [
                     {
                         "name": "clone",
                         "image": ALPINE_GIT,
                         "commands": [
                                         # Always use the owncloud/web repository as base to have an up to date default branch.
                                         # This is needed for the skipIfUnchanged step, since it references a commit on master (which could be absent on a fork)
                                         "git clone https://github.com/%s.git ." % (ctx.repo.slug),
                                     ] + fork_handling +
                                     [
                                         "git checkout $DRONE_COMMIT",
                                     ],
                     },
                 ] +
                 skipIfUnchanged(ctx, "unit-tests") +
                 restoreBuildArtifactCache(ctx, "pnpm", ".pnpm-store") +
                 installPnpm() +
                 [
                     {
                         "name": "unit-tests",
                         "image": OC_CI_NODEJS,
                         "commands": [
                             "pnpm build:tokens",
                             "pnpm test:unit --coverage",
                         ],
                     },
                     {
                         "name": "sonarcloud",
                         "image": SONARSOURCE_SONAR_SCANNER_CLI,
                         "environment": sonar_env,
                     },
                 ],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def e2eTests(ctx):
    e2e_workspace = {
        "base": dir["base"],
        "path": config["app"],
    }

    e2e_volumes = [{
        "name": "uploads",
        "temp": {},
    }, {
        "name": "configs",
        "temp": {},
    }, {
        "name": "gopath",
        "temp": {},
    }]

    default = {
        "skip": False,
        "earlyFail": True,
        "logLevel": "2",
        "reportTracing": "false",
        "db": "mysql:5.5",
    }

    e2e_trigger = {
        "ref": [
            "refs/heads/master",
            "refs/heads/stable-*",
            "refs/tags/**",
            "refs/pull/**",
        ],
    }

    pipelines = []
    params = {}
    matrices = config["e2e"]

    for server, matrix in matrices.items():
        for item in default:
            params[item] = matrix[item] if item in matrix else default[item]

        if params["skip"]:
            continue

        if ("full-ci" in ctx.build.title.lower()):
            params["earlyFail"] = False

        if ("with-tracing" in ctx.build.title.lower()):
            params["reportTracing"] = "true"

        environment = {
            "HEADLESS": "true",
            "RETRY": "1",
            "REPORT_TRACING": params["reportTracing"],
        }

        services = []
        depends_on = []
        steps = skipIfUnchanged(ctx, "e2e-tests") + \
                restoreBuildArtifactCache(ctx, "pnpm", ".pnpm-store") + \
                restoreBuildArtifactCache(ctx, "playwright", ".playwright") + \
                installPnpm() + \
                restoreBuildArtifactCache(ctx, "web-dist", "dist") + \
                copyFilesForUpload()

        if server == "oC10":
            # oC10 specific environment variables
            environment["BASE_URL_OCC"] = "owncloud"

            # oC10 specific services
            services = databaseService(params["db"]) + owncloudService()

            # oC10 specific steps
            steps += installCore(params["db"]) + \
                     owncloudLog() + \
                     setupIntegrationWebApp() + \
                     setupServerAndAppsForIntegrationApp(params["logLevel"]) + \
                     setUpOauth2(True, True) + \
                     fixPermissions() + \
                     waitForOwncloudService()
        else:
            # oCIS specific environment variables
            environment["BASE_URL_OCIS"] = "ocis:9200"
            environment["OCIS"] = "true"
            environment["API_TOKEN"] = "true"

            # oCIS specific dependencies
            depends_on = ["cache-ocis"]

            # oCIS specific steps
            steps += setupServerConfigureWeb(params["logLevel"]) + \
                     restoreOcisCache() + \
                     ocisService() + \
                     getSkeletonFiles()

        steps += [{
                     "name": "e2e-tests",
                     "image": OC_CI_NODEJS,
                     "environment": environment,
                     "commands": [
                         "sleep 10 && pnpm test:e2e:cucumber tests/e2e/cucumber/**/*[!.%s].feature" % ("oc10" if server == "oCIS" else "ocis"),
                     ],
                 }] + \
                 uploadTracingResult(ctx) + \
                 publishTracingResult(ctx, "e2e-tests %s" % server)
        if (params["earlyFail"]):
            steps += buildGithubCommentForBuildStopped("e2e-ocis" if server == "oCIS" else "e2e-oc10")
        steps += githubComment("e2e-tests", server)
        if (params["earlyFail"]):
            steps += stopBuild()

        pipelines.append({
            "kind": "pipeline",
            "type": "docker",
            "name": "e2e-tests-%s" % server,
            "workspace": e2e_workspace,
            "steps": steps,
            "services": services,
            "depends_on": depends_on,
            "trigger": e2e_trigger,
            "volumes": e2e_volumes,
        })
    return pipelines

def acceptance(ctx):
    pipelines = []

    if "acceptance" not in config:
        return pipelines

    if type(config["acceptance"]) == "bool":
        if not config["acceptance"]:
            return pipelines

    errorFound = False

    default = {
        "servers": [OC10_VERSION],
        "browsers": ["chrome"],
        "databases": ["mysql:5.5"],
        "extraEnvironment": {},
        "cronOnly": False,
        "filterTags": "not @skip and not @skipOnOC10 and not @notToImplementOnOC10 and not @openIdLogin",
        "logLevel": "2",
        "notificationsAppNeeded": False,
        "federatedServerNeeded": False,
        "federatedServerVersion": OC10_VERSION,
        "runningOnOCIS": False,
        "screenShots": False,
        "openIdConnect": False,
        "oc10IntegrationAppIncluded": False,
        "skip": False,
        "debugSuites": [],
        "earlyFail": True,
        "retry": True,
    }

    if "defaults" in config:
        if "acceptance" in config["defaults"]:
            for item in config["defaults"]["acceptance"]:
                default[item] = config["defaults"]["acceptance"][item]

    for category, matrix in config["acceptance"].items():
        if type(matrix["suites"]) == "list":
            suites = {}
            for suite in matrix["suites"]:
                suites[suite] = suite
        else:
            suites = matrix["suites"]

        if "debugSuites" in matrix and len(matrix["debugSuites"]) != 0:
            if type(matrix["debugSuites"]) == "list":
                suites = {}
                for suite in matrix["debugSuites"]:
                    suites[suite] = suite
            else:
                suites = matrix["debugSuites"]

        for key, value in suites.items():
            if type(value) == "list":
                suite = value
                suiteName = key
                alternateSuiteName = key
            else:
                suite = key
                alternateSuiteName = value
                suiteName = value

            params = {}
            for item in default:
                params[item] = matrix[item] if item in matrix else default[item]

            if ("full-ci" in ctx.build.title.lower()):
                params["earlyFail"] = False

            for server in params["servers"]:
                for browser in params["browsers"]:
                    for db in params["databases"]:
                        if params["skip"]:
                            continue
                        federatedServerVersion = params["federatedServerVersion"]
                        federationDbSuffix = "-federated"

                        if params["federatedServerNeeded"] and getDbName(db) not in ["mariadb", "mysql"]:
                            errorFound = True

                        browserString = "" if browser == "" else "-" + browser
                        serverString = "" if server == "" else "-" + server.replace("daily-", "").replace("-qa", "")
                        name = "%s%s%s" % (suiteName, browserString, serverString)
                        maxLength = 50
                        nameLength = len(name)
                        if nameLength > maxLength:
                            print("Error: generated stage name of length", nameLength, "is not supported. The maximum length is " + str(maxLength) + ".", name)
                            errorFound = True

                        steps = []

                        # TODO: don't start services if we skip it -> maybe we need to convert them to steps
                        steps += skipIfUnchanged(ctx, "acceptance-tests")

                        if (params["oc10IntegrationAppIncluded"]):
                            steps += restoreBuildArtifactCache(ctx, "web-dist", "dist")
                        else:
                            steps += restoreBuildArtifactCache(ctx, "web-dist", "dist")
                            steps += setupServerConfigureWeb(params["logLevel"])

                        services = browserService(alternateSuiteName, browser) + middlewareService(params["runningOnOCIS"], params["federatedServerNeeded"])

                        if (params["runningOnOCIS"]):
                            # Services and steps required for running tests with oCIS
                            steps += restoreOcisCache() + ocisService() + getSkeletonFiles()

                        else:
                            # Services and steps required for running tests with oc10
                            services += databaseService(db) + owncloudService()

                            ## prepare oc10 server
                            if server == "":
                                server = False

                            steps += installCore(db) + owncloudLog()

                            if (params["oc10IntegrationAppIncluded"]):
                                steps += setupIntegrationWebApp()
                                steps += setupServerAndAppsForIntegrationApp(params["logLevel"])
                            else:
                                steps += setupServerAndApp(params["logLevel"])

                            if params["notificationsAppNeeded"]:
                                steps += setupNotificationsAppForServer()

                            if (params["openIdConnect"]):
                                ## Configure oc10 and web with openidConnect login
                                steps += setupGraphapiOIdC() + buildGlauth() + buildIdP() + buildOcisWeb()
                                steps += idpService() + ocisWebService() + glauthService()
                            else:
                                ## Configure oc10 and web with oauth2 and web Service
                                steps += setUpOauth2(params["oc10IntegrationAppIncluded"], True)

                                ## web service is not required for web-oc10-integration
                                if not params["oc10IntegrationAppIncluded"]:
                                    services += webService()

                            steps += fixPermissions()
                            steps += waitForOwncloudService()

                            if (params["federatedServerNeeded"]):
                                if federatedServerVersion == "":
                                    federatedServerVersion = False

                                # services and steps required to run federated sharing tests
                                steps += installFederatedServer(federatedServerVersion, db, federationDbSuffix) + setupFedServerAndApp(params["logLevel"])
                                steps += fixPermissionsFederated() + waitForOwncloudFederatedService() + owncloudLogFederated()

                                services += owncloudFederatedService() + databaseServiceForFederation(db, federationDbSuffix)

                        # Wait for test-related services to be up
                        steps += waitForBrowserService()
                        steps += waitForMiddlewareService()

                        # run the acceptance tests
                        steps += runWebuiAcceptanceTests(ctx, suite, alternateSuiteName, params["filterTags"], params["extraEnvironment"], params["screenShots"], params["retry"])

                        # Capture the screenshots from acceptance tests (only runs on failure)
                        if (params["screenShots"]):
                            steps += uploadScreenshots() + buildGithubComment(suiteName)

                        if (params["earlyFail"]):
                            steps += buildGithubCommentForBuildStopped(suiteName)

                        # Upload the screenshots to github comment
                        server_type = "oCIS" if params["runningOnOCIS"] else "oC10"
                        steps += githubComment("acceptance", server_type)

                        if (params["earlyFail"]):
                            steps += stopBuild()

                        result = {
                            "kind": "pipeline",
                            "type": "docker",
                            "name": name,
                            "workspace": {
                                "base": dir["base"],
                                "path": config["app"],
                            },
                            "steps": steps,
                            "services": services,
                            "trigger": {
                                "ref": [
                                    "refs/tags/**",
                                    "refs/pull/**",
                                ],
                            },
                            "volumes": [{
                                "name": "uploads",
                                "temp": {},
                            }, {
                                "name": "configs",
                                "temp": {},
                            }, {
                                "name": "gopath",
                                "temp": {},
                            }],
                        }

                        if params["runningOnOCIS"]:
                            result = pipelineDependsOn(result, cacheOcisPipeline(ctx))

                        for branch in config["branches"]:
                            result["trigger"]["ref"].append("refs/heads/%s" % branch)

                        if (params["cronOnly"]):
                            result["trigger"]["event"] = ["cron"]

                        pipelines.append(result)

    if errorFound:
        return False

    return pipelines

def notify():
    pipelines = []

    result = {
        "kind": "pipeline",
        "type": "docker",
        "name": "chat-notifications",
        "clone": {
            "disable": True,
        },
        "steps": [
            {
                "name": "notify-rocketchat",
                "image": PLUGINS_SLACK,
                "settings": {
                    "webhook": {
                        "from_secret": config["rocketchat"]["from_secret"],
                    },
                    "channel": config["rocketchat"]["channel"],
                },
            },
        ],
        "trigger": {
            "ref": [
                "refs/tags/**",
            ],
            "status": [
                "success",
                "failure",
            ],
        },
    }

    for branch in config["branches"]:
        result["trigger"]["ref"].append("refs/heads/%s" % branch)

    pipelines.append(result)

    return pipelines

def databaseServiceForFederation(db, suffix):
    dbName = getDbName(db)

    # only support mariadb, for web, it's not important to support others
    if dbName not in ["mariadb", "mysql"]:
        print("Not implemented federated database for", dbName)
        return []

    return [{
        "name": dbName + suffix,
        "image": db,
        "environment": {
            "MYSQL_USER": getDbUsername(db),
            "MYSQL_PASSWORD": getDbPassword(db),
            "MYSQL_DATABASE": getDbDatabase(db) + suffix,
            "MYSQL_ROOT_PASSWORD": getDbRootPassword(),
        },
    }]

def databaseService(db):
    dbName = getDbName(db)
    if (dbName == "mariadb") or (dbName == "mysql"):
        return [{
            "name": dbName,
            "image": db,
            "environment": {
                "MYSQL_USER": getDbUsername(db),
                "MYSQL_PASSWORD": getDbPassword(db),
                "MYSQL_DATABASE": getDbDatabase(db),
                "MYSQL_ROOT_PASSWORD": getDbRootPassword(),
            },
        }]

    if dbName == "postgres":
        return [{
            "name": dbName,
            "image": db,
            "environment": {
                "POSTGRES_USER": getDbUsername(db),
                "POSTGRES_PASSWORD": getDbPassword(db),
                "POSTGRES_DB": getDbDatabase(db),
            },
        }]

    if dbName == "oracle":
        return [{
            "name": dbName,
            "image": DEEPDIVER_DOCKER_ORACLE_XE_11G,
            "environment": {
                "ORACLE_USER": getDbUsername(db),
                "ORACLE_PASSWORD": getDbPassword(db),
                "ORACLE_DB": getDbDatabase(db),
                "ORACLE_DISABLE_ASYNCH_IO": "true",
            },
        }]

    return []

def browserService(alternateSuiteName, browser):
    if browser == "chrome":
        return [{
            "name": "selenium",
            "image": SELENIUM_STANDALONE_CHROME,
            "volumes": [{
                "name": "uploads",
                "path": "/uploads",
            }],
        }]

    if browser == "firefox":
        return [{
            "name": "selenium",
            "image": SELENIUM_STANDALONE_FIREFOX,
            "volumes": [{
                "name": "uploads",
                "path": "/uploads",
            }],
        }]

    return []

def waitForBrowserService():
    return [{
        "name": "wait-for-browser-service",
        "image": OC_CI_WAIT_FOR,
        "commands": [
            "wait-for -it selenium:4444 -t 300",
        ],
    }]

def owncloudService():
    return [{
        "name": "owncloud",
        "image": OC_CI_PHP,
        "environment": {
            "APACHE_WEBROOT": "%s/" % dir["server"],
            "APACHE_LOGGING_PATH": "/dev/null",
        },
        "command": [
            "/usr/local/bin/apachectl",
            "-D",
            "FOREGROUND",
        ],
    }]

def owncloudFederatedService():
    return [{
        "name": "federated",
        "image": OC_CI_PHP,
        "environment": {
            "APACHE_WEBROOT": "%s/" % dir["federated"],
            "APACHE_LOGGING_PATH": "/dev/null",
        },
        "command": [
            "/usr/local/bin/apachectl",
            "-D",
            "FOREGROUND",
        ],
    }]

def waitForOwncloudService():
    return [{
        "name": "wait-for-owncloud-service",
        "image": OC_CI_WAIT_FOR,
        "commands": [
            "wait-for -it owncloud:80 -t 300",
        ],
    }]

def waitForOwncloudFederatedService():
    return [{
        "name": "wait-for-owncloud-federated",
        "image": OC_CI_WAIT_FOR,
        "commands": [
            "wait-for -it federated:80 -t 300",
        ],
    }]

def getDbName(db):
    return db.split(":")[0]

def getDbUsername(db):
    name = getDbName(db)

    if name == "oracle":
        return "system"

    return "owncloud"

def getDbPassword(db):
    name = getDbName(db)

    if name == "oracle":
        return "oracle"

    return "owncloud"

def getDbRootPassword():
    return "owncloud"

def getDbDatabase(db):
    name = getDbName(db)

    if name == "oracle":
        return "XE"

    return "owncloud"

def installCore(db):
    host = getDbName(db)
    dbType = host

    username = getDbUsername(db)
    password = getDbPassword(db)
    database = getDbDatabase(db)

    if host == "mariadb":
        dbType = "mysql"

    if host == "postgres":
        dbType = "pgsql"

    if host == "oracle":
        dbType = "oci"

    stepDefinition = {
        "name": "install-core",
        "image": OC_CI_CORE_NODEJS,
        "settings": {
            "version": OC10_VERSION,
            "core_path": dir["server"],
            "db_type": dbType,
            "db_name": database,
            "db_host": host,
            "db_username": username,
            "db_password": password,
        },
    }

    return [stepDefinition]

def installFederatedServer(version, db, dbSuffix = "-federated"):
    host = getDbName(db)
    dbType = host

    username = getDbUsername(db)
    password = getDbPassword(db)
    database = getDbDatabase(db) + dbSuffix

    if host == "mariadb":
        dbType = "mysql"
    elif host == "postgres":
        dbType = "pgsql"
    elif host == "oracle":
        dbType = "oci"

    stepDefinition = {
        "name": "install-federated",
        "image": OC_CI_CORE_NODEJS,
    }
    if version:
        stepDefinition.update({"settings": {
            "version": version,
            "core_path": "%s/" % dir["federated"],
            "db_type": dbType,
            "db_name": database,
            "db_host": host + dbSuffix,
            "db_username": username,
            "db_password": password,
        }})
    else:
        stepDefinition.update({"settings": {
            "core_path": "%s/" % dir["federated"],
            "db_type": dbType,
            "db_name": database,
            "db_host": host + dbSuffix,
            "db_username": username,
            "db_password": password,
        }})
        stepDefinition.update({"commands": [
            "bash /usr/sbin/plugin.sh",
        ]})

    return [stepDefinition]

def installPnpm():
    return [{
        "name": "pnpm-install",
        "image": OC_CI_NODEJS,
        "environment": {
            "PLAYWRIGHT_BROWSERS_PATH": ".playwright",
        },
        "commands": [
            "pnpm config set store-dir ./.pnpm-store",
            "pnpm install",
        ],
    }]

def lint():
    return [{
        "name": "lint",
        "image": OC_CI_NODEJS,
        "commands": [
            "pnpm lint",
        ],
    }]

def setupIntegrationWebApp():
    return [{
        "name": "setup-web-integration-app",
        "image": OC_CI_PHP,
        "commands": [
            # copy web config
            "mkdir -p /srv/config",
            "cp -r %s/tests/drone /srv/config" % dir["web"],
            # setup web integration app
            "cd %s || exit" % dir["server"],
            "mkdir apps-external/web",
            "cp %s config/config.json" % dir["oc10IntegrationAppOauthConfig"],
            "cp %s/packages/web-integration-oc10/* apps-external/web -r" % dir["web"],
            "cp %s/dist/* apps-external/web -r" % dir["web"],
            "ls -la apps-external/web",
            "cat config/config.json",
        ],
        "volumes": [{
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def buildDockerImage():
    return [{
        "name": "docker",
        "image": PLUGINS_DOCKER,
        "settings": {
            "username": {
                "from_secret": "docker_username",
            },
            "password": {
                "from_secret": "docker_password",
            },
            "auto_tag": True,
            "dockerfile": "docker/Dockerfile",
            "repo": "owncloud/web",
        },
        "when": {
            "ref": {
                "exclude": [
                    "refs/pull/**",
                ],
            },
        },
    }]

def determineReleasePackage(ctx):
    if ctx.build.event != "tag":
        return None

    matches = [p for p in WEB_PUBLISH_NPM_PACKAGES if ctx.build.ref.startswith("refs/tags/%s-v" % p)]
    if len(matches) > 0:
        return matches[0]

    return None

def determineReleaseVersion(ctx):
    package = determineReleasePackage(ctx)
    if package == None:
        return ctx.build.ref.replace("refs/tags/v", "")

    return ctx.build.ref.replace("refs/tags/" + package + "-v", "")

def buildRelease(ctx):
    steps = []
    package = determineReleasePackage(ctx)
    version = determineReleaseVersion(ctx)

    if package == None:
        steps += [
            {
                "name": "make",
                "image": OC_CI_NODEJS,
                "commands": [
                    "cd %s" % dir["web"],
                    "make -f Makefile.release",
                ],
            },
            {
                "name": "changelog",
                "image": TOOLHIPPIE_CALENS,
                "commands": [
                    "calens --version %s -o dist/CHANGELOG.md -t changelog/CHANGELOG-Release.tmpl" % version.split("-")[0],
                ],
                "when": {
                    "ref": [
                        "refs/tags/**",
                    ],
                },
            },
            {
                "name": "publish",
                "image": PLUGINS_GITHUB_RELEASE,
                "settings": {
                    "api_key": {
                        "from_secret": "github_token",
                    },
                    "files": [
                        "release/*",
                    ],
                    "checksum": [
                        "md5",
                        "sha256",
                    ],
                    "title": ctx.build.ref.replace("refs/tags/v", ""),
                    "note": "dist/CHANGELOG.md",
                    "overwrite": True,
                },
                "when": {
                    "ref": [
                        "refs/tags/**",
                    ],
                },
            },
        ]
    else:
        steps += [
            {
                "name": "publish",
                "image": OC_CI_NODEJS,
                "environment": {
                    "NPM_TOKEN": {
                        "from_secret": "npm_token",
                    },
                },
                "commands": [
                    "echo " + package + " " + version,
                    "[ \"$(jq -r '.version'  < packages/%s/package.json)\" = \"%s\" ] || (echo \"git tag does not match version in packages/%s/package.json\"; exit 1)" % (package, version, package),
                    "git checkout .",
                    "git clean -fd",
                    "git diff",
                    "git status",
                    # until https://github.com/pnpm/pnpm/issues/5775 is resolved, we print pnpm whoami because that fails when the npm_token is invalid
                    "env \"npm_config_//registry.npmjs.org/:_authToken=$${NPM_TOKEN}\" pnpm whoami",
                    "env \"npm_config_//registry.npmjs.org/:_authToken=$${NPM_TOKEN}\" pnpm publish --no-git-checks --filter %s --access public --tag latest" % ("%s/%s" % (WEB_PUBLISH_NPM_ORGANIZATION, package)),
                ],
                "when": {
                    "ref": [
                        "refs/tags/**",
                    ],
                },
            },
        ]

    return steps

def documentation(ctx):
    return [
        {
            "kind": "pipeline",
            "type": "docker",
            "name": "documentation",
            "platform": {
                "os": "linux",
                "arch": "amd64",
            },
            "steps": [
                {
                    "name": "prepare",
                    "image": OC_CI_ALPINE,
                    "commands": [
                        "make docs-copy",
                    ],
                },
                {
                    "name": "test",
                    "image": OC_CI_HUGO,
                    "commands": [
                        "cd hugo",
                        "hugo",
                    ],
                },
                {
                    "name": "list",
                    "image": OC_CI_ALPINE,
                    "commands": [
                        "tree hugo/public",
                    ],
                },
                {
                    "name": "publish",
                    "image": PLUGINS_GH_PAGES,
                    "settings": {
                        "username": {
                            "from_secret": "github_username",
                        },
                        "password": {
                            "from_secret": "github_token",
                        },
                        "pages_directory": "docs/",
                        "copy_contents": "true",
                        "target_branch": "docs",
                    },
                    "when": {
                        "ref": {
                            "exclude": [
                                "refs/pull/**",
                            ],
                        },
                    },
                },
                {
                    "name": "downstream",
                    "image": PLUGINS_DOWNSTREAM,
                    "settings": {
                        "server": "https://drone.owncloud.com/",
                        "token": {
                            "from_secret": "drone_token",
                        },
                        "repositories": [
                            "owncloud/owncloud.github.io@main",
                        ],
                    },
                    "when": {
                        "ref": {
                            "exclude": [
                                "refs/pull/**",
                            ],
                        },
                    },
                },
            ],
            "trigger": {
                "ref": [
                    "refs/heads/master",
                    "refs/heads/stable-*",
                    "refs/pull/**",
                ],
            },
        },
    ]

def getSkeletonFiles():
    return [{
        "name": "setup-skeleton-files",
        "image": OC_CI_PHP,
        "commands": [
            "git clone https://github.com/owncloud/testing.git /srv/app/testing",
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }],
    }]

def webService():
    return [{
        "name": "web",
        "image": OC_CI_PHP,
        "environment": {
            "APACHE_WEBROOT": "%s/dist" % dir["web"],
            "APACHE_LOGGING_PATH": "/dev/null",
        },
        "commands": [
            "mkdir -p %s/dist" % dir["web"],
            "/usr/local/bin/apachectl -D FOREGROUND",
        ],
    }]

def setUpOauth2(forIntegrationApp, disableFileLocking):
    oidcURL = ""

    if (forIntegrationApp):
        oidcURL = "http://owncloud/index.php/apps/web/oidc-callback.html"
    else:
        oidcURL = "http://web/oidc-callback.html"

    commands = [
        "git clone -b master https://github.com/owncloud/oauth2.git %s/apps/oauth2" % dir["server"],
        "cd %s/apps/oauth2 || exit" % dir["server"],
        "make vendor",
        "cd %s || exit" % dir["server"],
        "php occ a:e oauth2",
        "php occ oauth2:add-client Web Cxfj9F9ZZWQbQZps1E1M0BszMz6OOFq3lxjSuc8Uh4HLEYb9KIfyRMmgY5ibXXrU 930C6aA0U1VhM03IfNiheR2EwSzRi4hRSpcNqIhhbpeSGU6h38xssVfNcGP0sSwQ %s false true" % oidcURL,
    ]

    if (disableFileLocking):
        commands.append("php occ config:system:set filelocking.enabled --value=false")

    return [{
        "name": "setup-oauth2",
        "image": OC_CI_PHP,
        "commands": commands,
    }]

def setupGraphapiOIdC():
    return [{
        "name": "setup-graphapi",
        "image": OC_CI_PHP,
        "commands": [
            "git clone -b master https://github.com/owncloud/graphapi.git %s/apps/graphapi" % dir["server"],
            "cd %s/apps/graphapi || exit" % dir["server"],
            "make vendor",
            "git clone -b master https://github.com/owncloud/openidconnect.git %s/apps/openidconnect" % dir["server"],
            "cd %s/apps/openidconnect || exit" % dir["server"],
            "make vendor",
            "cd %s || exit" % dir["server"],
            "php occ a:e graphapi",
            "php occ a:e openidconnect",
            "php occ config:system:set trusted_domains 2 --value=web",
            "php occ config:system:set openid-connect provider-url --value='https://idp:9130'",
            "php occ config:system:set openid-connect loginButtonName --value=OpenId-Connect",
            "php occ config:system:set openid-connect client-id --value=web",
            "php occ config:system:set openid-connect insecure --value=true --type=bool",
            "php occ config:system:set cors.allowed-domains 0 --value='http://web'",
            "php occ config:system:set memcache.local --value='\\\\OC\\\\Memcache\\\\APCu'",
            "php occ config:system:set web.baseUrl --value='http://web'",
            "php occ config:list",
        ],
    }]

def buildGlauth():
    return [{
        "name": "build-glauth",
        "image": OC_CI_GOLANG,
        "commands": [
            "cd /srv/app/src/github.com/owncloud/ocis/glauth || exit",
            # Fixme: Relies on an old ocis commit to provide oc10 tests with oidc
            "git checkout 761d72d901cce2c03b524d11cf0b169293e2c8cd",
            "make build",
            "cp bin/glauth %s" % dir["base"],
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def glauthService():
    return [{
        "name": "glauth",
        "image": OC_CI_GOLANG,
        "detach": True,
        "environment": {
            "GLAUTH_BACKEND_DATASTORE": "owncloud",
            "GLAUTH_BACKEND_BASEDN": "dc=example,dc=com",
        },
        "commands": [
            "cd %s" % dir["base"],
            "./glauth --log-level debug server --backend-server http://owncloud/",
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def buildIdP():
    return [{
        "name": "build-idp",
        "image": OC_CI_GOLANG,
        "commands": [
            "cd /srv/app/src/github.com/owncloud/ocis || exit",
            "cd idp || exit",
            "make build",
            "cp bin/idp %s" % dir["base"],
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def idpService():
    return [{
        "name": "idp",
        "image": OC_CI_GOLANG,
        "detach": True,
        "environment": {
            "LDAP_BASEDN": "dc=example,dc=com",
            "LDAP_BINDDN": "cn=admin,ou=users,dc=example,dc=com",
            "LDAP_URI": "ldap://glauth:9125",
            "IDP_IDENTIFIER_REGISTRATION_CONF": "%s" % dir["oc10IdentifierRegistrationConfig"],
            "IDP_ISS": "https://idp:9130",
            "LDAP_BINDPW": "admin",
            "LDAP_SCOPE": "sub",
            "LDAP_LOGIN_ATTRIBUTE": "uid",
            "LDAP_EMAIL_ATTRIBUTE": "mail",
            "LDAP_NAME_ATTRIBUTE": "givenName",
            "LDAP_UUID_ATTRIBUTE": "uid",
            "LDAP_UUID_ATTRIBUTE_TYPE": "text",
            "LDAP_FILTER": "(objectClass=posixaccount)",
        },
        "commands": [
            "cd %s" % dir["base"],
            "./idp  --log-level debug server --signing-kid gen1-2020-02-27",
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def ocisService():
    return [
        {
            "name": "ocis",
            "image": OC_CI_GOLANG,
            "detach": True,
            "environment": {
                "IDM_ADMIN_PASSWORD": "admin",  # override the random admin password from `ocis init`
                "IDP_IDENTIFIER_REGISTRATION_CONF": "%s" % dir["ocisIdentifierRegistrationConfig"],
                "OCIS_INSECURE": "true",
                "OCIS_LOG_LEVEL": "error",
                "OCIS_URL": "https://ocis:9200",
                "LDAP_GROUP_SUBSTRING_FILTER_TYPE": "any",
                "LDAP_USER_SUBSTRING_FILTER_TYPE": "any",
                "PROXY_ENABLE_BASIC_AUTH": True,
                "STORAGE_HOME_DRIVER": "ocis",
                "STORAGE_METADATA_DRIVER_OCIS_ROOT": "/srv/app/tmp/ocis/storage/metadata",
                "STORAGE_SHARING_USER_JSON_FILE": "/srv/app/tmp/ocis/shares.json",
                "STORAGE_USERS_DRIVER": "ocis",
                "STORAGE_USERS_DRIVER_LOCAL_ROOT": "/srv/app/tmp/ocis/local/root",
                "STORAGE_USERS_DRIVER_OCIS_ROOT": "/srv/app/tmp/ocis/storage/users",
                "STORAGE_USERS_DRIVER_OWNCLOUD_DATADIR": "%s" % dir["ocisRevaDataRoot"],
                "WEB_ASSET_PATH": "%s/dist" % dir["web"],
                "WEB_UI_CONFIG": "%s" % dir["ocisConfig"],
                "FRONTEND_SEARCH_MIN_LENGTH": "2",
                "FRONTEND_OCS_ENABLE_DENIALS": True,
            },
            "commands": [
                "cd %s" % dir["ocis"],
                "mkdir -p %s" % dir["ocisRevaDataRoot"],
                "mkdir -p /srv/app/tmp/ocis/storage/users/",
                "./ocis init",
                "./ocis server",
            ],
            "volumes": [{
                "name": "gopath",
                "path": dir["app"],
            }, {
                "name": "configs",
                "path": dir["config"],
            }],
        },
        {
            "name": "wait-for-ocis-server",
            "image": OC_CI_WAIT_FOR,
            "commands": [
                "wait-for -it ocis:9200 -t 300",
            ],
        },
    ]

def buildOcisWeb():
    return [{
        "name": "build-ocis-web",
        "image": OC_CI_GOLANG,
        "commands": [
            "cd /srv/app/src/github.com/owncloud/ocis || exit",
            "cd web || exit",
            "make build",
            "cp bin/web %s/ocis-web" % dir["base"],
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

# Ocis-web service just for the oc10 tests
def ocisWebService():
    return [{
        "name": "web",
        "image": OC_CI_GOLANG,
        "detach": True,
        "environment": {
            "WEB_UI_CONFIG": "%s" % dir["oc10OpenIdConfig"],
            "WEB_ASSET_PATH": "%s/dist" % dir["web"],
        },
        "commands": [
            "cd %s" % dir["base"],
            "./ocis-web --log-level debug server",
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def checkForExistingOcisCache(ctx):
    web_repo_path = "https://raw.githubusercontent.com/owncloud/web/%s" % ctx.build.commit
    return [
        {
            "name": "check-for-existing-cache",
            "image": OC_UBUNTU,
            "environment": minio_mc_environment,
            "commands": [
                "curl -o .drone.env %s/.drone.env" % web_repo_path,
                "curl -o check-oCIS-cache.sh %s/tests/drone/check-oCIS-cache.sh" % web_repo_path,
                ". ./.drone.env",
                "bash check-oCIS-cache.sh",
            ],
        },
    ]

def setupServerConfigureWeb(logLevel):
    return [{
        "name": "setup-server-configure-web",
        "image": OC_CI_PHP,
        "commands": [
            "cp %s dist/config.json" % dir["oc10OauthConfig"],
            "mkdir -p /srv/config",
            "cp -r %s/tests/drone /srv/config" % dir["web"],
            "ls -la /srv/config/drone",
        ],
        "volumes": [{
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def setupNotificationsAppForServer():
    return [{
        "name": "install-notifications-app-on-server",
        "image": OC_CI_PHP,
        "commands": [
            "mkdir -p %s/apps/" % dir["server"],
            "rm -rf %s/apps/notifications" % dir["server"],
            "git clone -b master https://github.com/owncloud/notifications.git %s/apps/notifications" % dir["server"],
            "cd %s || exit" % dir["server"],
            "php occ a:e notifications",
            "php occ a:l",
        ],
    }]

def setupServerAndAppsForIntegrationApp(logLevel):
    return [{
        "name": "setup-server-%s" % config["app"],
        "image": OC_CI_PHP,
        "commands": [
            "bash -x %s %s %s %s" % (dir["setupServerAndAppScript"], dir["server"], logLevel, "builtInWeb"),
        ],
    }]

def setupServerAndApp(logLevel):
    return [{
        "name": "setup-server-%s" % config["app"],
        "image": OC_CI_PHP,
        "commands": [
            "bash -x %s %s %s" % (dir["setupServerAndAppScript"], dir["server"], logLevel),
        ],
    }]

def setupFedServerAndApp(logLevel):
    return [{
        "name": "setup-fed-server-%s" % config["app"],
        "image": OC_CI_PHP,
        "commands": [
            "cd %s/ || exit" % dir["federated"],
            "php occ a:e testing",
            "php occ config:system:set trusted_domains 2 --value=federated",
            "php occ log:manage --level %s" % logLevel,
            "php occ config:list",
            "php occ config:system:set sharing.federation.allowHttpFallback --value=true --type=bool",
            "php occ config:system:set web.rewriteLinks --type=boolean --value=true",
        ],
    }]

def fixPermissions():
    return [{
        "name": "fix-permissions",
        "image": OC_CI_PHP,
        "commands": [
            "cd %s && chown www-data * -R" % dir["server"],
        ],
    }]

def fixPermissionsFederated():
    return [{
        "name": "fix-permissions-federated",
        "image": OC_CI_PHP,
        "commands": [
            "cd %s && chown www-data * -R" % dir["federated"],
        ],
    }]

def owncloudLog():
    return [{
        "name": "owncloud-log",
        "image": OC_UBUNTU,
        "detach": True,
        "commands": [
            "tail -f %s/data/owncloud.log" % dir["server"],
        ],
    }]

def owncloudLogFederated():
    return [{
        "name": "owncloud-federated-log",
        "image": OC_UBUNTU,
        "detach": True,
        "commands": [
            "tail -f %s/data/owncloud.log" % dir["federated"],
        ],
    }]

def copyFilesForUpload():
    return [{
        "name": "copy-files-for-upload",
        "image": OC_CI_PHP,
        "volumes": [{
            "name": "uploads",
            "path": "/filesForUpload",
        }],
        "commands": [
            "ls -la /filesForUpload",
            "cp -a %s/tests/e2e/filesForUpload/. /filesForUpload" % dir["web"],
            "ls -la /filesForUpload",
        ],
    }]

def runWebuiAcceptanceTests(ctx, suite, alternateSuiteName, filterTags, extraEnvironment, screenShots, retry):
    environment = {}
    if (filterTags != ""):
        environment["TEST_TAGS"] = filterTags

    environment["LOCAL_UPLOAD_DIR"] = "/uploads"
    if type(suite) == "list":
        paths = ""
        for path in suite:
            paths = paths + "features/" + path + " "
        environment["TEST_PATHS"] = paths
    elif (suite != "all"):
        environment["TEST_CONTEXT"] = suite

    if (ctx.build.event == "cron") or (not retry):
        environment["RERUN_FAILED_WEBUI_SCENARIOS"] = "false"
    if (screenShots):
        environment["SCREENSHOTS"] = "true"
    environment["SERVER_HOST"] = "http://web"
    environment["BACKEND_HOST"] = "http://owncloud"
    environment["COMMENTS_FILE"] = "%s" % dir["commentsFile"]
    environment["MIDDLEWARE_HOST"] = "http://middleware:3000"
    environment["REMOTE_UPLOAD_DIR"] = "/usr/src/app/filesForUpload"
    environment["WEB_UI_CONFIG"] = "%s/dist/config.json" % dir["web"]

    for env in extraEnvironment:
        environment[env] = extraEnvironment[env]

    return restoreBuildArtifactCache(ctx, "pnpm", ".pnpm-store") + [{
        "name": "webui-acceptance-tests",
        "image": OC_CI_NODEJS,
        "environment": environment,
        "commands": [
            "pnpm config set store-dir ./.pnpm-store",
            "pnpm install",  # FIXME: use --filter ./tests/acceptance (currently @babel/register is not found)
            "cd %s/tests/acceptance && ./run.sh" % dir["web"],
        ],
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "configs",
            "path": dir["config"],
        }],
    }]

def cacheOcisPipeline(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "cache-ocis",
        "workspace": web_workspace,
        "clone": {
            "disable": True,
        },
        "steps": checkForExistingOcisCache(ctx) +
                 buildOcis() +
                 cacheOcis(),
        "volumes": [{
            "name": "gopath",
            "temp": {},
        }],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def restoreOcisCache():
    return [{
        "name": "restore-ocis-cache",
        "image": MINIO_MC,
        "environment": minio_mc_environment,
        "commands": [
            ". ./.drone.env",
            "rm -rf %s" % dir["ocis"],
            "mkdir -p %s" % dir["ocis"],
            "mc alias set s3 $MC_HOST $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY",
            "mc cp -r -a s3/$CACHE_BUCKET/ocis-build/$OCIS_COMMITID/ocis %s" % dir["ocis"],
        ],
    }]

def buildOcis():
    ocis_repo_url = "https://github.com/owncloud/ocis.git"
    return [
        {
            "name": "clone-ocis",
            "image": OC_CI_GOLANG,
            "commands": [
                "source .drone.env",
                "cd $GOPATH/src",
                "mkdir -p github.com/owncloud",
                "cd github.com/owncloud",
                "git clone -b $OCIS_BRANCH --single-branch %s" % ocis_repo_url,
                "cd ocis",
                "git checkout $OCIS_COMMITID",
            ],
            "volumes": go_step_volumes,
        },
        {
            "name": "generate-ocis",
            "image": OC_CI_NODEJS,
            "commands": [
                # we cannot use the $GOPATH here because of different base image
                "cd /go/src/github.com/owncloud/ocis/",
                "retry -t 3 'make ci-node-generate'",
            ],
            "volumes": go_step_volumes,
        },
        {
            "name": "build-ocis",
            "image": OC_CI_GOLANG,
            "commands": [
                "source .drone.env",
                "cd $GOPATH/src/github.com/owncloud/ocis/ocis",
                "retry -t 3 'make build'",
                "mkdir -p %s/$OCIS_COMMITID" % dir["base"],
                "cp bin/ocis %s/$OCIS_COMMITID" % dir["base"],
            ],
            "volumes": go_step_volumes,
        },
    ]

def cacheOcis():
    return [{
        "name": "upload-ocis-cache",
        "image": MINIO_MC,
        "environment": minio_mc_environment,
        "commands": [
            ". ./.drone.env",
            "mc alias set s3 $MC_HOST $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY",
            "mc cp -r -a %s/$OCIS_COMMITID/ocis s3/$CACHE_BUCKET/ocis-build/$OCIS_COMMITID" % dir["base"],
            "mc ls --recursive s3/$CACHE_BUCKET/ocis-build",
        ],
    }]

def stopBuild():
    return [{
        "name": "stop-build",
        "image": DRONE_CLI_ALPINE,
        "environment": {
            "DRONE_SERVER": "https://drone.owncloud.com",
            "DRONE_TOKEN": {
                "from_secret": "drone_token",
            },
        },
        "commands": [
            "drone build stop owncloud/web ${DRONE_BUILD_NUMBER}",
        ],
        "when": {
            "status": [
                "failure",
            ],
            "event": [
                "pull_request",
            ],
        },
    }]

def uploadScreenshots():
    return [{
        "name": "upload-screenshots",
        "image": PLUGINS_S3,
        "pull": "if-not-exists",
        "settings": {
            "bucket": {
                "from_secret": "cache_public_s3_bucket",
            },
            "endpoint": {
                "from_secret": "cache_public_s3_server",
            },
            "path_style": True,
            "source": "%s/tests/acceptance/reports/screenshots/**/*" % dir["web"],
            "strip_prefix": "%s/tests/acceptance/reports/screenshots" % dir["web"],
            "target": "/${DRONE_REPO}/${DRONE_BUILD_NUMBER}/screenshots",
        },
        "environment": {
            "AWS_ACCESS_KEY_ID": {
                "from_secret": "cache_public_s3_access_key",
            },
            "AWS_SECRET_ACCESS_KEY": {
                "from_secret": "cache_public_s3_secret_key",
            },
        },
        "when": {
            "status": [
                "failure",
            ],
            "event": [
                "pull_request",
            ],
        },
    }]

def buildGithubComment(suite):
    return [{
        "name": "build-github-comment",
        "image": OC_UBUNTU,
        "commands": [
            "cd %s/tests/acceptance/reports/screenshots/" % dir["web"],
            'echo "<details><summary>:boom: The acceptance tests failed on retry. Please find the screenshots inside ...</summary>\\n\\n<p>\\n\\n" >> %s/comments.file' % dir["web"],
            'for f in *.png; do echo "### $f\n" \'!\'"[$f]($CACHE_ENDPOINT/$CACHE_BUCKET/${DRONE_REPO}/${DRONE_BUILD_NUMBER}/screenshots/$f) \n" >> %s/comments.file; done' % dir["web"],
            'echo "\n</p></details>" >> %s/comments.file' % dir["web"],
            "more %s/comments.file" % dir["web"],
        ],
        "environment": {
            "TEST_CONTEXT": suite,
            "CACHE_ENDPOINT": {
                "from_secret": "cache_public_s3_server",
            },
            "CACHE_BUCKET": {
                "from_secret": "cache_public_s3_bucket",
            },
        },
        "when": {
            "status": [
                "failure",
            ],
            "event": [
                "pull_request",
            ],
        },
    }]

def buildGithubCommentForBuildStopped(suite):
    return [{
        "name": "build-github-comment-buildStop",
        "image": OC_UBUNTU,
        "commands": [
            'echo ":boom: The %s tests pipeline failed. The build has been cancelled.\\n" >> %s/comments.file' % (suite, dir["web"]),
        ],
        "when": {
            "status": [
                "failure",
            ],
            "event": [
                "pull_request",
            ],
        },
    }]

def githubComment(alternateSuiteName, server_type = ""):
    prefix = "Results for <strong>%s %s</strong> ${DRONE_BUILD_LINK}/${DRONE_JOB_NUMBER}${DRONE_STAGE_NUMBER}/1" % (alternateSuiteName, server_type)
    return [{
        "name": "github-comment",
        "image": THEGEEKLAB_DRONE_GITHUB_COMMENT,
        "pull": "if-not-exists",
        "settings": {
            "message": "%s/comments.file" % dir["web"],
            "key": "pr-${DRONE_PULL_REQUEST}-%s" % server_type,  #TODO: we could delete the comment after a successful CI run
            "update": "true",
            "api_key": {
                "from_secret": "github_token",
            },
        },
        "commands": [
            "if [ -s %s ]; then echo '%s' | cat - comments.file > temp && mv temp comments.file && /bin/drone-github-comment; fi" % (dir["commentsFile"], prefix),
        ],
        "when": {
            "status": [
                "failure",
            ],
            "event": [
                "pull_request",
            ],
        },
    }]

def example_deploys(ctx):
    on_merge_deploy = [
        "ocis_web/latest.yml",
    ]
    nightly_deploy = [
        "ocis_web/daily.yml",
    ]

    # if on master branch:
    configs = on_merge_deploy
    rebuild = "false"

    if ctx.build.event == "tag":
        configs = nightly_deploy
        rebuild = "false"

    if ctx.build.event == "cron":
        configs = on_merge_deploy + nightly_deploy
        rebuild = "true"

    deploys = []
    for config in configs:
        deploys.append(deploy(ctx, config, rebuild))

    return deploys

def deploy(ctx, config, rebuild):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "deploy_%s" % (config),
        "platform": {
            "os": "linux",
            "arch": "amd64",
        },
        "steps": [
            {
                "name": "clone continuous deployment playbook",
                "image": ALPINE_GIT,
                "commands": [
                    "cd deployments/continuous-deployment-config",
                    "git clone https://github.com/owncloud-devops/continuous-deployment.git",
                ],
            },
            {
                "name": "deploy",
                "image": OC_CI_DRONE_ANSIBLE,
                "failure": "ignore",
                "environment": {
                    "CONTINUOUS_DEPLOY_SERVERS_CONFIG": "../%s" % (config),
                    "REBUILD": "%s" % (rebuild),
                    "HCLOUD_API_TOKEN": {
                        "from_secret": "hcloud_api_token",
                    },
                    "CLOUDFLARE_API_TOKEN": {
                        "from_secret": "cloudflare_api_token",
                    },
                },
                "settings": {
                    "playbook": "deployments/continuous-deployment-config/continuous-deployment/playbook-all.yml",
                    "galaxy": "deployments/continuous-deployment-config/continuous-deployment/requirements.yml",
                    "requirements": "deployments/continuous-deployment-config/continuous-deployment/py-requirements.txt",
                    "inventory": "localhost",
                    "private_key": {
                        "from_secret": "ssh_private_key",
                    },
                },
            },
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
            ],
        },
    }

def checkStarlark():
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "check-starlark",
        "steps": [
            {
                "name": "format-check-starlark",
                "image": OC_CI_BAZEL_BUILDIFIER,
                "commands": [
                    "buildifier --mode=check .drone.star",
                ],
            },
            {
                "name": "show-diff",
                "image": OC_CI_BAZEL_BUILDIFIER,
                "commands": [
                    "buildifier --mode=fix .drone.star",
                    "git diff",
                ],
                "when": {
                    "status": [
                        "failure",
                    ],
                },
            },
        ],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }]

def licenseCheck(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "license-check",
        "platform": {
            "os": "linux",
            "arch": "amd64",
        },
        "steps": [
            {
                "name": "pnpm-install",
                "image": OC_CI_NODEJS,
                "commands": [
                    "pnpm config set store-dir ./.pnpm-store",
                    "pnpm install",
                ],
            },
            {
                "name": "node-check-licenses",
                "image": OC_CI_NODEJS,
                "commands": [
                    "pnpm licenses:check",
                ],
            },
            {
                "name": "node-save-licenses",
                "image": OC_CI_NODEJS,
                "commands": [
                    "pnpm licenses:csv",
                    "pnpm licenses:save",
                ],
            },
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def middlewareService(ocis = False, federatedServer = False):
    environment = {
        "BACKEND_HOST": "https://ocis:9200" if ocis else "http://owncloud",
        "OCIS_REVA_DATA_ROOT": "/srv/app/tmp/ocis/storage/owncloud/",
        "RUN_ON_OCIS": "true" if ocis else "false",
        "REMOTE_UPLOAD_DIR": "/uploads",
        "NODE_TLS_REJECT_UNAUTHORIZED": "0",
        "MIDDLEWARE_HOST": "middleware",
        "TEST_WITH_GRAPH_API": "true" if ocis else "false",
    }

    if (federatedServer):
        environment["REMOTE_BACKEND_HOST"] = "http://federated"

    return [{
        "name": "middleware",
        "image": OC_TESTING_MIDDLEWARE,
        "environment": environment,
        "volumes": [{
            "name": "gopath",
            "path": dir["app"],
        }, {
            "name": "uploads",
            "path": "/uploads",
        }],
    }]

def waitForMiddlewareService():
    return [{
        "name": "wait-for-middleware-service",
        "image": OC_CI_WAIT_FOR,
        "commands": [
            "wait-for -it middleware:3000 -t 300",
        ],
    }]

def pipelineDependsOn(pipeline, dependant_pipelines):
    if "depends_on" in pipeline.keys():
        pipeline["depends_on"] = pipeline["depends_on"] + getPipelineNames(dependant_pipelines)
    else:
        pipeline["depends_on"] = getPipelineNames(dependant_pipelines)
    return pipeline

def pipelinesDependsOn(pipelines, dependant_pipelines):
    pipes = []
    for pipeline in pipelines:
        pipes.append(pipelineDependsOn(pipeline, dependant_pipelines))

    return pipes

def getPipelineNames(pipelines = []):
    """getPipelineNames returns names of pipelines as a string array

    Args:
      pipelines: array of drone pipelines

    Returns:
      names of the given pipelines as string array
    """
    names = []
    for pipeline in pipelines:
        names.append(pipeline["name"])
    return names

def skipIfUnchanged(ctx, type):
    if ("full-ci" in ctx.build.title.lower()):
        return []

    skip_step = {
        "name": "skip-if-unchanged",
        "image": OC_CI_DRONE_SKIP_PIPELINE,
        "when": {
            "event": [
                "pull_request",
            ],
        },
    }

    base_skip_steps = [
        "^.github/.*",
        "^changelog/.*",
        "^config/.*",
        "^deployments/.*",
        "^dev/.*",
        "^docs/.*",
        "^packages/web-app-skeleton/.*",
        "README.md",
    ]

    if type == "cache" or type == "lint":
        skip_step["settings"] = {
            "ALLOW_SKIP_CHANGED": base_skip_steps,
        }
        return [skip_step]

    if type == "acceptance-tests":
        acceptance_skip_steps = [
            "^__fixtures__/.*",
            "^__mocks__/.*",
            "^packages/.*/tests/.*",
            "^tests/e2e/.*",
            "^tests/unit/.*",
        ]
        skip_step["settings"] = {
            "ALLOW_SKIP_CHANGED": base_skip_steps + acceptance_skip_steps,
        }
        return [skip_step]

    if type == "e2e-tests":
        e2e_skip_steps = [
            "^__fixtures__/.*",
            "^__mocks__/.*",
            "^packages/.*/tests/.*",
            "^tests/acceptance/.*",
            "^tests/unit/.*",
        ]
        skip_step["settings"] = {
            "ALLOW_SKIP_CHANGED": base_skip_steps + e2e_skip_steps,
        }
        return [skip_step]

    if type == "unit-tests":
        unit_skip_steps = [
            "^tests/acceptance/.*",
        ]
        skip_step["settings"] = {
            "ALLOW_SKIP_CHANGED": base_skip_steps + unit_skip_steps,
        }
        return [skip_step]

    return []

def genericCache(name, action, mounts, cache_path):
    rebuild = "false"
    restore = "false"
    if action == "rebuild":
        rebuild = "true"
        action = "rebuild"
    else:
        restore = "true"
        action = "restore"

    step = {
        "name": "%s_%s" % (action, name),
        "image": PLUGINS_S3_CACHE,
        "settings": {
            "endpoint": {
                "from_secret": "cache_s3_endpoint",
            },
            "rebuild": rebuild,
            "restore": restore,
            "mount": mounts,
            "access_key": {
                "from_secret": "cache_s3_access_key",
            },
            "secret_key": {
                "from_secret": "cache_s3_secret_key",
            },
            "filename": "%s.tar" % (name),
            "path": cache_path,
            "fallback_path": cache_path,
        },
    }
    return step

def genericCachePurge(flush_path):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "purge_build_artifact_cache",
        "platform": {
            "os": "linux",
            "arch": "amd64",
        },
        "steps": [
            {
                "name": "purge-cache",
                "image": PLUGINS_S3_CACHE,
                "settings": {
                    "access_key": {
                        "from_secret": "cache_s3_access_key",
                    },
                    "endpoint": {
                        "from_secret": "cache_s3_endpoint",
                    },
                    "secret_key": {
                        "from_secret": "cache_s3_secret_key",
                    },
                    "flush": True,
                    "flush_age": 1,
                    "flush_path": flush_path,
                },
            },
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/stable-*",
                "refs/tags/**",
                "refs/pull/**",
            ],
            "status": [
                "success",
                "failure",
            ],
        },
    }

def genericBuildArtifactCache(ctx, name, action, path):
    if action == "rebuild" or action == "restore":
        cache_path = "%s/%s/%s" % ("cache", ctx.repo.slug, ctx.build.commit + "-${DRONE_BUILD_NUMBER}")
        name = "%s_build_artifact_cache" % (name)
        return genericCache(name, action, [path], cache_path)

    if action == "purge":
        flush_path = "%s/%s" % ("cache", ctx.repo.slug)
        return genericCachePurge(flush_path)
    return []

def restoreBuildArtifactCache(ctx, name, path):
    return [genericBuildArtifactCache(ctx, name, "restore", path)]

def rebuildBuildArtifactCache(ctx, name, path):
    return [genericBuildArtifactCache(ctx, name, "rebuild", path)]

def purgeBuildArtifactCache(ctx):
    return genericBuildArtifactCache(ctx, "", "purge", [])

def pipelineSanityChecks(ctx, pipelines):
    """pipelineSanityChecks helps the CI developers to find errors before running it

    These sanity checks are only executed on when converting starlark to yaml.
    Error outputs are only visible when the conversion is done with the drone cli.

    Args:
      ctx: drone passes a context with information which the pipeline can be adapted to
      pipelines: pipelines to be checked, normally you should run this on the return value of main()

    Returns:
      none
    """

    # check if name length of pipeline and steps are exceeded.
    max_name_length = 50
    for pipeline in pipelines:
        pipeline_name = pipeline["name"]
        if len(pipeline_name) > max_name_length:
            print("Error: pipeline name %s is longer than 50 characters" % (pipeline_name))

        for step in pipeline["steps"]:
            step_name = step["name"]
            if len(step_name) > max_name_length:
                print("Error: step name %s in pipeline %s is longer than 50 characters" % (step_name, pipeline_name))

    # check for non existing depends_on
    possible_depends = []
    for pipeline in pipelines:
        possible_depends.append(pipeline["name"])

    for pipeline in pipelines:
        if "depends_on" in pipeline.keys():
            for depends in pipeline["depends_on"]:
                if not depends in possible_depends:
                    print("Error: depends_on %s for pipeline %s is not defined" % (depends, pipeline["name"]))

    # check for non declared volumes
    for pipeline in pipelines:
        pipeline_volumes = []
        if "volumes" in pipeline.keys():
            for volume in pipeline["volumes"]:
                pipeline_volumes.append(volume["name"])

        for step in pipeline["steps"]:
            if "volumes" in step.keys():
                for volume in step["volumes"]:
                    if not volume["name"] in pipeline_volumes:
                        print("Warning: volume %s for step %s is not defined in pipeline %s" % (volume["name"], step["name"], pipeline["name"]))

    # list used docker images
    print("")
    print("List of used docker images:")

    images = {}

    for pipeline in pipelines:
        for step in pipeline["steps"]:
            image = step["image"]
            if image in images.keys():
                images[image] = images[image] + 1
            else:
                images[image] = 1

    for image in images.keys():
        print(" %sx\t%s" % (images[image], image))

def uploadTracingResult(ctx):
    status = ["failure"]
    if ("with-tracing" in ctx.build.title.lower()):
        status = ["failure", "success"]

    return [{
        "name": "upload-tracing-result",
        "image": PLUGINS_S3,
        "pull": "if-not-exists",
        "settings": {
            "bucket": {
                "from_secret": "cache_public_s3_bucket",
            },
            "endpoint": {
                "from_secret": "cache_public_s3_server",
            },
            "path_style": True,
            "source": "%s/reports/e2e/playwright/tracing/**/*" % dir["web"],
            "strip_prefix": "%s/reports/e2e/playwright/tracing" % dir["web"],
            "target": "/${DRONE_REPO}/${DRONE_BUILD_NUMBER}/tracing",
        },
        "environment": {
            "AWS_ACCESS_KEY_ID": {
                "from_secret": "cache_public_s3_access_key",
            },
            "AWS_SECRET_ACCESS_KEY": {
                "from_secret": "cache_public_s3_secret_key",
            },
        },
        "when": {
            "status": status,
            "event": [
                "pull_request",
                "cron",
            ],
        },
    }]

def publishTracingResult(ctx, suite):
    status = ["failure"]
    if ("with-tracing" in ctx.build.title.lower()):
        status = ["failure", "success"]

    return [{
        "name": "publish-tracing-result",
        "image": OC_UBUNTU,
        "commands": [
            "cd %s/reports/e2e/playwright/tracing/" % dir["web"],
            'echo "<details><summary>:boom: To see the trace, please open the link in the console ...</summary>\\n\\n<p>\\n\\n" >> %s/comments.file' % dir["web"],
            'for f in *.zip; do echo "#### npx playwright show-trace $CACHE_ENDPOINT/$CACHE_BUCKET/${DRONE_REPO}/${DRONE_BUILD_NUMBER}/tracing/$f \n" >> %s/comments.file; done' % dir["web"],
            'echo "\n</p></details>" >> %s/comments.file' % dir["web"],
            "more %s/comments.file" % dir["web"],
        ],
        "environment": {
            "TEST_CONTEXT": suite,
            "CACHE_ENDPOINT": {
                "from_secret": "cache_public_s3_server",
            },
            "CACHE_BUCKET": {
                "from_secret": "cache_public_s3_bucket",
            },
        },
        "when": {
            "status": status,
            "event": [
                "pull_request",
            ],
        },
    }]
