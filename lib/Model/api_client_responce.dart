import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_responce_model.dart';

class ApiClientResponce {
  Future<Songs>? getUserDate() async {
    Uri url = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=4d9906716e9395ff40347ec9435b9262');
    var response = await http.get(url);

    var body = await jsonDecode(response.body);

    Songs users = Songs.fromJson(body);

    return users;
  }
}
