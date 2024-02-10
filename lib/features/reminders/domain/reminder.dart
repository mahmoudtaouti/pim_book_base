class Reminder {
  int? id;
  String title = '';
  String description = '';
  int? date;
  int? time;
  String? color;
  int? duration;
  int? dateCreated;
  int dateEdited;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    this.date,
    this.time,
    this.color,
    this.duration,
    this.dateCreated,
    required this.dateEdited,
  });

  Reminder._set(
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.color,
    this.duration,
    this.dateCreated,
    this.dateEdited,
  );

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder._set(
      map["id"],
      map["title"],
      map["description"],
      map["date"],
      map['time'],
      map['color'],
      map['duration'],
      map['dateCreated'],
      map['dateEdited'],
    );
  }

  static Map<String, dynamic> toMap(Reminder reminder) {
    return {
      "id": reminder.id,
      "title": reminder.title,
      "description": reminder.description,
      "date": reminder.date,
      "time": reminder.time,
      "color": reminder.color,
      "duration": reminder.duration,
      "dateCreated": reminder.dateCreated,
      "dateEdited": reminder.dateEdited,
    };
  }
}
