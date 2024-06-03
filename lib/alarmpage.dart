import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'data.dart';
import 'main.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView(
          children: alarms.map<Widget>((alarm) {
            return Container(
              margin: const EdgeInsets.only(bottom: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellowAccent, Colors.redAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(4, 4)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.label,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Office',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Switch(
                        value: true,
                        onChanged: (bool value) {},
                        activeColor: Colors.white,
                      )
                    ],
                  ),
                  Text(
                    'Mon-Fri',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '07:00 AM',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 36,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            );
          }).followedBy(<Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Colors.blue,
              ),
              height: 100,
              child: TextButton(
                onPressed: () {
                  scheduleAlarm();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_alarm_sharp,
                      size: 50,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Add Alarm',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),

          ]).toList(),
        ),
      ),
    );
  }


  Future<void> scheduleAlarm() async {
    // Schedule notification 10 seconds from now
    var scheduledNotificationTime = DateTime.now().add(Duration(seconds: 10));

    // Create Android notification details with a valid icon reference
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'Alarm Notification', // More descriptive channel name
      channelDescription: 'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      // Assuming the image is named 'ic_alarm.png' in drawable
      sound: RawResourceAndroidNotificationSound('a_long_cold_string'),
      // String literal
      largeIcon: DrawableResourceAndroidBitmap(
          '@mipmap/ic_launcher'), // Assuming the image exists
    );

    // Create iOS notification details with a valid sound file path
    var iosPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'a_long_cold_string.wav',
      // Assuming the sound file is added to your Xcode project
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Combine platform-specific details for notification
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    // Schedule the notification with a title and body
    await flutterLocalNotificationsPlugin.show(
        0,
        'Alarm Notification', // Set a title for the notification
        'Alarm triggered!', // Set a body for the notification
        platformChannelSpecifics);
  }
}
