


import 'alarm_info.dart';
import 'enums.dart';
import 'menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,title: 'Clock', imageSource: 'images/icons8-clock-48.png'),
  MenuInfo(MenuType.alarm,title: 'Alarm', imageSource: 'images/icons8-clock-48.png'),

];

List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: 'Office'),
  AlarmInfo(DateTime.now().add(Duration(hours: 2)), description: 'Sport'),
];