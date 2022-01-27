class AlarmInfo {
  int id;
  final String title;
  DateTime alarmDateTime;
  bool isPending;

  AlarmInfo({
    this.id,
    this.title,
    this.alarmDateTime,
    this.isPending,
  });

  /*factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
      );*/
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending ? 1 : 0,
      };
  @override
  String toString() {
    return 'AlarmInfo(id:$id,title:$title,creationDate:$alarmDateTime,isChecked:$isPending)';
  }
}
