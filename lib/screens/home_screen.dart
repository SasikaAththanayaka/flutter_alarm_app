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
          title: Text(
            "My Alarm ",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.only(
              bottom: 10.0,
            ),
            tabs: [
              Tab(
                icon: Image.asset(
                  "assets/clock_icon.png",
                  scale: 1.5,
                ),
                text: "Clock",
              ),
              Tab(
                  icon: Image.asset(
                    "assets/alarm_icon.png",
                    scale: 1.5,
                  ),
                  text: "Alarm"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ClockScreen(),
            Container(),
          ],
        ),
      ),
    );
  }
}
