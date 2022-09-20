part of 'stations_bloc.dart';

abstract class StationsState extends Equatable {}

class StationsLoadingState extends StationsState {
  @override
  List<Object?> get props => [];
}

class StationsLoadedState extends StationsState {
  final List<StationModel> stations;

  StationsLoadedState(this.stations);

  @override
  List<Object?> get props => [stations];
}

class StationsErrorState extends StationsState {
  final String error;

  StationsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
