import React, {
  useCallback, useState,
} from 'react'
import {
  StyleSheet, View, Button,
} from 'react-native'
import { isNotEmptyString } from '@txo/functional'

import {
  createLiveActivity,
  endLiveActivity,
  getLiveActivities,
} from '../../lib'

export default function App (): JSX.Element {
  const [activityId, setActivityId] = useState<string | null>(null)

  const onStartLiveActivityPress = useCallback(() => {
    if (isNotEmptyString(activityId)) return
    void createLiveActivity({
      title: 'Test title',
      timerTitle: 'Remaining time',
      buttonTitle: 'Open App',
      endDateTime: new Date(Date.now() + 90 * 60 * 1000),
      timerColor: '#61dafb',
    }).then((id) => {
      if (isNotEmptyString(id)) {
        setActivityId(id)
      }
    })
  }, [activityId])

  const onEndLiveActivityPress = useCallback(() => {
    if (isNotEmptyString(activityId)) {
      void endLiveActivity(activityId)
      setActivityId(null)
    }
  }, [activityId])

  const onGetLiveActivitiesPress = useCallback(() => {
    // eslint-disable-next-line no-console
    void getLiveActivities().then((ids) => { console.log(ids) })
  }, [])

  return (
    <View style={styles.container}>
      <Button title="start live activity" onPress={onStartLiveActivityPress} />
      <Button title="stop live activity" onPress={onEndLiveActivityPress} />
      <Button title="get live activities" onPress={onGetLiveActivitiesPress} />
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
})
