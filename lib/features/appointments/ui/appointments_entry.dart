import 'package:flutter/material.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';
import 'package:pim_book/features/appointments/domain/appointment.dart';
import 'package:pim_book/features/appointments/domain/appointments_model.dart';
import 'package:pim_book/core/utils.dart' as utils;
import 'package:provider/provider.dart';

class AppointmentsEntry extends StatefulWidget {
  AppointmentsEntry(){
    // _titleTextEditingController.addListener(() {
    //   appointmentsModel.entityBeingEdited.title =
    //       _titleTextEditingController.text;});
    // _descriptionTextEditingController.addListener(() {
    //   appointmentsModel.entityBeingEdited.description =
    //       _descriptionTextEditingController.text;});
  }

  @override
  _AppointmentsEntryState createState() => _AppointmentsEntryState();
}

class _AppointmentsEntryState extends State<AppointmentsEntry> {


  late TextEditingController _titleTextEditingController;
  late TextEditingController _descriptionTextEditingController;

  final GlobalKey<FormState> _formKey = GlobalKey();

  _save(BuildContext context , AppointmentsModel model)async{
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (model.entityBeingEdited.id == null)  {
      await AppointmentsDBWorker.instance.create(model.entityBeingEdited);
    } else{
      await AppointmentsDBWorker.instance.update(model.entityBeingEdited);
    }
    model.loadData("appointments", AppointmentsDBWorker.instance);
    model.stackIndex = 0;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            content:Text("appointment saved",style: TextStyle(
                color: Colors.greenAccent),
            )
        )
    );
    print("saved ${model.entityBeingEdited}");
  }


  @override
  void initState() {
    super.initState();
    _titleTextEditingController = TextEditingController();
    _descriptionTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentsModel appointmentsModel=  Provider.of<AppointmentsModel>(context,listen: false);


    _titleTextEditingController.text = appointmentsModel.entityBeingEdited.title;
    _descriptionTextEditingController.text = appointmentsModel.entityBeingEdited.description;

    return Scaffold(
      bottomNavigationBar:Padding(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              FocusScope.of(context).requestFocus(FocusNode());
              appointmentsModel.stackIndex = 0;
            }, child: Text("cancel",style: TextStyle(fontSize: 18),)),
            TextButton(onPressed: (){
              _save(context,appointmentsModel);
            }, child: Text("save",style: TextStyle(color: Colors.greenAccent,fontSize: 18),)),
          ],
        ),
      ),

      body: Form(
        key : _formKey,
        child: ListView(
          children: [
            TextFormField(
                onSaved: (String? value){
                  appointmentsModel.entityBeingEdited.title = value;
                },
                decoration: InputDecoration(
                    hintText: "Meeting : alphaTeam",
                    prefixIcon: Icon(Icons.short_text_rounded)
                ),
                validator: (String? inValue){
                  if (inValue!.length == 0) {
                    return "please enter a title";
                  }
                  return null;
                }
            ),

            TextFormField(
                onSaved: (String? value){
                  appointmentsModel.entityBeingEdited.description = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Yes! Finally",
                    prefixIcon: Icon(Icons.text_snippet_outlined)
                ),
            ),


            ListTile(
              leading: Icon(Icons.date_range),
              title: Text("Date"),
              subtitle: Text(
                  Provider.of<AppointmentsModel>(context).chosenDate == null ?
                  "" : Provider.of<AppointmentsModel>(context).chosenDate!),

              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: ()async{
                  FocusScope.of(context).requestFocus(FocusNode());
                  String chosenDate = await utils.selectDate(context, appointmentsModel, appointmentsModel.entityBeingEdited.apptDate);
                  appointmentsModel.entityBeingEdited.apptDate = chosenDate;

                },
              ),
            ),


            ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Time"),
              subtitle: Text(
                  Provider.of<AppointmentsModel>(context).apptTime == null ?
                  "" : Provider.of<AppointmentsModel>(context).apptTime!),

              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: ()async{
                  FocusScope.of(context).requestFocus(FocusNode());
                  String chosenTime = await utils.selectTime(context, appointmentsModel);
                  (appointmentsModel.entityBeingEdited as Appointment).apptTime = chosenTime;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
