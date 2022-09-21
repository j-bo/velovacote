import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velovacote/data/station_model.dart';
import 'package:velovacote/stations_bloc/stations_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Scaffold(
          body: BlocBuilder<StationsBloc, StationsState>(
            builder: (context, state) {
              if (state is StationsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is StationsLoadedState) {
                return Center(
                    child: ListView.builder(
                  itemCount: state.stations.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return _stationCard(context, state.stations[index]);
                  }),
                ));
              }
              if (state is StationsErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Container();
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<StationsBloc>(context)
                  .add(RefreshStationsEvent());
            },
            child: const Icon(Icons.refresh),
          ),
        ),
        onRefresh: () async {
          BlocProvider.of<StationsBloc>(context).add(RefreshStationsEvent());
        });
  }

  Center _stationCard(context, StationModel station) {
    return Center(
        child: Card(
            elevation: 2,
            color: _getStationBgColor(station.nAvailableBikes),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: _getStationTextColor(station.nAvailableBikes),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: Text(
                    "${station.name} : ${station.nAvailableBikes}/${station.nTotalDocks}",
                    style: TextStyle(
                        fontSize: 19,
                        color: _getStationTextColor(station.nAvailableBikes)),
                  ),
                ))));
  }

  Color _getStationTextColor(int nAvailableBikes) {
    if (nAvailableBikes == 0) {
      return Colors.red;
    } else if (nAvailableBikes <= 2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Color _getStationBgColor(int nAvailableBikes) {
    if (nAvailableBikes == 0) {
      return Colors.red.shade100;
    } else if (nAvailableBikes <= 2) {
      return Colors.orange.shade100;
    } else {
      return Colors.green.shade100;
    }
  }
}
