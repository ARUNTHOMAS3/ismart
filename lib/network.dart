import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://yourapiurl/api/YourEntity";

  Future<List<YourEntity>> fetchEntities() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => YourEntity.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load entities');
    }
  }

  Future<YourEntity> fetchEntity(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return YourEntity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load entity');
    }
  }

  Future<void> createEntity(YourEntity entity) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(entity.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create entity');
    }
  }

  Future<void> updateEntity(YourEntity entity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${entity.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(entity.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update entity');
    }
  }

  Future<void> deleteEntity(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete entity');
    }
  }
}

class YourEntity {
  final int id;
  final String name;

  YourEntity({required this.id, required this.name});

  factory YourEntity.fromJson(Map<String, dynamic> json) {
    return YourEntity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}