import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:parcel_sellerapp/models/address.dart';


class ParcelNotifier with ChangeNotifier{
  List<Parcel> _parcelList = [];
   Parcel _currentParcel;
  
  UnmodifiableListView<Parcel> get parcelList => UnmodifiableListView(_parcelList);

  Parcel get currentParcel => _currentParcel;

  set parcelList(List<Parcel> parcelList){
    _parcelList = parcelList;
    notifyListeners();
  }
  set currentParcel(Parcel parcel){
    _currentParcel = parcel;
    notifyListeners();
  }

  
}