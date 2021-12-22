import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/apiservice.dart';
import '../model/restaurant_detail_model.dart';

enum ResultState { loading, noData, hasData, error, noConnection }

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetailProvider(this.context, {required this.id}) {
    _fetchRestoDetailData();
  }
  final String? id;
  final BuildContext? context;
  final apiService = ApiService();

  String? _message;
  ResultState? _state;
  DetailRestaurantResult? _detailRestaurantResult;

  String? get message => _message;
  ResultState? get state => _state;
  DetailRestaurantResult? get result => _detailRestaurantResult;

  Future<dynamic> _fetchRestoDetailData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        final restaurant = await getRestoDetail();
        if (restaurant.restaurant == null) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _detailRestaurantResult = restaurant;
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

  Future<DetailRestaurantResult> getRestoDetail() async {
    final response = await http.get(Uri.parse(ApiService.detail + id!));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Data gagal dimuat');
    }
  }

  void refresh() {
    _fetchRestoDetailData();
    notifyListeners();
  }
}
