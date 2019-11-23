class Carb {
  int _id; //auto
  double _curnt;
  double _min;
  double _max;
  String _Dc;

  Carb(this._curnt, this._min, this._max,this._Dc);

  int get id => _id;
  double get curnt  => _curnt;
  double get min => _min;
  double get max => _max;
  String get Dc => _Dc;

  set curnt(double newtype) => _curnt = newtype;
  set min(double newtype) => _min = newtype;
  set max(double newtype) => _max = newtype;
  set Dc(String newdg) => _Dc = newdg;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['curnt'] = _curnt;
    map['min'] = _min;
    map['max'] = _max;
    map['date'] = _Dc;
    return map;
  }

  Carb.fromMapObject(Map<String, dynamic> map) {
    this._curnt = map['curnt'];
    this._min = map['min'];
    this._Dc = map['date'];
    this._max = map['max'];

  }
}
