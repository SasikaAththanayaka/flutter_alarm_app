class AlarmInfo {
  int id;
  String title;
  int isPending;
  DateTime alarmDateTime;

  AlarmInfo({
    this.id,
    this.title,
    this.isPending,
    this.alarmDateTime,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "isPending": isPending,
        "alarmDateTime": alarmDateTime.toIso8601String(),
      };
  @override
  String toString() {
    return 'AlarmInfo(id:$id,title:$title,isChecked:$isPending,creationDate:$alarmDateTime)';
  }
}
