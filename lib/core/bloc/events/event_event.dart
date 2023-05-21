part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventCreateEvent extends EventEvent {}

class EventDeleteEvent extends EventEvent {}

class EventUpdateEvent extends EventEvent {}
