import {
  NativeModules, Platform,
} from 'react-native'

const LINKING_ERROR =
  `The package '@txo/live-activity-countdown-react-native' doesn't seem to be linked. Make sure: \n\n${
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' })
  }- You rebuilt the app after installing the package\n` +
  '- You are not using Expo Go\n'

const LiveActivityCountdown = NativeModules.LiveActivityCountdown != null
  ? NativeModules.LiveActivityCountdown
  : new Proxy(
    {},
    {
      get () {
        throw new Error(LINKING_ERROR)
      },
    },
  )

export type LiveActivityConfig = {
  title: string,
  timerTitle: string,
  endDateTime: string | Date,
  timerColor?: string,
  imageName?: string,
}

export async function createLiveActivity (
  config: LiveActivityConfig,
): Promise<string | undefined> {
  if (Platform.OS === 'android') {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.warn('LiveActivityCountdown is not available on Android')
    }
    await Promise.resolve(undefined); return
  }
  const { title, timerTitle, endDateTime, timerColor, imageName } = config
  const secondsUntilEnd = Math.floor(
    (new Date(endDateTime).getTime() - new Date().getTime()) / 1000,
  )
  if (secondsUntilEnd < 0) {
    throw new Error('endDateTime must be in the future')
  }
  return LiveActivityCountdown.createLiveActivity({
    title,
    timerTitle,
    secondsUntilEnd,
    timerColor,
    imageName: imageName ?? null,
  })
}

export async function endLiveActivity (id: string): Promise<void> {
  if (Platform.OS === 'android') {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.warn('LiveActivityCountdown is not available on Android')
    }
    await Promise.resolve(undefined); return
  }
  return LiveActivityCountdown.endLiveActivity(id)
}

export async function getLiveActivities (): Promise<string[] | undefined> {
  if (Platform.OS === 'android') {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.warn('LiveActivityCountdown is not available on Android')
    }
    await Promise.resolve(undefined); return
  }
  return LiveActivityCountdown.getLiveActivities()
}
