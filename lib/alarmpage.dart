import 'package:flutter/material.dart';
import 'package:flutter_ai_clock_project/local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

import 'another_page.dart';
import 'data.dart';
import 'main.dart';
import 'package:audioplayers/audioplayers.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

  bool _isSwitched = false; // Tracks the current state of the switch

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
  }

  // to listen to any notification clicked or not

  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AnotherPage(payload: event) ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alarm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    LocalNotifications.showSimpleNotification(
                        title: 'simple Notification',
                        body: 'This is a simple notification ',
                        payload: 'This is simple data');
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                )
              ],
            ),
            child: Card(
                color: Colors.white12, // Optional: Set card background color
                elevation: 5.0, // Adjust shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Override container's radius if needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '8:30 AM',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: true,
                            activeTrackColor: Colors.lightGreenAccent,
                            inactiveThumbColor: Colors.grey,
                            onChanged: (bool value) {},
                          ),
                        ],
                      ),
                      Text(
                        'Awake!',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
                // Your card content
                ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                )
              ],
            ),
            child: Card(
                color: Colors.white12, // Optional: Set card background color
                elevation: 5.0, // Adjust shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Override container's radius if needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '4:30 AM',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: _isSwitched,
                            activeTrackColor: Colors.lightGreenAccent,
                            inactiveThumbColor: Colors.grey,
                            onChanged: _toggleSwitch,
                          ),
                        ],
                      ),
                      Text(
                        'Office!',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
                // Your card content
                ),
          ),
          TextButton(
              onPressed: () {
                LocalNotifications.cancel(1);
              },
              child: const Text('Close Periodic Notifcations')),
          TextButton(
              onPressed: () {
                LocalNotifications.cancelAll();
              },
              child: const Text('Close Periodic Notifcations'))
        ],
      ),
    );
  }
}
