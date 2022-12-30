// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class GlobalApiScreen extends StatefulWidget {
  const GlobalApiScreen({Key? key}) : super(key: key);

  @override
  State<GlobalApiScreen> createState() => _GLoablApiScreenState();
}

class _GLoablApiScreenState extends State<GlobalApiScreen> {
  bool _showUnityWidget = false;
  StreamSubscription<EventDataPayload>? _eventStream;

  @override
  void initState() {
    _eventStream = FlutterUnityController.instance.stream.listen((event) {
      if (mounted) {
        //update state to possibly change the displayed values of isLoaded, isReady, etc.
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _eventStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global API Screen'),
      ),
      body: Stack(children: [
        Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              "Interact with a controller created on another page, or add a UnityWidget here.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        if (_showUnityWidget) UnityWidget(),
        Column(mainAxisSize: MainAxisSize.max, children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: FlutterUnityController.instance.isLoaded(),
                    builder: ((context, snapshot) {
                      return Text(
                          "Loaded: ${snapshot.data?.toString() ?? "null"}");
                    }),
                  ),
                  FutureBuilder(
                    future: FlutterUnityController.instance.isReady(),
                    builder: ((context, snapshot) {
                      return Text(
                          "Ready: ${snapshot.data?.toString() ?? "null"}");
                    }),
                  ),
                  FutureBuilder(
                    future: FlutterUnityController.instance.isPaused(),
                    builder: ((context, snapshot) {
                      return Text(
                          "Paused: ${snapshot.data?.toString() ?? "null"}");
                    }),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Card(
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        FlutterUnityController.instance.pause();
                        //manually update the paused text
                        setState(() {});
                      },
                      child: const Text("Pause"),
                    ),
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        FlutterUnityController.instance.resume();
                        //manually update the paused text
                        setState(() {});
                      },
                      child: const Text("Resume"),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        FlutterUnityController.instance.create();
                      },
                      child: const Text("Create"),
                    ),
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        FlutterUnityController.instance.unload();
                      },
                      child: const Text("Unload"),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        _setRotationSpeed("0.3");
                      },
                      child: const Text("Spin cube"),
                    ),
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        _setRotationSpeed("0");
                      },
                      child: const Text("Stop cube"),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: _toggleUntiy,
                        child: Text(
                            _showUnityWidget ? "Remove Unity" : "Add Unity"),
                      ),
                      MaterialButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () async {
                          await FlutterUnityController.instance
                              .openInNativeProcess();
                        },
                        child: const Text("Open Native"),
                      ),
                    ]),
              ],
            ),
          ),
        ]),
      ]),
    );
  }

  void _setRotationSpeed(String speed) {
    FlutterUnityController.instance.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  void _toggleUntiy() {
    if (mounted) {
      setState(() {
        _showUnityWidget = !_showUnityWidget;
      });
    }
  }
}
