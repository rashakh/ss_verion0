class A1C {
  int _id; //auto
  String _email;
  double _A1C;
  String _dS;
  String _dE;


  A1C(this._A1C,this._email, this._dS, this._dE );
  A1C.A1c(this._A1C);

  int get id => _id;
  String get dE => _dE;
  double get a1C => _A1C;
  String get dS => _dS;
  String get email => _email;


  set dE(String newName) => _dE = newName;
  set a1C(double newA1C) => _A1C = newA1C;
  set dS(String newdg) => _dS = newdg;
  set email(String newemail) => _email = newemail;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['email']=_email;  
    map['dateE'] = _dE;
    map['a1C'] = _A1C;
    map['dateS'] = _dS;
    return map;
  }

  A1C.fromMapObject(Map<String, dynamic> map) {
   
    this._dE = map['dateE'];
    this._A1C = map['a1C'];
    this._dS = map['dateS'];
    this._email = map['email'];
  }
}
