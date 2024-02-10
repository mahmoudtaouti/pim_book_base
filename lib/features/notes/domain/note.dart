import 'package:dartz/dartz.dart';
import '../../../core/domain/failures.dart';

class Note {

  int? id;
  String title = '';
  String content = '';
  String? color;
  int? dateCreated;
  int dateEdited;

  Note(this.dateEdited);
  Note.set(this.id, this.title, this.content, this.color, this.dateCreated, this.dateEdited);

  Either<ValueFailure, Unit> isValid() {
    if (title.isNotEmpty || content.isNotEmpty) {
      return right(unit);
    } else {
      return left(ValueFailure.notValidToSaveInDatabase());
    }
  }

  factory Note.fromMap(Map<String, dynamic> inMap) {
    return Note.set(
      inMap["id"],
      inMap["title"],
      inMap["content"],
      inMap["color"],
      inMap["dateCreated"] as int?,
      inMap["dateEdited"] as int,
    );
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