class instr {
  int _id; //auto
  String _titel;
  String _des;

  instr(this._titel, this._des);
  instr.withId(this._id,this._titel, this._des);

  int get id => _id;
  String get titel => _titel;
  String get des => _des;

  set titel(String newname) => _titel = newname;
  set des(String newdes) => _des = newdes;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['titel']=_titel;
    map['des'] = _des;
    return map;
  }

  instr.fromMapObject(Map<String, dynamic> map) {
    this._titel = map['titel'];
    this._id = map['id'];   
    this._des = map['des'];

  }
}
