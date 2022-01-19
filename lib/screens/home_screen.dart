import 'dart:async';

import 'package:alarm_app/main.dart';
import 'package:alarm_app/screens/alarmScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'clockScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Timer.periodic(Duration(microseconds: 1), (timer) {
      setState(() {});
    });
    super.initState();

    var androidInitialize = new AndroidInitializationSettings('clock_icon');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        appBar: AppBar(
          toolbarHeight: 50.0,
          backgroundColor: Color(0xFF2D2F41),
          title: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
            ),
            child: Text(
              "My Alarm ",
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white38,
            unselectedLabelColor: Colors.white54,
            labelPadding: EdgeInsets.only(
              bottom: 10.0,
            ),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.access_alarm),
                text: "Clock",
              ),
              Tab(
                icon: Icon(Icons.alarm),
                text: "Alarm",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ClockScreen(),
            AlarmScreen(),
          ],
        ),
      ),
    );
  }
}
