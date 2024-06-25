/* 
package com.unity3d.player

import android.content.Context
import android.widget.FrameLayout
import com.unity3d.player.IUnityPlayerLifecycleEvents
import com.unity3d.player.UnityPlayerForActivityOrService

public class CustomUnityPlayerForActivityOrService : UnityPlayerForActivityOrService {
    private val context: Context

    constructor(context: Context) : super(context) {
        this.context = context
    }

    constructor(context: Context, iUnityPlayerLifecycleEvents: IUnityPlayerLifecycleEvents) : super(context, iUnityPlayerLifecycleEvents) {
        this.context = context
    }

    override fun initialize(frameLayout: FrameLayout) {
        super.initialize(CustomUnityFrameLayout(frameLayout.context, this))
    }
}
*/