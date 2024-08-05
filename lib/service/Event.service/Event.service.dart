
import 'dart:async';
import 'dart:ffi';

class EventService {
  final _eventController = StreamController<bool>();

  Stream<bool> get eventStream => _eventController.stream;

  void addEvent(bool event) {
    _eventController.add(event);
  }

  void dispose() {
    _eventController.close();
  }
}