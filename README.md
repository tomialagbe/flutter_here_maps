# flutter_here_maps

A Flutter plugin that provides a Here Maps widget.

## Getting Started

```
git clone https://github.com/etzuk/flutter_here_maps.git
cd flutter_here_maps
flutter pub get
```

### Getting HERE maps keys.

To be able to show the HERE maps you must have appId, appCode and licenseKey
that could be generated by register [HERE developer site](developer.here.com).

### Set the keys.

#### iOS

1. Set your keys at example/ios/Runner/AppDelegate.swift by replacing appId, appCode and licenseKey
2. Add to embedded_views_preview info.plist:

```
<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

#### Android gradle.

1. copy HERE-sdk.aar to example/android/HERE-sdk/
2. Add your keys to manifest and service as described at [HereMaps guide](https://developer.here.com/documentation/android-premium/dev_guide/topics/app-create-simple.html)
3. Change the intent-filter in HereMaps Service to app package name.
