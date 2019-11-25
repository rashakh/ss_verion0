
  class Exam {
  int _id;//auto
  int _PTId;
  String _email;
  String _name;
  int _dur;
  String _date;
  String _result;
  String _RDate;

//  Exam.withId(this._PTId,this._name, this._email, this._date,this._dur,this._result,this._RDate);
  Exam.withId(this._PTId,this._name, this._email, this._date,this._dur);

  Exam(this._name, this._email, this._date,this._dur);

  int get id => _id;
  int get PTId => _PTId;
  String get email => _email;
  String get name => _name;
  int get dur => _dur;
  String get date => _date;
  String get result => _result;
  String get RDate => _RDate;

  set PTId(int newint) => _PTId = newint;
  set email(String newemail) => _email = newemail;
  set name(String neweat) => _name = neweat;
  set dur(int newcarb) => _dur = newcarb;
  set date(String newemail) => _date = newemail;
  set result(String newemail) => _result = newemail;
  set RDate(String newemail) => _RDate = newemail;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['PTId'] = _PTId;
    map['email']=_email;
    map['Name'] = _name;
    map['dur'] = _dur;
    map['date'] = _date;
    map['result'] = _result;
    map['RDate'] = _RDate;
    return map;
  }

  Exam.fromMapObject(Map<String, dynamic> map) {
    this._PTId = map['PTId'];   
    this._email = map['email'];
    this._name = map['Name'];
    this._dur = map['dur'];
    this._date = map['date'];
    this._result = map['result'];
    this._RDate = map['RDate'];

  }
}
