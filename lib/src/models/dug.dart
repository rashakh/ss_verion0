class Dug {
  int _id; //auto
  String _email;
  String _Name;
  String _type;
  int _dug;


  Dug(this._email, this._Name, this._dug, this._type);

  int get id => _id;
  String get email => _email;
  String get Name => _Name;
  String get tupe => _type;
  int get dug => _dug;


  set email(String newemail) => _email = newemail;
  set Name(String newName) => _Name = newName;
  set dur(String newdur) => _type = newdur;
  set dg(int newdg) => _dug = newdg;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['email']=_email;
    map['Name'] = _Name;
    map['dur'] = _type;
    map['dug'] = _dug;
    return map;
  }

  Dug.fromMapObject(Map<String, dynamic> map) {
   
    this._email = map['email'];
    this._Name = map['Name'];
    this._type = map['dur'];
    this._dug = map['dug'];

  }
}
