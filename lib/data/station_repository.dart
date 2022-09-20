import 'package:velovacote/data/station_model.dart';
import 'package:http/http.dart' as http;

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
}
