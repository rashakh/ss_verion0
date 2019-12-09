
  class Variety {
  int _id;
  int _idao;

  int _mealId;
  String _email;
  String _eat;
  double _carb;
  int _amount;


 // Meal(this._email, this._mealId, this._eat,this._amount);
  Variety(this._id,this._mealId, this._eat, this._email,this._carb,this._amount);

  int get id => _id;
  int get idao => _idao;
  int get mealId => _mealId;
  String get email => _email;
  String get eat => _eat;
  double get carb => _carb;
  int get amount => _amount;

  set id(int newint) => _id = newint;
  set idao(int newint) => _idao = newint;
  set mealId(int newint) => _mealId = newint;
  set email(String newemail) => _email = newemail;
  set eat(String neweat) => _eat = neweat;
  set carb(double newcarb) => _carb = newcarb;
  set amount(int newamount) => _amount = newamount;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
     // var map = Map<String, dynamic>();
       if (id != null) {
      map['idao'] = _id;
    }
    map['id'] = _id;
    map['mealId'] = _mealId;
    map['email']=_email;
    map['eat'] = _eat;
    map['varcarb'] = _carb;
    map['amount'] = _amount;
    return map;
  }

  Variety.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];  
    this._idao = map['idao'];   
    this._mealId = map['mealId'];   
    this._email = map['email'];
    this._eat = map['eat'];
    this._carb = map['varcarb'];
    this._amount = map['amount'];

  }
}
