// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:image_picker/image_picker.dart';

class FirestoreGenericServices {
  //To insert any kind of document
  Future insertDoc(CollectionReference colRef, String docID,
      Map<String, dynamic> data) async {
    try {
      docID.isEmpty
          ? await colRef.doc().set(data)
          : await colRef.doc(docID).set(data, SetOptions(merge: true));
      return true;
    } catch (e) {
      alertSnackBar(e.toString());
      return false;
    }
  }

  //Pass a field name, compare field value with passed value, if exists, return docID
  Future fieldExistsAndEqual(
      CollectionReference colRef, fieldName, value) async {
    try {
      return await colRef.where(fieldName, isEqualTo: value).limit(1).get();
    } catch (e) {
      return null;
    }
  }

  Future updateDoc(CollectionReference colRef, String docID,
      Map<Object, Object?> data) async {
    try {
      await colRef.doc(docID).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  //Returns whether a document exists or not
  Future docExists(CollectionReference colRef, String docID) async {
    var doc = await colRef.doc(docID).get();
    return doc.exists;
  }

  Future<bool> areFieldsEmpty(
      CollectionReference colRef, String docID, List<String> fieldNames) async {
    final documentSnapshot = await colRef.doc(docID).get();
    if (documentSnapshot.exists) {
      // Check if all specified fields are empty
      return fieldNames.any(
          (field) => documentSnapshot.get(field)?.toString().isEmpty ?? true);
    } else {
      return false;
    }
  }
}
