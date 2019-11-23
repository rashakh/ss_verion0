class BG {
 // int _id; //auto
  String _email;
  String _slot;
  int _BG=0;
  String _note;
  String _dg;


  BG(this._email, this._slot, this._BG, this._note, this._dg);

  String get email => _email;
  String get slot => _slot;
  int get bG => _BG;
  String get note => _note;
  String get dg => _dg;


  set email(String newemail) => _email = newemail;
  set slot(String newslot) => _slot = newslot;
  set bG(int newBG) => _BG = newBG;
  set note(String newnote) => _note = newnote;
  set dg(String newdg) => _dg = newdg;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['email']=_email;
    map['slot'] = _slot;
    map['BG'] = _BG;
    map['note'] = _note;
    map['date'] = _dg;
    return map;
  }

  BG.fromMapObject(Map<String, dynamic> map) {
    this._email = map['email'];
    this._slot = map['slot'];
    this._BG = map['BG'];
    this._note = map['note'];
    this._dg = map['date'];

  }
}
