import 'package:aliftech_test/core/logger.dart';
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
        await Future.delayed(const Duration(seconds: 2));

        await DatabaseHelper.instance.create(event.event);

        emit(SuccessEventState());
      } catch (e, s) {
        logger.e('Error during with createEvent $e $s');
        emit(ErrorEventState(e.toString()));
      }
    });

    on<FilterByDateEvent>((event, emit) async {
      emit(LoadingAllEventsState());
      try {
        await Future.delayed(const Duration(seconds: 2));

        final allEvent = await DatabaseHelper.instance.filterByTime(time: event.dateTime);

        if (allEvent.isEmpty) {
          emit(EmptyEventState());
        } else {
          emit(LoadedAllEventState(allEvent));
        }
      } catch (e, s) {
        logger.e('Error during with readAll', e, s);
        emit(ErrorAllEventState());
      }
    });

    on<DeleteEvent>((event, emit) async {
      emit(DeletingEventState());
      try {
        await Future.delayed(const Duration(seconds: 2));

        await DatabaseHelper.instance.delete(event.eventId);
        emit(DeletedEventState());
      } catch (e, s) {
        logger.e('Error during with delete', e, s);
        emit(ErrorDeleteEventState());
      }
    });
  }
}
