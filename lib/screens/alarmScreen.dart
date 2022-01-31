import 'package:alarm_app/model/alarm_helper.dart';
import 'package:alarm_app/model/alarm_info.dart';
import 'package:alarm_app/widgets/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AlarmScreen extends StatefulWidget {
  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime _alarmTime;
  var textController;
  var db;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    db = AlarmHelper();
    loadAlarms();
    super.initState();
  }

  void loadAlarms() {
    db.getTodo();
    if (mounted) setState(() {});
  }

  Future showNotification(DateTime time, AlarmInfo alarmInfo) async {
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

    // ignore: deprecated_member_use
    flutterLocalNotificationsPlugin.schedule(
      1,
      alarmInfo.title,
      "Time to " + alarmInfo.title,
      time,
      generalNotificationDetails,
    );
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      title: textController,
      isPending: 1  ,
      alarmDateTime: scheduleAlarmDateTime,
    );
    db.insertTodo(alarmInfo);
    showNotification(scheduleAlarmDateTime, alarmInfo);
    //Navigator.pop(context);
    loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color(0xFF2D2F41),
      body: Container(
        child: FutureBuilder(
          future: db.getTodo(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var data = snapshot.data;
            var dataLength = data.length;
            return dataLength == 0
                ? const Center(
                    child: Text(
                      "No data found",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: dataLength,
                    itemBuilder: (context, index) => AlarmCard(
                      id: data[index].id,
                      title: data[index].title,
                      isPending: data[index].isPending,
                      alarmDateTime: data[index].alarmDateTime,
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            useRootNavigator: true,
            isDismissible: true,
            elevation: 50.0,
            context: context,
            backgroundColor: Color(0xFF2D2F41),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(32),
                //color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        setState(() {
                          final now = DateTime.now();
                          var selectedDateTime = DateTime(now.year, now.month,
                              now.day, selectedTime.hour, selectedTime.minute);
                          _alarmTime = selectedDateTime;
                        });
                      },
                      child: Container(
                        //color: Colors.white,
                        /*margin: EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),*/
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Center(
                          child: Text(
                            DateFormat('HH:mm').format(_alarmTime).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      title: Text('Repeat'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      title: Text('Sound'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),*/
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        //controller: textController,
                        onSubmitted: (value) {
                          setState(() {
                            textController = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'add title',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      onPressed: onSaveAlarm,
                      icon: Icon(
                        Icons.alarm,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
