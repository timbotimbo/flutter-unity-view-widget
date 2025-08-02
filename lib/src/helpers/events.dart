import 'package:flutter_unity_widget/src/helpers/types.dart';

class UnityEvent<T> {
  /// The ID of the Unity this event is associated to.
  final int unityId;

  /// The value wrapped by this event
  final T? value;

  /// Build a Unity Event, that relates a mapId with a given value.
  ///
  /// The `unityId` is the id of the map that triggered the event.
  /// `value` may be `null` in events that don't transport any meaningful data.
  UnityEvent(this.unityId, [this.value]);
}

class UnitySceneLoadedEvent extends UnityEvent<SceneLoaded?> {
  UnitySceneLoadedEvent(int unityId, SceneLoaded? value)
      : super(unityId, value);
}

class UnityLoadedEvent extends UnityEvent<void> {
  UnityLoadedEvent(int unityId) : super(unityId);
}

class UnityUnLoadedEvent extends UnityEvent<void> {
  UnityUnLoadedEvent(int unityId) : super(unityId);
}

class UnityCreatedEvent extends UnityEvent<void> {
  UnityCreatedEvent(int unityId) : super(unityId);
}

class UnityMessageEvent extends UnityEvent<dynamic> {
  UnityMessageEvent(int unityId, dynamic value) : super(unityId, value);
}
