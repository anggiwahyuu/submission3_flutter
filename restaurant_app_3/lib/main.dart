import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_2/ui/detail/detailpage.dart';
import 'package:restaurant_app_2/ui/favorite/favorite_page.dart';
import 'package:restaurant_app_2/ui/home/homepage.dart';
import 'package:restaurant_app_2/ui/search/search.dart';
import 'package:restaurant_app_2/ui/setting/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './api/bg_service.dart';
import './helper/db_helper.dart';
import './helper/notify_helper.dart';
import './helper/preferences_helper.dart';
import './provider/favorite_provider.dart';
import './provider/preferences_provider.dart';
import './provider/restaurant_provider.dart';
import './provider/scheduling_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(context),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child){
        return MaterialApp(
          title: 'Restaurants App',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          initialRoute: HomePage.route,
          routes: {
            SearchPage.route: (context) => const SearchPage(),
            HomePage.route: (context) => const HomePage(),
            DetailPage.route: (context) => DetailPage(
              id: ModalRoute.of(context)!.settings.arguments.toString(),
            ),
            SettingPage.route: (context) => const SettingPage(),
            FavoritePage.route: (context) => const FavoritePage(),
          },
        );
      },),
    );
  }
}
