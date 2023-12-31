import 'package:hive/hive.dart';
import 'package:note_app_hive/model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes{
  // static Box<NotesModel>getData()=>Hive.box<NotesModel>('notes');
  static Box<NotesModel>getData()=>Hive.box<NotesModel>("notes");
}