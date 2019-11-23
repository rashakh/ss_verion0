class Med {
  int _id; //auto
  String _Name;
  String _conf;
  String _work;
  String _sid;

  Med(this._Name, this._conf, this._work,this._sid);

  int get id => _id;
  String get Name => _Name;
  String get conf => _conf;
  String get work => _work;
  String get sid => _sid;

  set Name(String newName) => _Name = newName;
  set conf(String newtype) => _conf = newtype;
  set work(String newtype) => _work = newtype;
  set sid(String newdg) => _sid = newdg;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _Name;
    map['conf'] = _conf;
    map['work'] = _work;
    map['sid'] = _sid;
    return map;
  }

  Med.fromMapObject(Map<String, dynamic> map) {
    this._Name = map['Name'];
    this._conf = map['conf'];
    this._sid = map['sid'];
    this._work = map['work'];

  }
}
