import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive/boxes/boxes.dart';
import 'package:note_app_hive/model/notes_model.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive note app"),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ValueListenableBuilder<Box<NotesModel>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              var data=box.values.toList().cast<NotesModel>();
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (contex,index){

                return Card(
                  color: Colors.greenAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        trailing: SizedBox(),
                          title:Text(data[index].title,style: TextStyle(color: Colors.black),),
                          subtitle:Text(data[index].description,style: TextStyle(color: Colors.black),),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: (){
                                  deleteItem(data[index]);
                                }, child: Text("Delete",style: TextStyle(color: Colors.white),)),
                                ElevatedButton(onPressed: (){
                                  _updateItem(data[index], data[index].title, data[index].description);

                                }, child: Text("Edit",style: TextStyle(color: Colors.white))),
                              ],
                            )
                          ],
                      )


                    ],
                  ),
                );
              });
            }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _showDialogbox();
      }, child: Icon(Icons.add),),

    );
  }

  //delete item
  deleteItem(NotesModel notesModel) async {
    await notesModel.delete();

  }

  //update item
  Future<void> _updateItem(NotesModel notesModel,String title,String description) {
    return showDialog(context: context, builder: (context) {
      titleController.text=title;
      descriptionController.text=description;
      return AlertDialog(

        content: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (String? value) {
                    return null;
                  }
                  ,
                  decoration: InputDecoration(
                      hintText: ("Enter notes title "),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: descriptionController,
                  validator: (String? value) {
                    return null;
                  }
                  ,
                  decoration: InputDecoration(
                      hintText: ("Enter notes Description "),
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Cancell")),
          TextButton(onPressed: () {
            notesModel.title=titleController.text;
            notesModel.description=descriptionController.text;
            notesModel.save();
            titleController.clear();
            descriptionController.clear();


            Navigator.pop(context);
          }, child: Text("Add")),
        ],
      );
    });
  }



  //add item
  Future<void> _showDialogbox() {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(

        content: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (String? value) {
                    return null;
                  }
                  ,
                  decoration: InputDecoration(
                      hintText: ("Enter notes title "),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: descriptionController,
                  validator: (String? value) {
                    return null;
                  }
                  ,
                  decoration: InputDecoration(
                      hintText: ("Enter notes Description "),
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Cancell")),
          TextButton(onPressed: () {
            final data = NotesModel(title: titleController.text,
                description: descriptionController.text);
            final box = Boxes.getData();
            box.add(data);
            data.save();
            titleController.clear();
            descriptionController.clear();


            Navigator.pop(context);
          }, child: Text("Add")),
        ],
      );
    });
  }
}
