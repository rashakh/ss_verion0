class BP {
 // int _id; //auto
  String _email;
  int _Systolic;
  int _Diastolic;
  String _note;
  String _dp;

  BP(this._email, this._Systolic,this._Diastolic, this._note, this._dp);

  String get email => _email;
  int get Systolic => _Systolic;
  int get Diastolic => _Diastolic;
  String get note => _note;
  String get dp => _dp;


  set email(String newemail) => _email = newemail;
  set Systolic(int newslot) => _Systolic = newslot;
  set Diastolic(int newBG) => _Diastolic = newBG;
  set note(String newnote) => _note = newnote;
  set dp(String newdp) => _dp = newdp;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['email']=_email;
    map['Systolic'] = _Systolic;
    map['Diastolic'] = _Diastolic;
    map['note'] = _note;
    map['date'] = _dp;
    return map;
  }

  BP.fromMapObject(Map<String, dynamic> map) {
    this._email = map['email'];
    this._Systolic = map['Systolic'];
    this._Diastolic = map['Diastolic'];
    this._note = map['note'];
    this._dp = map['date'];

  }
}
