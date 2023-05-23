import 'package:aliftech_test/core/logger.dart';
import 'package:aliftech_test/data/models/event_model.dart';
import 'package:aliftech_test/data/repositories/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<LoadEvents>((event, emit) async {
      emit(LoadingHomeState());
      try {
        await Future.delayed(const Duration(seconds: 2));

        final response = await DatabaseHelper.instance.readAll();

        emit(LoadedHomeState(response));
      } catch (e, s) {
        logger.e('Error during loading Events $e $s');
        emit(ErrorHomeState(e.toString()));
      }
    });
  }
}
