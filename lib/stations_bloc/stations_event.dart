part of 'stations_bloc.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();

  @override
  List<Object> get props => [];
}

class RefreshStationsEvent extends StationsEvent {}
