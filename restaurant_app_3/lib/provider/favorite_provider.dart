import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helper/db_helper.dart';
import '../model/restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  String? _message;
  String? _query;
  ResultState? _state;
  List<Restaurant> _favorites = [];

  String? get message => _message;
  String? get query => _query;
  ResultState? get state => _state;
  List<Restaurant> get favorites => _favorites;

  FavoriteProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  void _getFavorite() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      _favorites = await databaseHelper.getFavorite();
      if (_favorites.isNotEmpty) {
        _message = 'Data tidak ditemukan';
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
    }
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final bookmarkedArticle = await databaseHelper.getFavoriteById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void deleteFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
