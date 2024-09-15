
class Candidato {
  Candidato({
      int? id,
      String? gender, 
      String? title, 
      String? first, 
      String? last,
      int? no,
      String? street, 
      String? city, 
      String? state, 
      String? country, 
      String? postcode,
      String? date, 
      int? age, 
      String? phone, 
      String? picture, 
      String? nat,}){
    _id = id;
    _gender = gender;
    _title = title;
    _first = first;
    _last = last;
    _no = no;
    _street = street;
    _city = city;
    _state = state;
    _country = country;
    _postcode = postcode;
    _date = date;
    _age = age;
    _phone = phone;
    _picture = picture;
    _nat = nat;
}

  Candidato.fromJson(dynamic json) {
    _gender = json['gender'];
    _title = json['title'];
    _first = json['first'];
    _last = json['last'];
    _no = json['no'];
    _street = json['street'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _postcode = json['postcode'];
    _date = json['date'];
    _age = json['age'];
    _phone = json['phone'];
    _picture = json['picture'];
    _nat = json['nat'];
  }

  int? _id;
  String? _gender;
  String? _title;
  String? _first;
  String? _last;
  int? _no;
  String? _street;
  String? _city;
  String? _state;
  String? _country;
  String? _postcode;
  String? _date;
  int? _age;
  String? _phone;
  String? _picture;
  String? _nat;
Candidato copyWith({  String? gender,
  String? title,
  String? first,
  String? last,
  int? no,
  String? street,
  String? city,
  String? state,
  String? country,
  String? postcode,
  String? date,
  int? age,
  String? phone,
  String? picture,
  String? nat,
}) => Candidato(  gender: gender ?? _gender,
  title: title ?? _title,
  first: first ?? _first,
  last: last ?? _last,
  no: no ?? _no,
  street: street ?? _street,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  postcode: postcode ?? _postcode,
  date: date ?? _date,
  age: age ?? _age,
  phone: phone ?? _phone,
  picture: picture ?? _picture,
  nat: nat ?? _nat,
);
  int? get id => _id;
  String? get gender => _gender;
  String? get title => _title;
  String? get first => _first;
  String? get last => _last;
  int? get no => _no;
  String? get street => _street;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get postcode => _postcode;
  String? get date => _date;
  int? get age => _age;
  String? get phone => _phone;
  String? get picture => _picture;
  String? get nat => _nat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gender'] = _gender;
    map['title'] = _title;
    map['first'] = _first;
    map['last'] = _last;
    map['no'] = _no;
    map['street'] = _street;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['postcode'] = _postcode;
    map['date'] = _date;
    map['age'] = _age;
    map['phone'] = _phone;
    map['picture'] = _picture;
    map['nat'] = _nat;
    return map;
  }


  Map<String, dynamic> toMap() {
    return {
      "id":_id,
      "gender":_gender,
      "title":_title,
      "first":_first,
      "last":_last,
      "no":_no,
      "street":_street,
      "city":_city,
      "state":_state,
      "country":_country,
      "postcode":_postcode,
      "date":_date,
      "age":_age,
      "phone":_phone,
      "picture":_picture,
      "nat":_nat
    };
  }

  factory Candidato.fromMap(Map<String,dynamic> map)
  {
    return Candidato(
      id : map['id'],
      gender : map['gender'],
      title  : map['title'],
      first  : map['first'],
      last   : map['last'],
      no     : map['no'],
      street : map['street'],
      city   : map['city'],
      state  : map['state'],
      country: map['country'],
      postcode: map['postcode'],
      date : map['date'],
      age : map['age'],
      phone : map['phone'],
      picture : map['picture'],
      nat : map['nat']
    );
  }


}