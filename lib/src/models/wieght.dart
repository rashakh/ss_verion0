class BW {
  int _id;
  String _email;
  int _wieght;
  double _bmi;
  String _note;
  String _dw;

  BW(this._email, this._wieght,this._bmi, this._note, this._dw);

  String get email => _email;
  int get wieght => _wieght;
  double get bmi => _bmi;
  String get note => _note;
  String get dw => _dw;
  int get id => _id;


  set email(String newemail) => _email = newemail;
  set wieght(int newslot) => _wieght = newslot;
  set bmi(double newbmi) => _bmi = newbmi;
  set note(String newnote) => _note = newnote;
  set dw(String newdw) => _dw = newdw;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
       if (id != null) {
      map['id'] = _id;
    }
    map['email']=_email;
    map['wieght'] = _wieght;
    map['bmi'] = _bmi;
    map['note'] = _note;
    map['date'] = _dw;
    return map;
  }

  BW.fromMapObject(Map<String, dynamic> map) {
    this._email = map['email'];
    this._wieght = map['wieght'];
    this._bmi = map['bmi'];
    this._note = map['note'];
    this._dw = map['date'];

  }
}
