import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velovacote/data/station_model.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class StationRepository {
  final String _url =
      'https://transport.data.gouv.fr/gbfs/lyon/station_status.json';

  Future<List<StationModel>> getStations(List<String> stationsIds) async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      return stationsFromJson(stationsIds, response.body);
    } else {
      throw Exception("Failed to load stations");
    }
  }

  Future<List<StationModel>> updateStationsNames(
      List<StationModel> stations) async {
    String data = await DefaultAssetBundle.of(
            NavigationService.navigatorKey.currentContext!)
        .loadString("assets/station_information.json");
    for (var ref in jsonDecode(data)['data']['stations']) {
      for (StationModel station in stations) {
        if (ref['station_id'] == station.id) {
          station.name = ref['name'].substring(ref['name'].indexOf('-') + 1);
        }
      }
    }
    return stations;
  }
}
