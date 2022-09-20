import 'dart:convert';

final Map<String, String> _stationNames = {
  "3085": "Sacré-Coeur",
  "3043": "Rouget de l'Isle",
  "3081": "Part-Dieu / Francfort",
  "3080": "Part-Dieu / Villette"
};

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
  StationModel(this.id, this.nAvailableBikes, this.nTotalDocks) {
    if (_stationNames.containsKey(id)) {
      name = _stationNames[id]!;
    }
  }
  String id;
  String name = "Station inconnue";
  int nAvailableBikes;
  int nTotalDocks;
}
