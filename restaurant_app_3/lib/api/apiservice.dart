import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const list = baseUrl + 'list';
  static const detail = baseUrl + 'detail/';
  static const search = baseUrl + 'search?q=';

  static Future<RestaurantResult> getRestoData(query) async {
    String? request;
    if (query == null || query == '') {
      request = list;
    } else {
      request = search + query!;
    }
    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Data gagal dimuat',
      );
    }
  }

  static Future<DetailRestaurantResult> getRestoDetail(id) async {
    final response = await http.get(Uri.parse(detail + id!));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Data gagal dimuat',
      );
    }
  }

  Future<RestaurantResult> restaurantList(http.Client client) async {
    final response = await client.get(Uri.parse(list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Data gagal dimuat');
    }
  }
}
