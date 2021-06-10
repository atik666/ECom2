import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService{
  final _firesStore = FirebaseFirestore.instance;

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();

    _firesStore.collection('brands').doc(brandId).set({'brand': name});
  }
}