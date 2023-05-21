part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<EventModel> events;

  EventLoaded(this.events);
}
