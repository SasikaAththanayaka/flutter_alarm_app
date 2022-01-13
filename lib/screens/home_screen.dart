import 'package:alarm_app/screens/alarmScreen.dart';
import 'package:flutter/material.dart';

import 'clockScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        appBar: AppBar(
          toolbarHeight: 120.0,
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
            unselectedLabelColor: Colors.white54,
            labelPadding: EdgeInsets.only(
              bottom: 10.0,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.access_alarm),
                text: "Alarm",
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
