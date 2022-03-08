class Address {
  String id;
  String name;
  String phoneNumber;
  String flatNumber;
  String city;
  String state;
  String fullAddress;
  double lat;
  double lng;

  Address({
    this.id,
    this.name,
    this.phoneNumber,
    this.flatNumber,
    this.city,
    this.state,
    this.fullAddress,
    this.lat,
    this.lng,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      flatNumber: json['flatNumber'],
      city: json['city'],
      state: json['state'],
      fullAddress: json['fullAddress'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['flatNumber'] = flatNumber;
    data['city'] = city;
    data['state'] = state;
    data['fullAddress'] = fullAddress;
    data['lat'] = lat;
    data['lng'] = lng;

    return data;
  }
}
