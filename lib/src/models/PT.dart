class PT {
  int _id; //auto
  String _Name;

  PT(this._Name);

  int get id => _id;
  String get Name => _Name;

  set Name(String newName) => _Name = newName;
 
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _Name;
    return map;
  }

  PT.fromMapObject(Map<String, dynamic> map) {
    this._Name = map['Name'];

  }
}
