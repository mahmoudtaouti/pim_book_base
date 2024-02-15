import 'package:dartz/dartz.dart';
import '../../../core/domain/failures.dart';

class Note implements Comparable<Note> {

  int? id;
  String title = '';
  String content = '';
  String color;
  int dateCreated;
  int dateEdited;

  Note(
      {this.id,
      required this.title,
      required this.content,
      required this.color,
      required this.dateCreated,
      required this.dateEdited});

  Either<ValueFailure, Unit> isValid() {
    //TODO redo the validation
    if (title.isNotEmpty) {
      return right(unit);
    } else {
      return left(ValueFailure.notValidToSaveInDatabase());
    }
  }

  factory Note.fromMap(Map<String, dynamic> inMap) {
    return Note(
      id:inMap["id"],
      title:inMap["title"],
      content:inMap["content"],
      color:inMap["color"],
      dateCreated: inMap["dateCreated"] as int,
      dateEdited: inMap["dateEdited"] as int,
    );
  }

  Note updateData({
    String? title,
    String? content,
    String? color,
    int? dateEdited}){
    this.title = title ?? this.title;
    this.content = content ?? this.content;
    this.color = color ?? this.color;
    this.dateEdited = dateEdited ?? this.dateEdited;
    return this;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "content": content,
      "color": color,
      "dateCreated": dateCreated,
      "dateEdited": dateEdited,
    };
    return map;
  }

  @override
  String toString() {
    return '''
    {
      "id": $id,
      "title": "$title",
      "content": content,
      "color": "$color",
      "dateCreated": $dateCreated,
      "dateEdited": $dateEdited,
    }
    ''';
  }

  @override
  int compareTo(Note other) {
    if (dateEdited < other.dateEdited) {
      return -1;
    } else if (dateEdited > other.dateEdited) {
      return 1;
    } else {
      return 0;
    }
  }
}



// class Note {
//
//   int? id;
//   String title = '';
//   List<RichTextElement> content = [];
//   String? color;
//   int? dateCreated;
//   int dateEdited;
//
//   Note(this.dateEdited);
//   Note.set(this.id, this.title, this.content, this.color, this.dateCreated, this.dateEdited);
//
//   Either<ValueFailure, Unit> isValid() {
//     if (title.isNotEmpty || content.isNotEmpty) {
//       return right(unit);
//     } else {
//       return left(ValueFailure.notValidToSaveInDatabase());
//     }
//   }
//
//   factory Note.fromMap(Map<String, dynamic> inMap) {
//     return Note.set(
//       inMap["id"],
//       inMap["title"],
//       (jsonDecode(inMap["content"] ?? '[]') as List<dynamic>)
//           .map((e) => RichTextElement.fromMap(e))
//           .toList(),
//       inMap["color"],
//       inMap["dateCreated"] as int?,
//       inMap["dateEdited"] as int,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = {
//       "id": id,
//       "title": title,
//       "content": jsonEncode(content.map((element) => element.toMap()).toList()),
//       "color": color,
//       "dateCreated": dateCreated,
//       "dateEdited": dateEdited,
//     };
//     return map;
//   }
//
//   @override
//   String toString() {
//     return '''
//     {
//       "id": $id,
//       "title": "$title",
//       "content": ${jsonEncode(content.map((element) => element.toMap()).toList())},
//       "color": "$color",
//       "dateCreated": $dateCreated,
//       "dateEdited": $dateEdited,
//     }
//     ''';
//   }
// }