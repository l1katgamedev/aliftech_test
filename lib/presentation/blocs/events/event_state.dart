part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class InitialEventState extends EventState {}

// Create Event State
class LoadingEventState extends EventState {}

class SuccessEventState extends EventState {}

class ErrorEventState extends EventState {
  final String? message;

  ErrorEventState(this.message);
}

// Get All Events State
class LoadingAllEventsState extends EventState {}

class EmptyEventState extends EventState {}

class LoadedAllEventState extends EventState {
  final List<DayEvent> eventList;

  LoadedAllEventState(this.eventList);
}

class ErrorAllEventState extends EventState {}

// Delete Event State
class DeletingEventState extends EventState {}

class DeletedEventState extends EventState {}

class ErrorDeleteEventState extends EventState {}
