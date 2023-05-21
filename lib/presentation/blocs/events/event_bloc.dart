import 'dart:developer';

import 'package:aliftech_test/data/models/event_model.dart';
import 'package:aliftech_test/data/repositories/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(InitialEventState()) {
    on<CreateEvent>((event, emit) async {
      emit(LoadingEventState());
      try {
        await DatabaseHelper.instance.create(event.event);

        emit(SuccessEventState());
      } catch (e, s) {
        log('Error during createEvent $e $s');
        emit(ErrorEventState(e.toString()));
      }
    });

    on<ReadEvents>((event, emit) async {
      emit(LoadingAllEventsState());
      try {
        final allEvent = await DatabaseHelper.instance.readAll();

        emit(LoadedAllEventState(allEvent));
      } catch (e, s) {
        log('$e $s');
        emit(ErrorAllEventState());
      }
    });
  }
}
