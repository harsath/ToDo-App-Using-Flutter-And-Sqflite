import 'package:flutter/material.dart';
import 'dart:async';
import '../database_helper.dart';
import '../Note.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  
  void navigateToDetail(Note note, String title) async{
      bool result = await Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return NoteDetail(note, title);
      }
  ));
  if(result == true){
      updateListView();
    }else if(result == null){
        Text("No Notes to Show");
    }
  }
  
 void updateListView(){
   final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
   dbFuture.then((database){
     Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
     noteListFuture.then((noteList){
       setState(() {
         this.noteList = noteList;
         this.count = noteList.length;
       });
     });

   });
 }

  @override
  Widget build(BuildContext context) {

    if(noteList == null){
      noteList = List<Note>();
      updateListView();
    }
    Future<bool> _onBackPressed(){
      return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Do You Really Want To Exit?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No",style: TextStyle(
                color: Colors.white,
              ),),
              onPressed: ()=>Navigator.pop(context,false),
              color: Colors.greenAccent,
            ),
            FlatButton(
              child: Text("Yes",
              style: TextStyle(
                color: Colors.white,
              ),
              ),
              onPressed: ()=>Navigator.pop(context,true),
              color: Colors.redAccent,
            ),
          ],
        ),
      );
    }
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: Scaffold(
        appBar: AppBar(
          title: Text("My Todo App"),
          backgroundColor: Colors.deepPurple,
        ),
        body: getNoteListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: (){
            navigateToDetail(Note("","",2), "Add Note");
          },
        ),
      ),
    );
  }
  ListView getNoteListView(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.deepPurple,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://learncodeonline.in/mascot.png")  
          ),
          title: Text(this.noteList[position].title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0
          ),
          ),
          subtitle: Text(this.noteList[position].date,
          style: TextStyle(
            color: Colors.white
          ),
          ),
          trailing: GestureDetector(
            child: Icon(Icons.open_in_new, color: Colors.white,),
            onTap: (){
              navigateToDetail(this.noteList[position], "Edit Todo");
            },
          ),
          ),
        );
      },
    );
  }

  

}

