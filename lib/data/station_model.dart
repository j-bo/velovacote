import 'dart:convert';

List<StationModel> stationsFromJson(List<String> stationsId, String jsonStr) {
  var ret = List<StationModel>.empty(growable: true);
  for (Map station in jsonDecode(jsonStr)['data']['stations']) {
    if (stationsId.contains(station['station_id'])) {
      ret.add(StationModel(
          station['station_id'],
          station['num_bikes_available'],
          station['num_docks_available'] + station['num_bikes_available']));
    }
  }
  return ret;
}

class StationModel {
  StationModel(this.id, this.nAvailableBikes, this.nTotalDocks);
  String id;
  String name = "Station inconnue";
  int nAvailableBikes;
  int nTotalDocks;
}
