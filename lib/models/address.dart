
import 'package:cloud_firestore/cloud_firestore.dart';

class Parcel{
    String id;
    String title;
    String detail;
    String weight;
    String phone;
    String pick;
    String drop;
    String price;
    String taken;
    String approved;
    Timestamp createdAt;

   Parcel.fromMap(Map data){
     id = data['id'];
     title = data['title'];
     detail = data['detail'];
     weight = data['weight'];
     phone = data['phone'];
     pick = data['pick'];
     drop = data['drop'];
     price = data['price'];
     taken = data['taken'];
     approved = data['approved'];
     createdAt = data['createdAt'];
   }

}