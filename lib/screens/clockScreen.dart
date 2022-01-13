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
    var formattedTime = DateFormat("HH:mm").format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = "";
    if (!timeZoneString.startsWith("_")) offsetSign = "+";
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                formattedTime,
                style: TextStyle(color: Colors.white, fontSize: 64),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                formattedDate,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(child: ClockView()),
            SizedBox(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                "Time zone",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "UTC" + offsetSign + timeZoneString,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
