class Address {
  String name;
  String phoneNumber;
  String flatNumber;
  String city;
  String state;
  String fullAddress;
  double lat;
  double lng;

  Address({
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


// class Address {
//   final String parcelImageUrl;
//   final String title;
//   final String detail;
//   final String weight;
//   final String phone;
//   final String pick;
//   final String drop;
//   final String price;
//   final bool taken;
//   final bool approved;
//   final String sellerUID;
//   final String rid;

//   Address({
//      this.title,
//      this.parcelImageUrl,
//      this.sellerUID,
//       this.rid,
//      this.detail,
//      this.weight,
//      this.phone,
//      this.pick,
//      this.drop,
//      this.price,
//      this.taken,
//      this.approved,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//         title: json['title'],
//         detail: json['detail'],
//         weight: json['weight'],
//         phone: json['phone'],
//         pick: json['pick'],
//         drop: json['drop'],
//         price: json['price'],
//         taken: json['taken'],
//         approved: json['approved'],
//         sellerUID: json['SellerUID'],
//         parcelImageUrl: json['parcelImageUrl'],
//         rid: json['rid']);


//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['detail'] = detail;
//     data['weight'] = weight;
//     data['phone'] = phone;
//     data['pick'] = pick;
//     data['drop'] = drop;
//     data['price'] = price;
//     data['taken'] = taken;
//     data['approved'] = approved;
//     data['sellerUID'] = sellerUID;
//     data['parcelImageUrl'] = parcelImageUrl;
//     data['rid'] = rid;
//     return data;
//   }
// }
