import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technewz/components/serachbar.dart';
import 'package:technewz/utils/key.dart';


Future<List> fetchnews({required String query}) async {
  final query = Searchbar.searchcontroller.text;
  final url = Uri.parse(
    'https://newsapi.org/v2/top-headlines?country=us&pageSize=100&apiKey=${Apikey.key}&q=$query',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> result = jsonDecode(response.body);

    if (result['status'] == 'ok' && result['articles'] != null) {
      return result['articles'];
    } else {
      throw Exception('Failed to load articles: ${result['message'] ?? "Unknown error"}');
    }
  } else {
    throw Exception('HTTP Error: ${response.statusCode}');
  }
}
