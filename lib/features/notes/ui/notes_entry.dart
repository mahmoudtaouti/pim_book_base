import 'package:flutter/material.dart';
import 'package:pim_book/features/notes/data/notes_db_worker.dart';
import 'package:pim_book/features/notes/domain/notes_model.dart';
import 'package:provider/provider.dart';


class NotesEntry extends StatefulWidget {
  @override
  _NotesEntryState createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {

  late TextEditingController _titleTextEditingController;
  late TextEditingController _contentTextEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// save note to database and show snack bar
  /// and back to the list screen
  _save(BuildContext context,NotesModel model)async{
    if (!_formKey.currentState!.validate()) return;
    if (model.entityBeingEdited.id == null)  {
      await NotesDBWorker.instance.create(model.entityBeingEdited);
    } else{
      await NotesDBWorker.instance.update(model.entityBeingEdited);
    }
    model.loadData("notes", NotesDBWorker.instance);
    model.stackIndex = 0;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            content:Text("Note saved",style: TextStyle(
                color: Colors.greenAccent),
            )
        )
    );
  }



  @override
  void initState() {
    /// add listener to textField when ever the data changes
    /// we pass it to entity being edited
    _titleTextEditingController = TextEditingController();
    _contentTextEditingController= TextEditingController();
    _titleTextEditingController .addListener(() {
      Provider.of<NotesModel>(context,listen: false).entityBeingEdited.title = _titleTextEditingController.text;
    });
    _contentTextEditingController .addListener(() {
      Provider.of<NotesModel>(context,listen: false).entityBeingEdited.content = _contentTextEditingController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// case we entity being edited exist and we just wont to update it
    /// if entity being edited is a new note the title and content length is 0
    _titleTextEditingController.text = Provider.of<NotesModel>(context).entityBeingEdited.title;
    _contentTextEditingController.text = Provider.of<NotesModel>(context).entityBeingEdited.content;

    NotesModel notesModel = Provider.of<NotesModel>(context,listen: false);


    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              FocusScope.of(context).requestFocus(FocusNode());
              notesModel.stackIndex = 0;
            }, child: Text("cancel",style: TextStyle(fontSize: 18),)),
            TextButton(onPressed: (){
              _save(context,notesModel);
            }, child: Text("save",style: TextStyle(color: Colors.greenAccent,fontSize: 18),)),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _titleTextEditingController,
              decoration: InputDecoration(
                hintText: "title",
                prefixIcon: Icon(Icons.title),
              ),
              validator: (String? inValue){
                if (inValue!.length == 0) {
                  return "please enter a title";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contentTextEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "content",
                prefixIcon: Icon(Icons.content_paste),
              ),
              validator: (String? inValue){
                return null;
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens,),
              title: Row(children: [
                _ColorTent(color: Colors.redAccent, colorTxt: "red"),
                Spacer(),
                _ColorTent(color: Colors.greenAccent, colorTxt: "green"),
                Spacer(),
                _ColorTent(color: Colors.blueAccent, colorTxt: "blue"),
                Spacer(),
                _ColorTent(color: Colors.yellowAccent, colorTxt: "yellow"),
                Spacer(),
                _ColorTent(color: Colors.grey, colorTxt: "grey"),
                Spacer(),
                _ColorTent(color: Colors.indigo, colorTxt: "purple"),
              ],

              ),
            )
          ],
        ),
      ),
    );
  }
}


class _ColorTent extends StatelessWidget {
  const _ColorTent({Key? key, required this.color, required this.colorTxt})
      : super(key: key);


  final Color color;
  final String colorTxt;
  @override
  Widget build(BuildContext context) {
    NotesModel notesModel = Provider.of<NotesModel>(context,listen: false);
    return GestureDetector(
      onTap: (){
        notesModel.entityBeingEdited.color = colorTxt;
        notesModel.color = colorTxt;
      },
      child: Container(
        height: 30,width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: notesModel.color == colorTxt ? color : color.withOpacity(0.4),
        ),
      ),
    );
  }
}

