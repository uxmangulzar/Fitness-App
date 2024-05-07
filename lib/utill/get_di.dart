import 'package:cloud_firestore/cloud_firestore.dart';

var firestore = FirebaseFirestore.instance;

funCreate(String collectionName, Map<String, dynamic> create) {
  firestore.collection(collectionName).doc().set(create);
}
