

import 'package:flutter/material.dart';

enum Period { NONE, DAILY, WEEKLY, MONTHLY, YEARLY }

class Subscription {
  late String? _id; // firebase!
  late String _platformName; // netflix, spotify, copilot, yt premium, etc...
  late int _renovationDate; // fecha -> unix timestamp
  late Period _renovationCycle; // cada cuanto se paga la subscripcion, diarias, semanales, mensuales, anuales
  late double _charge; // dinero
  late String? _userId; // relacion a la tabla de usuarios
  IconData? _icon;

  Subscription({
     String? id,
    required String platformName,
    required int renovationDate,
    required Period renovationCycle,
    required double charge,
     String? userId
  }){
    _id = id;
    _platformName = platformName;
    _renovationDate = renovationDate;
    _renovationCycle = renovationCycle;
    _charge = charge;
    _userId = userId;
  }

  String get id => _id ?? '';
  String get platformName => _platformName;
  int get renovationDate => _renovationDate;
  Period get renovationCycle => _renovationCycle;
  double get charge => _charge;
  String get userId => _userId ?? '';
  IconData? get icon =>  _icon ??  Icons.calendar_view_month;

  set platformName(String name) {
    _platformName = name;
  }
  set renovationDate(int date) {
    _renovationDate = date;
  }
  set renovationCycle(Period cycle) {
    _renovationCycle = cycle;
  }
  set charge(double charge) {
    _charge = charge;
  }
  set userId(String id) {
    _userId = id;
  }
  set icon(IconData? icon) {
    _icon = icon;
  }


  Map<String, dynamic> toMap() {
    return {
      'platformName': _platformName,
      'renovationDate': _renovationDate,
      'renovationCycle': _renovationCycle.toString(),
      'charge': _charge,
      'userId': _userId,
    };
  }

  
}
