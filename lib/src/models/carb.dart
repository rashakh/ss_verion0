class Carb {
  int _id; //auto
  double _curnt;
  String _email;
  double _min;
  double _max;
  String _Dc;

  Carb(this._curnt,this._email, this._min, this._max,this._Dc);
  Carb.Carb(this._curnt);


  int get id => _id;
  double get curnt  => _curnt;
  double get min => _min;
  double get max => _max;
  String get Dc => _Dc;
  String get email => _email;

  set curnt(double newtype) => _curnt = newtype;
  set min(double newtype) => _min = newtype;
  set max(double newtype) => _max = newtype;
  set Dc(String newdg) => _Dc = newdg;
  set email(String newemail) => _email = newemail;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['curnt'] = _curnt;
    map['min'] = _min;
    map['max'] = _max;
    map['date'] = _Dc;
    map['email']=_email;  

    return map;
  }

  Carb.fromMapObject(Map<String, dynamic> map) {
    this._curnt = map['curnt'];
    this._min = map['min'];
    this._Dc = map['date'];
    this._max = map['max'];
    this._email = map['email'];
  }
}
