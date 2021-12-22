// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter_test/flutter_test.dart';

import '../lib/model/restaurant_detail_model.dart';

var restaurantTestParsing = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
  "city": "Medan",
  "address": "Jln. Pandeglang no 19",
  "pictureId": "14",
  "categories": [
    {
      "name": "Italia"
    },
    {
      "name": "Modern"
    }
  ],
  "menus": {
    "foods": [
      {
        "name": "Paket rosemary"
      },
      {
        "name": "Toastie salmon"
      }
    ],
    "drinks": [
      {
          "name": "Es krim"
      },
      {
        "name": "Sirup"
      }
    ]
  },
  "rating": 4.2,
  "customerReviews": [
    {
      "name": "Ahmad",
      "review": "Tidak rekomendasi untuk pelajar!",
      "date": "13 November 2019"
    }
  ]
};

void main() {
  group("Cek parsing json:", () {
    Restaurant resto;
    resto = Restaurant();

    test("Test parsing json", () {
      var idResult = Restaurant.fromJson(restaurantTestParsing).id;
      expect(idResult, "rqdv5juczeskfw1e867");
    });

    test("Data nama resto boleh null (nullsafety)", () {
      expect(resto.name, isNull);
    });

    test("Data deskripsi resto boleh null (nullsafety)", () {
      expect(resto.description, isNull);
    });

    test("Data kota resto boleh null (nullsafety)", () {
      expect(resto.city, isNull);
    });

    test("Data alamat resto boleh null (nullsafety)", () {
      expect(resto.address, isNull);
    });

    test("Cek list makanan, minuman, dan review", () {
      var drinks = Restaurant.fromJson(restaurantTestParsing).menus!.drinks;
      var foods = Restaurant.fromJson(restaurantTestParsing).menus!.foods;
      var reviews = Restaurant.fromJson(restaurantTestParsing).customerReviews;
      expect(drinks, isList);
      expect(foods, isList);
      expect(reviews, isList);
    });

    test("Rating harus positif dan tidak boleh lebih dari 5", () {
      resto.rating = 4.2;
      expect(resto.rating, isPositive);
      expect(resto.rating, inClosedOpenRange(0, 5));
    });
  });
}

