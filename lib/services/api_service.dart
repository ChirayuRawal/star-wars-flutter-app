import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person_model.dart';

class ApiService {

  static const String baseUrl = "https://swapi.dev/api/people";

  Future<Map<String, dynamic>> fetchPeople(int page) async {

    final url = Uri.parse("$baseUrl?page=$page");

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final decoded = json.decode(response.body);

      List results = decoded['results'];

      List<Person> people =
      results.map((json) => Person.fromJson(json)).toList();

      return {
        "people": people,
        "next": decoded["next"]
      };

    } else {
      throw Exception("Failed to load data");
    }
  }
}