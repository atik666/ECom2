import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService{
  final _firesStore = FirebaseFirestore.instance;

  void createCategory(String name){
    var id = Uuid();
    String categoryId = id.v1();

    _firesStore.collection('categories').doc(categoryId).set({'category': name});
  }
}