import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/event_model.dart';
import '../../repositories/database_helper.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  EventBloc() : super(EventLoading());

  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is CreateEvent) {
      yield* _mapCreateEventToState(event);
    } else if (event is ReadEvents) {
      yield* _mapReadEventsToState(event);
    } else if (event is UpdateEvent) {
      yield* _mapUpdateEventToState(event);
    } else if (event is DeleteEvent) {
      yield* _mapDeleteEventToState(event);
    }
  }

  Stream<EventState> _mapCreateEventToState(CreateEvent event) async* {
    await databaseHelper.createEvent(event.event);
    yield EventLoading();
    yield* _mapReadEventsToState(ReadEvents());
  }

  Stream<EventState> _mapReadEventsToState(ReadEvents event) async* {
    final List<EventModel> events = await databaseHelper.getAllEvents();
    yield EventLoaded(events);
  }

  Stream<EventState> _mapUpdateEventToState(UpdateEvent event) async* {
    await databaseHelper.updateEvent(event.event);
    yield EventLoading();
    yield* _mapReadEventsToState(ReadEvents());
  }

  Stream<EventState> _mapDeleteEventToState(DeleteEvent event) async* {
    await databaseHelper.deleteEvent(event.eventId);
    yield EventLoading();
    yield* _mapReadEventsToState(ReadEvents());
  }
}
