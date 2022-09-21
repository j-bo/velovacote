import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velovacote/data/station_repository.dart';
import 'package:velovacote/presentation/home.dart';

import 'stations_bloc/stations_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => StationRepository(),
        child: BlocProvider(
            create: (context) => StationsBloc(
                  RepositoryProvider.of<StationRepository>(context),
                )..add(RefreshStationsEvent()),
            child: MaterialApp(
                title: "Velo'v à coté",
                theme: ThemeData(useMaterial3: false),
                home: const Home(),
                navigatorKey: NavigationService.navigatorKey)));
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
