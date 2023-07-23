package com.xraph.plugin.flutter_unity_widget_example

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.Keep;

class MainActivity: FlutterActivity() {

    // replicates mUnityPlayer like in UnityActivity, as AndroidJavaProxy expects it on the activity.
    @Keep @JvmField 
    var mUnityPlayer: java.lang.Object? = null 
}
