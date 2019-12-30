class User {
  String _email;
  String _pass;
  String _fname;
  String _lname;
  String _dd;
  String _bd;
  int _gender;
  int _type;
  double _hight;
  String _number;
  // double _weight;
  // double _bmi;

  User(this._email, this._pass, this._fname, this._lname, this._dd, this._bd,
      this._gender, this._type, this._hight, this._number //this._weight, this._bmi
      );

  String get emailg => _email;
  String get passg => _pass;
  String get fnameg => _fname;
  String get lnameg => _lname;
  String get ddg => _dd;
  String get bdg => _bd;
  int get genderg => _gender;
  int get typeg => _type;
  double get hightg => _hight;
  String get numberg => _number;
  // double get weight => _weight;
  // double get bmi => _bmi;

  set email(String newemail) => _email = newemail;
  set pass(String newpass) => _pass = newpass;
  set fname(String newfname) => _fname = newfname;
  set lname(String newlname) => _lname = newlname;
  set number(String newlname) => _number = newlname;
  set dd(String newdd) => _dd = newdd;
  set bd(String newbd) => _bd = newbd;
  set gender(int newgender) => _gender = newgender;
  set type(int newtype) => _type = newtype;
  set hight(double newhight) => _hight = newhight;
  // set weight(double newweight) => _weight = newweight;
  // set bmi(double newbmi) => _bmi = newbmi;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (emailg != null) {
      map['email'] = _email;
    }
    map['pass'] = _pass;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['dd'] = _dd;
    map['bd'] = _bd;
    map['gender'] = _gender;
    map['type'] = _type;
    map['hight'] = _hight;
    map['number'] = _number;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._email = map['email'];
    this._pass = map['pass'];
    this._fname = map['fname'];
    this._lname = map['lname'];
    this._dd = map['dd'];
    this._bd = map['bd'];
    this._gender = map['gender'];
    this._type = map['type'];
    this._hight = map['hight'];
    this._number = map['number'];
    //this._weight = map['weight'];
    //this._bmi = map['bmi'];
  }
}
