import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRepository {
  httpPost(
    String Url,
    dynamic data,
  ) async {
    var url = Uri.parse('http://192.168.29.170:3000/$Url');
    print('\x1b[97m URL : $url----$data');
    dynamic response = await http.post(
      url,
      body: data,
    );
    print('\x1b[97m response : ${response.body}');

    if (response.statusCode == 200 || response.statusCode == '200') {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  httpPatch(
    String Url,
    dynamic data,
  ) async {
    var url = Uri.parse('http://192.168.29.170:3000/$Url');
    print('\x1b[97m URL : $url----$data');
    dynamic response = await http.patch(
      url,
      body: data,
    );
    print('\x1b[97m response : ${response.body}');

    if (response.statusCode == 200 || response.statusCode == '200') {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  httpGet(
    String Url,
  ) async {
    var url = Uri.parse('http://192.168.29.170:3000/$Url');
    dynamic response = await http.get(url);

    print('\x1b[92m Dio get res : $response');

    if (response.statusCode == 200 || response.statusCode == '200') {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}
