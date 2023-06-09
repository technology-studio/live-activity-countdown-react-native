# @txo/live-activity-countdown-react-native

A package for creating iOS Live Activity notification with simple countdown

![Image 1](images/1.png)
![Image 2](images/2.png)
![Image 3](images/3.png)

## Installation

### Install the package and pods
```sh
yarn add @txo/live-activity-countdown-react-native @txo/live-activity-countdown-view-react-native
npx pod-install
```

### Create a Widget Extension in your Xcode workspace
1. In Xcode: `File` > `New...` > `Target...`
2. Choose `Widget Extension`, add a name (e.g. `LiveActivityCountdown`) and make sure `Include Live Activity` is enabled
3. Remove `LiveActivityCountdown.swift` and `LiveActivityCountdownLiveActivity.swift` files
4. Import `LiveActivityCountdownView` and use `LiveActivityCountdownLiveActivity` from the package in `LiveActivityCountdownBundle.swift`
```diff
import WidgetKit
import SwiftUI
+ import LiveActivityCountdownView

@main
struct LiveActivityCountdownBundle: WidgetBundle {
  var body: some Widget {
-       LiveActivityCountdown()
        LiveActivityCountdownLiveActivity()
    }
}
```
5. Add `LiveActivityCountdownView` as pod to your Widget Extension by adding this code at the end of your `Podfile`
```ruby
target 'LiveActivityCountdownExtension' do
  pod 'LiveActivityCountdownView', :path => '../node_modules/@txo/live-activity-countdown-view-react-native'
end
```
6. Add `NSSupportsLiveActivities` key with value `YES` to Info.plist (More info [here](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities))

## Usage

- Add your app logo (or different image) to `Assets.xcassets` under name `AppLogoLiveActivity` in Widget Extension
  - for multiple images you can use custom names and then specify them in JS with `imageName` attribute

Code: 
```typescript
import { createLiveActivity } from '@txo/live-activity-countdown-react-native';

createLiveActivity({
  title: 'Test title',
  timerTitle: 'Remaining time',
  buttonTitle: 'Open App',
  endDateTime: '2022-12-31T12:00:00.000Z', // Date object can be used too
  timerColor: '#cccccc',
})
  .then((id: string) => {
    // store activity ID somewhere to use it for ending the Live Activity later
  })
```

## Caveats and notes
- When adding image, add lower resolutions - 150px is working fine for the logo (more info [here - Understand constraints paragraph](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities))

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
