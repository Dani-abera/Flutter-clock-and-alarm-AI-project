import 'package:flutter/material.dart';

class AlarmInfo {
  DateTime? alarmDateTime;
  String? description;
  bool? isActive;

  AlarmInfo(this.alarmDateTime, {this.description});
}
