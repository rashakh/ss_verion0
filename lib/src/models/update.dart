class UPD {
  double _MaxBA; 
  String _email;
  double _MaxI;
  int _RemE;
  int _RemA;
  int _RemK;
  double _MaxC;


  UPD(this._email,this._MaxBA,this._MaxI, this._MaxC,this._RemE,this._RemA,this._RemK);
  UPD.MaxBA(this._email,this._MaxBA);
  UPD.MaxI(this._email,this._MaxI);
  UPD.MaxC(this._email,this._MaxC);
  UPD.RemE(this._email,this._RemE);
  UPD.RemA(this._email,this._RemA);
  UPD.RemK(this._email,this._RemK);

  double get MaxBA => _MaxBA;
  double get MaxI => _MaxI;
  double get MaxC => _MaxC;
  int get RemE => _RemE;
  int get RemK => _RemK;
  int get RemA => _RemA;
  String get email => _email;


  set MaxBA(double newName) => _MaxBA = newName;
  set MaxI(double newA1C) => _MaxI = newA1C;
  set MaxC(double newdg) => _MaxC = newdg;
  set RemE(int newdg) => _RemE = newdg;
  set RemK(int newdg) => _RemK = newdg;
  set RemA(int newdg) => _RemA = newdg;
  set email(String newemail) => _email = newemail;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['email']=_email;  
    map['MaxBA'] = _MaxBA;
    map['MaxI'] = _MaxI;
    map['MaxC'] = _MaxC;
    map['RemE'] = _RemE;
    map['RemK'] = _RemK;
    map['RemA'] = _RemA;
    return map;
  }

  UPD.fromMapObject(Map<String, dynamic> map) {
   
    this._MaxBA = map['MaxBA'];
    this._MaxI = map['MaxI'];
    this._MaxC = map['MaxC'];
    this._RemE = map['RemE'];
    this._RemK = map['RemK'];
    this._RemA = map['RemA'];
    this._email = map['email'];
  }
}
