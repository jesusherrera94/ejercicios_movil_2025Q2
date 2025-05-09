
import 'package:flutter/material.dart';

enum Period { DAILY, WEEKLY, MONTHLY, YEARLY }

class Subscription {
  late String _id;
  late String _platformName;
  late int _renovationDate;
  late Period _renovationCycle;
  late double _charge;
  late String _userId;
  late IconData? _icon;

  Subscription({
    required String id,
    required String platformName,
    required int renovationDate,
    required Period renovationCycle,
    required double charge,
    required String userId
  }) {
    _id = id;
    _platformName = platformName;
    _renovationDate = renovationDate;
    _renovationCycle = renovationCycle;
    _charge = charge;
    _userId = userId;
  }

  String get id => _id;
  String get platformName => _platformName;
  int get renovationDate => _renovationDate;
  Period get renovationCiclye => _renovationCycle;
  double get charge => _charge;
  String get userId => _userId;
  IconData? get icon => _icon == null ? _icon :  Icons.calendar_view_month;
}