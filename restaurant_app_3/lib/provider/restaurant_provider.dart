import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api/apiservice.dart';
import '../model/restaurant_model.dart';

enum ResultState { loading, noData, hasData, error, noConnection }

class HomeProvider extends ChangeNotifier {
  final BuildContext context;
  final apiService = ApiService();

  String? _message;
  String? _query;
  ResultState? _state;
  RestaurantResult? _restoResult;

  String? get message => _message;
  String? get query => _query;
  ResultState? get state => _state;
  RestaurantResult? get result => _restoResult;

  HomeProvider(this.context) {
    _fetchRestoData();
  }
  void refresh() {
    _query = query;
    _fetchRestoData();
    notifyListeners();
  }

  void setQuery(String? query) {
    _query = query;
    _fetchRestoData();
    notifyListeners();
  }

  Future<dynamic> _fetchRestoData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        final restaurant = await getRestoData();
        if (restaurant.restaurants!.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restoResult = restaurant;
        }
      } else {
        _state = ResultState.noConnection;
        notifyListeners();
        return _message = "Tidak ada internet";
      }
    } on SocketException {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = "Tidak ada internet";
    }
  }

  Future<RestaurantResult> getRestoData() async {
    String? request;
    if (query == null || query == '') {
      request = ApiService.list;
    } else {
      request = ApiService.search + query!;
    }
    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Data gagal dimuat');
    }
  }
}
