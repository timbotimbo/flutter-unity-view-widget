import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const String _prefix = "Menu:";
  bool _logControllers = false;

  StreamSubscription<UnityMessageEvent>? _messageStream;
  StreamSubscription<EventDataPayload>? _eventStream;

  final List<_MenuListItem> menus = [
    _MenuListItem(
      description: 'Simple demonstration of unity flutter library',
      route: '/simple',
      title: 'Simple Unity Demo',
    ),
    _MenuListItem(
      description: 'No interaction of unity flutter library',
      route: '/none',
      title: 'No Interaction Unity Demo',
    ),
    _MenuListItem(
      description: 'Unity load and unload unity demo',
      route: '/loader',
      title: 'Safe mode Demo',
    ),
    _MenuListItem(
      description:
          'This example shows various native API exposed by the library',
      route: '/api',
      title: 'Native exposed API demo',
      mobileOnly: true,
    ),
    _MenuListItem(
      title: 'Test Orientation',
      route: '/orientation',
      description: 'test orientation change',
      mobileOnly: true,
    ),
    _MenuListItem(
      title: 'Global Controller',
      route: '/global',
      description: 'Controller without a UnityWidget',
      mobileOnly: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
        actions: [
          Row(
            children: [
              if (!kIsWeb && !Platform.isWindows) ...[
                const Text("Log controllers"),
                Checkbox(
                  value: _logControllers,
                  onChanged: _toggleLogs,
                ),
              ],
            ],
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: menus.length,
          itemBuilder: (BuildContext context, int i) {
            // Hide menu options that are not relevant to the current platform.
            if ((kIsWeb || Platform.isWindows) && menus[i].mobileOnly) {
              return const SizedBox();
            } else {
              return ListTile(
                title: Text(menus[i].title),
                subtitle: Text(menus[i].description),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    menus[i].route,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelListeners();
    super.dispose();
  }

  void _toggleLogs(bool? changed) {
    if (changed != null) {
      if (changed) {
        _listenToControllers();
      } else {
        _cancelListeners();
      }
      setState(() {
        _logControllers = changed;
      });
    }
  }

  // Use the singleton to listen to any UnityController in the app
  void _listenToControllers() {
    if (kIsWeb || Platform.isWindows) {
      return;
    }
    //listen to any messages sent from Unity to Flutter
    _messageStream =
        FlutterUnityController.instance.onUnityMessage().listen((event) {
      if (!_logControllers) {
        return;
      }
      print('$_prefix Received message from unity: ${event.value.toString()}');
    });

    //Handle events from the UnityController
    _eventStream = FlutterUnityController.instance.stream.listen((event) {
      if (!_logControllers) {
        return;
      }

      switch (event.eventType) {
        case UnityEventTypes.OnUnityViewCreated:
          print('$_prefix Unity view created');
          break;
        case UnityEventTypes.OnUnityPlayerReInitialize:
          print('$_prefix Unity reinitialized');
          break;
        case UnityEventTypes.OnViewReattached:
          print('$_prefix Unity reattached');
          break;
        case UnityEventTypes.OnUnityPlayerCreated:
          print('$_prefix Unity player created');
          break;
        case UnityEventTypes.OnUnityPlayerUnloaded:
          print('$_prefix Unity player unloaded');
          break;
        case UnityEventTypes.OnUnityPlayerQuited:
          print('$_prefix Unity player quit');
          break;
        case UnityEventTypes.OnUnitySceneLoaded:
          SceneLoaded? sceneData;

          try {
            sceneData = SceneLoaded.fromMap(event.data);
          } catch (_) {
            sceneData = null;
          }
          if (sceneData != null) {
            print('$_prefix Unity scene loaded ${sceneData.buildIndex ?? ""}');
          } else {
            print('$_prefix Unknown scene loaded.');
          }
          break;
        case UnityEventTypes.OnUnityMessage:
          // ignore this one as we have a separate message stream
          break;
      }
    });
  }

  void _cancelListeners() {
    _messageStream?.cancel();
    _eventStream?.cancel();
  }
}

class _MenuListItem {
  final String title;
  final String description;
  final String route;
  final bool mobileOnly;

  _MenuListItem({
    required this.title,
    required this.description,
    required this.route,
    this.mobileOnly = false,
  });
}
