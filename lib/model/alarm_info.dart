class AlarmInfo {
  DateTime alarmDateTime;
  String description;
  bool isActive;

  AlarmInfo(this.alarmDateTime, {this.description});
}

List<AlarmInfo> alarm = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: "Office"),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: "School"),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: "Uni"),
];
