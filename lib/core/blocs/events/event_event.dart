part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class CreateEvent extends EventEvent {
  final EventModel event;

  CreateEvent(this.event);
}

class ReadEvents extends EventEvent {}

class UpdateEvent extends EventEvent {
  final EventModel event;

  UpdateEvent(this.event);
}

class DeleteEvent extends EventEvent {
  final int eventId;

  DeleteEvent(this.eventId);
}
