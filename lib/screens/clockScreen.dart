import 'package:alarm_app/widgets/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat("HH:mm:ss").format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    /*setState(() {
      formattedTime = 
    });*/
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 64.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            formattedTime,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            formattedDate,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(
            height: 90.0,
          ),
          ClockView(),
        ],
      ),
    );
  }
}
