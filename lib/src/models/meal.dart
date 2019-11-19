class Meal {
  int _id; //auto
  String _email;
  String _slot;
  double _carb;
  String _note;
  String _dm;


  Meal(this._email, this._slot, this._carb, this._note, this._dm);
  Meal.withId(this._id,this._email, this._slot, this._carb, this._note, this._dm);

  int get id => _id;
  String get email => _email;
  String get slot => _slot;
  double get carb => _carb;
  String get note => _note;
  String get dm => _dm;


  set email(String newemail) => _email = newemail;
  set slot(String newslot) => _slot = newslot;
  set carb(double newcarb) => _carb = newcarb;
  set note(String newnote) => _note = newnote;
  set dm(String newdm) => _dm = newdm;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['email']=_email;
    map['slot'] = _slot;
    map['totalCarb'] = _carb;
    map['note'] = _note;
    map['dm'] = _dm;
    return map;
  }

  Meal.fromMapObject(Map<String, dynamic> map) {
    this._email = map['email'];
    this._id = map['id'];   
    this._slot = map['slot'];
    this._carb = map['totalCarb'];
    this._note = map['note'];
    this._dm = map['dm'];

  }
}
