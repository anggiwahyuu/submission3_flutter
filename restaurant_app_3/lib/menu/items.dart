import 'package:flutter/material.dart';

import './menu_item.dart';

class Items{
  static const List<MenuItem> items = [
    itemFavorite,
    itemSetting
  ];

  static const itemSetting = MenuItem(
    text: "Settings",
    icon: Icons.settings,
  );

  static const itemFavorite = MenuItem(
    text: "Favorite",
    icon: Icons.favorite,
  );
}