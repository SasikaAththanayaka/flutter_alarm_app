import 'package:alarm_app/model/alarm_helper.dart';
import 'package:alarm_app/model/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  //Future<List<AlarmInfo>> _alarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDataBase().then((value) {
      print('------database intialized');
    });
    super.initState();
  }
/*
  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }*/

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID",
      "Alarm App",
      icon: "clock_icon",
      importance: Importance.max,
    );
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    /*await flutterLocalNotificationsPlugin.show(
      0,
      "OFFICE",
      "Time is to office",
      generalNotificationDetails,
    );*/
    var scheduledTime = DateTime.now().add(Duration(
      hours: 0,
      minutes: 0,
      seconds: 1,
    ));
    flutterLocalNotificationsPlugin.schedule(1, "OFFICE", "Time to office",
        scheduledTime, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color(0xFF2D2F41),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            //final AlarmInfo a = alarm[index];
            return Container(
              margin: const EdgeInsets.only(
                bottom: 5.0,
                left: 20.0,
                right: 20.0,
                top: 15.0,
              ),
              //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.black54],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    24.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.label,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "a.description",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Switch(
                        value: true,
                        activeColor: Colors.white,
                        onChanged: (bool value) {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Mon-Fri",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "7:00 PM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300),
                      ),
                      IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        focusElevation: 1.0,
        autofocus: false,
        backgroundColor: Colors.white54,
        onPressed: () {
          //showNotification();
          _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              final now = DateTime.now();
                              var selectedDateTime = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  selectedTime.hour,
                                  selectedTime.minute);
                              _alarmTime = selectedDateTime;
                              setModalState(() {
                                _alarmTimeString = selectedTime.toString();
                              });
                            }
                          },
                          child: Text(
                            _alarmTimeString,
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                        ListTile(
                          title: Text('Repeat'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        ListTile(
                          title: Text('Sound'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        ListTile(
                          title: Text('Title'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () async {
                            DateTime scheduleAlarmDateTime;
                            if (_alarmTime.isAfter(DateTime.now()))
                              scheduleAlarmDateTime = _alarmTime;
                            else
                              scheduleAlarmDateTime =
                                  _alarmTime.add(Duration(days: 1));

                            var alarmInfo = AlarmInfo(
                              alarmDateTime: scheduleAlarmDateTime,
                              title: 'alarm',
                            );
                            _alarmHelper.insertAlarm(alarmInfo);
                            // scheduleAlarm(
                            //     scheduleAlarmDateTime);
                          },
                          icon: Icon(Icons.alarm),
                          label: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
          // scheduleAlarm();
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 32.0,
        ),
      ),
    );
  }
}
