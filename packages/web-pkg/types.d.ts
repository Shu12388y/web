import { Ability } from './src/utils'
import { ClientService, LoadingService, PreviewService } from './src/services'

export * from './src'

declare module 'vue' {
  interface ComponentCustomProperties {
    $ability: Ability
    $clientService: ClientService
    $loadingService: LoadingService
    $previewService: PreviewService
  }
}
