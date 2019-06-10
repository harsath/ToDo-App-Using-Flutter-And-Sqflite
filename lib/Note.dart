class Note{
  int _id, _priority;
  String _title, _description, _date ;
                                                //This is Optioanl Position Paremeter if {} This is Optional Named Parameter
  Note(this._title, this._date, this._priority, [this._description]);
  //This is during editing(Called with Id)
  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

//All the Getters(Controls the Data Asked By another method from this Class)
  int get id {
    return _id;
  }
  int get priority => _priority;
  String get title => _title;
  String get description => _description;
  String get date => _date;

//These are all the Setters
set title(String newTitle){
  if(newTitle.length <= 255){
    this._title = newTitle;
  }
}

set description(String newDescription){
  if(newDescription.length <= 255){
    this._description= newDescription;
  }
}

set date(String newDate){
  if(newDate.length <= 255){
    this._date= newDate;
  }
}

set priority(int newPre){
  if(newPre >= 1 && newPre <= 2){
    this._priority= newPre;
  }
}

//Used to Save and Retrive from the Database
//Converting the Note Object into Map Object
Map<String, dynamic> toMap(){
  //This is an Map Object
  var map = Map<String, dynamic>();
  //This means Already Created in the Database
  if(id != null){
    map['id'] = _id;
  }
  map['title'] = _title;
  map['description'] = _description;
  map["priority"] = _priority;
  map['date'] = _date;
  return map;
}

Note.fromMapObject(Map<String, dynamic> map){
  this._id = map['id'];
  this._title = map['title'];
  this._description = map['description'];
  this._priority = map['priority'];
  this._date = map['date'];
}

}




