import {
  NativeModules, Platform,
} from 'react-native'

declare module 'react-native' {
  interface NativeModulesStatic {
    LiveActivityCountdown: {
      createLiveActivity: (config: LiveActivityNativeConfig) => Promise<string | undefined>,
      endLiveActivity: (id: string) => Promise<void>,
      getLiveActivities: () => Promise<string[] | undefined>,
    },
  }
}

const LINKING_ERROR =
  `The package '@txo/live-activity-countdown-react-native' doesn't seem to be linked. Make sure: \n\n${
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' })
  }- You rebuilt the app after installing the package\n` +
  '- You are not using Expo Go\n'

const LiveActivityCountdown = NativeModules.LiveActivityCountdown ?? new Proxy(
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
  buttonTitle: string,
  endDateTime: string | Date,
  timerColor?: string,
  imageName?: string,
}

type LiveActivityNativeConfig = Omit<LiveActivityConfig, 'endDateTime'> & {
  secondsUntilEnd: number,
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
  const {
    title,
    timerTitle,
    buttonTitle,
    endDateTime,
    timerColor,
    imageName,
  } = config
  const secondsUntilEnd = Math.floor(
    (new Date(endDateTime).getTime() - new Date().getTime()) / 1000,
  )
  if (secondsUntilEnd < 0) {
    throw new Error('endDateTime must be in the future')
  }
  return await LiveActivityCountdown.createLiveActivity({
    title,
    timerTitle,
    buttonTitle,
    secondsUntilEnd,
    timerColor,
    imageName: imageName ?? undefined,
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
  await LiveActivityCountdown.endLiveActivity(id)
}

export async function getLiveActivities (): Promise<string[] | undefined> {
  if (Platform.OS === 'android') {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.warn('LiveActivityCountdown is not available on Android')
    }
    await Promise.resolve(undefined); return
  }
  return await LiveActivityCountdown.getLiveActivities()
}
