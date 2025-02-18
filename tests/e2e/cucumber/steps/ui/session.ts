import { Given, When, Then } from '@cucumber/cucumber'
import { World } from '../../environment'
import { config } from '../../../config'
import { objects } from '../../../support'

async function createNewSession(world: World, stepUser: string) {
  const { page } = await world.actorsEnvironment.createActor({
    key: stepUser,
    namespace: world.actorsEnvironment.generateNamespace(world.feature.name, stepUser)
  })
  return new objects.runtime.Session({ page })
}

async function LogInUser(this: World, stepUser: string): Promise<void> {
  const sessionObject = await createNewSession(this, stepUser)
  const { page } = this.actorsEnvironment.getActor({ key: stepUser })

  const user =
    stepUser === 'Admin'
      ? this.usersEnvironment.getUser({ key: stepUser })
      : this.usersEnvironment.getCreatedUser({ key: stepUser })

  await page.goto(config.frontendUrl)
  await sessionObject.login({ user })
  await page.locator('#web').waitFor()
}

Given('{string} has logged in', LogInUser)

When('{string} logs in', LogInUser)

async function LogOutUser(this: World, stepUser: string): Promise<void> {
  const actor = this.actorsEnvironment.getActor({ key: stepUser })
  const canLogout = !!(await actor.page.locator('#_userMenuButton').count())

  const sessionObject = new objects.runtime.Session({ page: actor.page })
  canLogout && (await sessionObject.logout())
  await actor.close()
}

Given('{string} has logged out', LogOutUser)

When('{string} logs out', LogOutUser)

Then('{string} fails to log in', async function (this: World, stepUser: string): Promise<void> {
  await createNewSession(this, stepUser)
  const { page } = this.actorsEnvironment.getActor({ key: stepUser })
  const user = this.usersEnvironment.getUser({ key: stepUser })

  await page.goto(config.frontendUrl)
  await page.locator('#oc-login-username').fill(user.id)
  await page.locator('#oc-login-password').fill(user.password)
  await page.locator('button[type="submit"]').click()
  await page.locator('#oc-login-error-message').waitFor()
})

When(
  '{string} logs in from the internal link',
  async function (this: World, stepUser: string): Promise<void> {
    const sessionObject = await createNewSession(this, stepUser)
    const { page } = this.actorsEnvironment.getActor({ key: stepUser })
    const user = this.usersEnvironment.getUser({ key: stepUser })
    await sessionObject.login({ user })
    await page.locator('#web').waitFor()
  }
)
