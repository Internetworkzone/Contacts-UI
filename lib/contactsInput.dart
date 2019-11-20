class Contacts {
  Contacts(this._name, this._number);
  int _id;
  String _name;
  String _number;

  int get id => _id;
  String get name => _name;
  String get number => _number;

  set name(String contactName) {
    this._name = contactName;
  }

  set number(String contactNumber) {
    this._number = contactNumber;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['number'] = _number;

    return map;
  }

  Contacts.map(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._number = map['number'];
  }
}
