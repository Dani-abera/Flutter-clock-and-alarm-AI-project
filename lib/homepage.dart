import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ai_clock_project/enums.dart';
import 'package:flutter_ai_clock_project/menu_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'clock_view.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  String _currentTime = ''; // State variable to store current time
  String _currentDate = '';
  String _currentTime1 = '';

  @override
  void initState() {
    super.initState();
    _updateTime(); // Update time initially
    Timer.periodic(Duration(seconds: 1),
        (timer) => _updateTime()); // Schedule timer to update every second
  }

  @override
  void dispose() {
    super.dispose();
  }

  _updateTime() {
    setState(() {
      // Rebuild widget to update UI
      _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      _currentDate = DateFormat('EEE, d MM').format(DateTime.now());
      _currentTime1 = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType != MenuType.clock) return Container();
                return Column(
                  children: [
                    SizedBox(height: 25,),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: ClockView(
                        size: 300,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: screenWidth,
                      height: screenHeight / 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Set background color
                        border: Border.all(color: Colors.blueAccent, width: 5.0),
                        // Add border
                        borderRadius: BorderRadius.circular(15.0),
                        // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            offset: Offset(4.0, 4.0), // Shadow offset
                            blurRadius: 5.0, // Shadow blur radius
                          ),
                        ],
                      ),
                      child: Text(
                        _currentTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      _currentDate,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Zone',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0), // Add some vertical space
                            Row(
                              children: [
                                Icon(Icons.language),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('GMT +03:00 East Africa Time'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Use 24-hour format',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: true,
                                  // Current value of the switch (true or false)
                                  onChanged: (value) {
                                    // Callback function when switch is toggled
                                    setState(() {
                                      // Update state when switch changes
                                    });
                                  },
                                  // activeTrackColor: Colors.lightGreen, // Color of the active track (when on)
                                  // activeColor: Colors.green, // Color of the thumb (when on)
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0), // Add some vertical space
                            Text(_currentTime1),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },

            ),

            Divider(
              color: Colors.white54,
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 110,
              color: Colors.white54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuItems
                    .map((currentMenuInfo) => buildTextButton(currentMenuInfo))
                    .toList()),
              ),

          ],
        ),
      ),
    );
  }

  Padding buildTextButton(currentMenuInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<MenuInfo>(
        builder: (BuildContext context, MenuInfo value, Widget? child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor:currentMenuInfo.menuType == value.menuType? Colors.green: Colors.transparent,),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(

              children: [
                Image.asset(currentMenuInfo.imageSource, scale: 1.5,),
                Text(
                  currentMenuInfo.title ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),

          );
        },

      ),
    );
  }
}
