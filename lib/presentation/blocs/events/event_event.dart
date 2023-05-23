part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class CreateEvent extends EventEvent {
  final DayEvent event;

  CreateEvent(this.event);
}

class FilterByDateEvent extends EventEvent {
  final String dateTime;

  FilterByDateEvent({required this.dateTime});
}

class UpdateEvent extends EventEvent {
  final DayEvent event;

  UpdateEvent(this.event);
}

class DeleteEvent extends EventEvent {
  final int? eventId;

  DeleteEvent(this.eventId);
}
