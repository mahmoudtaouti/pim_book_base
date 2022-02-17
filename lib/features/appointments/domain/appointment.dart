class Appointment{
  int? id;
  String? title = "";
  String? description = "";
  String? apptDate ;
  String? apptTime;

  Appointment();

  Appointment.set(this.id,this.title,this.description,this.apptDate,this.apptTime);

  factory Appointment.fromMap(Map<String,dynamic> map){
    return Appointment.set(
        map["id"],
        map["title"],
        map["description"],
        map["apptDate"],
        map['apptTime']);
  }

  static Map<String,dynamic> toMap(Appointment appointment){
    Map<String,dynamic> map = {
      "id": appointment.id,
      "title" : appointment.title,
      "description" : appointment.description,
      "apptDate" : appointment.apptDate,
      "apptTime" : appointment.apptTime
    };
    return map;
  }

  @override
  String toString() {
    return "Appointment{"
        " id : $id,"
        " title : $title,"
        " description : $description,"
        " apptDate : $apptDate,"
        " apptTime : $apptTime"
        "}";
  }
}