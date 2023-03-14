import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled9/datas/product_data.dart';

class CartProduct{
  String? cid;
  String? category;
  String? pid;
  int? quantidy;
  String? size;

  ProductData? productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.id;
    category = document["category"];
    pid = document["pid"];
    quantidy = document["quantidy"];
    size = document["size"];
  }

  Map<String, dynamic>? toMap(){
    return{
      "category": category,
      "pid": pid,
      "quantidy": quantidy,
      "size": size,
      "product": productData?.toResumeMap()
    };
  }

}