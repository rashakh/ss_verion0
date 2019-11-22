class A1C {
  int _id; //auto
  double _A1C;
  String _dS;
  String _dE;


  A1C(this._A1C, this._dS, this._dE );

  int get id => _id;
  String get Name => _dE;
  double get a1C => _A1C;
  String get dS => _dS;


  set Name(String newName) => _dE = newName;
  set a1C(double newA1C) => _A1C = newA1C;
  set dS(String newdg) => _dS = newdg;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['dateE'] = _dE;
    map['a1C'] = _A1C;
    map['dateS'] = _dS;
    return map;
  }

  A1C.fromMapObject(Map<String, dynamic> map) {
   
    this._dE = map['dateE'];
    this._A1C = map['a1C'];
    this._dS = map['dateS'];

  }
}
