// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import '../api/bg_service.dart';
import '../helper/dattime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> schedulingRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling restaurant');
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
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}