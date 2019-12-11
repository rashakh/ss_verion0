
  class Result {
  int _id;//auto
  int _PTId;
  String _email;
  String _name;
  String _result;
  String _RDate;

  Result(this._PTId,this._name, this._email,this._RDate,this._result,);

  int get id => _id;
  int get PTId => _PTId;
  String get email => _email;
  String get name => _name;
  String get result => _result;
  String get RDate => _RDate;

  set PTId(int newint) => _PTId = newint;
  set email(String newemail) => _email = newemail;
  set name(String neweat) => _name = neweat;
  set result(String newemail) => _result = newemail;
  set RDate(String newemail) => _RDate = newemail;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['PTId'] = _PTId;
    map['email']=_email;
    map['name'] = _name;
    map['result'] = _result;
    map['RDate'] = _RDate;
    return map;
  }

  Result.fromMapObject(Map<String, dynamic> map) {
    this._PTId = map['PTId'];   
    this._email = map['email'];
    this._name = map['name'];
    this._result = map['result'];
    this._RDate = map['RDate'];

  }
}
