part of 'home_bloc.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<DayEvent> eventList;

  LoadedHomeState(this.eventList);
}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState(this.message);
}

class LoadingNewPageState extends HomeState {}

class SuccessNewPageState extends HomeState {
  final List<DayEvent> eventList;

  SuccessNewPageState(this.eventList);
}

class ErrorLoadNewPageState extends HomeState {
  final String message;

  ErrorLoadNewPageState(this.message);
}
