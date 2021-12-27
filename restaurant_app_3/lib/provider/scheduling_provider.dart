// ignore_for_file: avoid_print

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import '../api/bg_service.dart';
import '../helper/dattime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> schedulingRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling restaurant');
      print(_isScheduled);
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling restaurant canceled');
      print(_isScheduled);
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}