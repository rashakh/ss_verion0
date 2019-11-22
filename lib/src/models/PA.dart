class PA {
  int _id; //auto
  String _email;
  String _Name;
  double _dur;
  String _dg;


  PA(this._email, this._Name, this._dur, this._dg);

  int get id => _id;
  String get email => _email;
  String get Name => _Name;
  double get dur => _dur;
  String get dg => _dg;


  set email(String newemail) => _email = newemail;
  set Name(String newName) => _Name = newName;
  set dur(double newdur) => _dur = newdur;
  set dg(String newdg) => _dg = newdg;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['email']=_email;
    map['Name'] = _Name;
    map['dur'] = _dur;
    map['date'] = _dg;
    return map;
  }

  PA.fromMapObject(Map<String, dynamic> map) {
   
    this._email = map['email'];
    this._Name = map['Name'];
    this._dur = map['dur'];
    this._dg = map['date'];

  }
}
