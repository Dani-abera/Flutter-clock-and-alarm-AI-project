import 'package:flutter/material.dart';
import 'package:flutter_ai_clock_project/local_notifications.dart';
import 'package:flutter_ai_clock_project/menu_info.dart';
import 'package:provider/provider.dart';
import 'enums.dart';
import 'homepage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI AlARM CLOCK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: HomePage(),
      ),
    );
  }
}
