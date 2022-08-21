class PIMEvent{

  int? id;
  String title = "";
  String description = "";
  int? startDate;
  int? endDate;
  int color = 1;



  PIMEvent();
  PIMEvent.setWithId(this.id,this.title,this.description,this.startDate,this.endDate,this.color);
  PIMEvent.set(this.title,this.description,this.startDate,this.endDate,this.color);

  factory PIMEvent.fromMap(Map<String,dynamic> map){

    return PIMEvent.setWithId(
        map["id"],
        map["title"],
        map["description"],
        map["startDate"],
        map['endDate'],
        map['color']);
  }

  static Map<String,dynamic> toMap(PIMEvent event){
    Map<String,dynamic> map = {
      "id": event.id,
      "title" : event.title,
      "description" : event.description,
      "startDate" : event.startDate,
      "endDate" : event.endDate,
      "color"  : event.color
    };
    return map;
  }

  @override
  String toString() {
    return "Event{"
        " id : $id,"
        " title : $title,"
        " description : $description,"
        " startDate : $startDate,"
        " endDate : $endDate,"
        " color : $color"
        "}";
  }
}