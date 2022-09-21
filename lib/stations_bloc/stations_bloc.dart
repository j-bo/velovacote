import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:velovacote/data/station_model.dart';
import 'package:velovacote/data/station_repository.dart';

part 'stations_event.dart';
part 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final StationRepository _stationRepository;
  final List<String> _watchedIds = ["3085", "3043", "3080", "3081"];

  StationsBloc(this._stationRepository) : super(StationsLoadingState()) {
    on<RefreshStationsEvent>((event, emit) async {
      emit(StationsLoadingState());
      try {
        var stations = await _stationRepository.getStations(_watchedIds);
        stations = await _stationRepository.updateStationsNames(stations);
        emit(StationsLoadedState(stations));
      } catch (e) {
        emit(StationsErrorState(e.toString()));
      }
    });
  }
}
