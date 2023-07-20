package com.xraph.plugin.flutter_unity_widget_example

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    // replicates mUnityPlayer like in UnityActivity, as AndroidJavaProxy expects it on the activity.
    @JvmField
    var mUnityPlayer: java.lang.Object? = null 
}
