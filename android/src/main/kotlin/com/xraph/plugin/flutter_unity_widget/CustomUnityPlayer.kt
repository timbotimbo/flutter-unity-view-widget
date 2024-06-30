package com.xraph.plugin.flutter_unity_widget

import android.annotation.SuppressLint
import android.app.Activity
import android.content.res.Configuration
import android.util.Log
import com.unity3d.player.IUnityPlayerLifecycleEvents
import com.unity3d.player.UnityPlayerForActivityOrService

// https://docs.unity3d.com/2023.1/Documentation/Manual/UpgradeGuide20231.html#android-unityplayer
// https://github.com/azesmway/react-native-unity/blob/40279d78b61ea12ec1d3514b2b6d8fc72c95b3e3/android/src/main/java/com/azesmwayreactnativeunity/UPlayer.java#L21

@SuppressLint("NewApi")
class CustomUnityPlayer(context: Activity, upl: IUnityPlayerLifecycleEvents?) : UnityPlayerForActivityOrService(context, upl) {

    companion object {
        internal const val LOG_TAG = "CustomUnityPlayer"
    }
}