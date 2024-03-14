class User {
  int id=0;
  String? email;
  String? username;
  String? password;
  Name? name;
  Address? address;
  String? phone;

  User({
    this.email,
    this.username,
    this.password,
    this.name,
    this.address,
    this.phone,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['phone'] = phone;
    return data;
  }
}

class Name {
  String? firstname;
  String? lastname;

  Name({this.firstname, this.lastname});

  Name.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}

class Address {
  String? city;
  String? street;
  int? number;
  String? zipcode;
  Geolocation? geolocation;

  Address(
      {this.city, this.street, this.number, this.zipcode, this.geolocation});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['street'] = street;
    data['number'] = number;
    data['zipcode'] = zipcode;
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    return data;
  }
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({this.lat, this.long});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
