import 'package:alarm_app/model/alarm_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AlarmCard extends StatefulWidget {
  final int id;
  final String title;
  final DateTime alarmDateTime;
  bool isPending;

  AlarmCard({
    Key key,
    this.id,
    this.title,
    this.alarmDateTime,
    this.isPending,
  }) : super(key: key);
  //final Function insertFunction;
  //final Function deleteFunction;
  @override
  _AlarmCardState createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  @override
  Widget build(BuildContext context) {
    var alarmTime = DateFormat('hh:mm aa').format(widget.alarmDateTime);
    return Container(
      height: 100.0,
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.white24],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            24.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Checkbox(
            value: widget.isPending,
            onChanged: (bool value) {},
          ),
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                alarmTime,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              var db = AlarmHelper();
              db.deleteTodo(widget.id);
            },
            icon: Icon(Icons.close),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
