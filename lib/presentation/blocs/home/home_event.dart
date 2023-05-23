part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadEvents extends HomeEvent {}

class LoadMoreEvents extends HomeEvent {
  int currentPage = 1;
}
