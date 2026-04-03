Credits to [@jamesncl](https://github.com/jamesncl) here https://github.com/learntoflutter/flutter_embed_unity/pull/70

# Stub Unityframework

Swift Package Manager needs to link UnityFramework to compile the Swift code of this plugin.  
However UnityFramework is unique to your Unity project and can't be included in the Flutter plugin.

This directory contains a stub FrameWork to satisfy the Swift compiler.  
Your actual UnityFramework in Unity-iPhone will be linked when you build your app.


### UnityFramework.h
Copied from any Unity export folder `ios/unityLibrary/UnityFramework/UnityFramework.h`.

### libUnityFramework.a
An empty binary to make it a valid archive.

```bash
// empty c file
`echo "" > empty.c`

// create ARM64 libUnityFramework.a
clang -x c empty.c -target arm64-apple-ios12.0 -c -o stub_arm64.o
ar rcs libUnityFramework_device.a stub_arm64.o

// create arm64_x86-64-simulator libUnityFramework.a
clang -x c empty.c -target arm64-apple-ios12.0-simulator -c -o stub_sim_arm64.o
clang -x c empty.c -target x86_64-apple-ios12.0-simulator -c -o stub_sim_x86_64.o
lipo -create stub_sim_arm64.o stub_sim_x86_64.o -output libUnityFramework_simulator.a
```
