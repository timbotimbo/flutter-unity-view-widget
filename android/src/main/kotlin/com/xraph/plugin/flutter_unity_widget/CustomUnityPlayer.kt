package com.xraph.plugin.flutter_unity_widget

import android.annotation.SuppressLint
import android.app.Activity
import android.content.res.Configuration
import android.util.Log
import android.view.InputDevice
import android.view.MotionEvent
import com.unity3d.player.IUnityPlayerLifecycleEvents
import com.unity3d.player.UnityPlayerForActivityOrService

import android.content.Context
import android.widget.FrameLayout


// https://docs.unity3d.com/2023.1/Documentation/Manual/UpgradeGuide20231.html#android-unityplayer
// https://github.com/azesmway/react-native-unity/blob/40279d78b61ea12ec1d3514b2b6d8fc72c95b3e3/android/src/main/java/com/azesmwayreactnativeunity/UPlayer.java#L21

@SuppressLint("NewApi")
class CustomUnityPlayer(context: Activity, upl: IUnityPlayerLifecycleEvents?) : UnityPlayerForActivityOrService(context, upl) {

    companion object {
        internal const val LOG_TAG = "CustomUnityPlayer"
    }

   override fun initialize(frameLayout: FrameLayout) {
        Log.i(LOG_TAG, "initialize")
        //super.initialize(CustomFrameLayout(frameLayout))
         super.initialize(frameLayout)
    }

    override fun configurationChanged(newConfig: Configuration?) {
        Log.i(LOG_TAG, "ORIENTATION CHANGED")
        super.configurationChanged(newConfig)
    }

}