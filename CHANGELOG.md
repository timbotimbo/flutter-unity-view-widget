## 6000.1.0
> Includes the same changes as 2022.3.0
* [Web] Switch to `package:web` to support WebAssembly (WASM).
* Updates minimum supported SDK version to Flutter 3.16/Dart 3.2.
* Fix lint warnings to improve static analysis.
* Small ReadMe fixes.

## 6000.0.0
* Includes all fixes up to 2022.2.2.  

**Breaking changes**
* [Android] This plugin now requires an export from Unity 6000.0 or newer.   
  For Unity 2019.4-2022.3 use the latest 2022.x plugin.
* [Android] This plugin now requires Java 17 and Gradle 8.x.
* [Android] [iOS] Exports require unitypackage `fuw-6000.0.x` or newer.  
* Delete existing export folders like`android/unityLibrary` or `ios/UnityLibrary`when you upgrade your Unity version.

## 2022.3.0
* [Web] Switch to `package:web` to support WebAssembly (WASM).
* Updates minimum supported SDK version to Flutter 3.16/Dart 3.2.
* Fix lint warnings to improve static analysis.
* Small ReadMe fixes.

**Note:**  
> This release is unrelated to an old version `2022.3.0-alpha1` of `flutter_unity_widget`.


## 2022.2.2
* [Android] Fix touch detection when using Unity's New Input System. [#938](https://github.com/juicycleff/flutter-unity-view-widget/pull/938)
* [Android] Workaround for mUnityplayer error in Unity plugins using the AndroidJavaProxy. [#908](https://github.com/juicycleff/flutter-unity-view-widget/pull/908)
* [Android] Add namespace for Android gradle plugin (AGP) 8 compatibility.
* [Android] Fix kotlin compilation error with Flutter 3.24 and newer. [#973](https://github.com/juicycleff/flutter-unity-view-widget/issues/973)
* [Android] Update documentation for new `.gradle.kts` files.
* [Android] Update some ancient build.gradle values to match Unity 2022.3. Like CompileSdk to 34 and Java to 11.
* [iOS] Add an empty privacy manifest.
* [Web] Don't crash on unknown event data from Unity.
* Disable windows support in `pubspec.yaml` to avoid confusion. Windows support was never completed.

## 2022.2.1 and earlier

* See the original [flutter_unity_widget](https://pub.dev/packages/flutter_unity_widget) plugin for earlier versions up to 2022.2.1.