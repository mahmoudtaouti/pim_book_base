class Note {

   int? id;
   String title;
   String content ;
   String color;

  @override
  String toString() => "{\nid : $id,\ntitle : $title,\ncontent : $content,\ncolor : $color\n}";


  //TODO : add valueObject so we can verify if the title not empty
  Note.set(this.title,this.content,this.color);
  Note.setWithId(this.id, this.title, this.content, this.color);
  
  factory Note.fromMap(Map<String,dynamic> inMap){
    return Note.setWithId(
        inMap["id"],
        inMap["title"],
        inMap["content"],
        inMap["color"]
    );
  }

   static Map<String,dynamic> toMap(Note note){
     Map<String,dynamic> map = {
       "id": note.id,
       "title" : note.title,
       "content" : note.content,
       "color" : note.color
     };
     return map;
   }


}