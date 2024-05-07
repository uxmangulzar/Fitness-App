import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/firebase/firestore_generic_services.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class StorageServices {
  // Function to handle image selection and upload
  Future<bool> uploadImage(File pickedFile, folderName, fileName,
      CollectionReference colRef, docID, fieldName) async {
    try {
      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = '${dir.absolute.path}/temp.jpg';
      // converting original image to compress it
      final result = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        targetPath,
        minHeight: 1080, //you can play with this to reduce siz
        minWidth: 1080,
        quality: 90, // keep this high to get the original quality of image
      );

      // Upload the image to Firebase Cloud Storage
      //If any error in compressing, upload using original size
      File imageFile = File(result == null ? pickedFile.path : result.path);

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(folderName)
          .child(fileName)
          .putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String imageUrl = await snapshot.ref.getDownloadURL();
      // Store the image URL in Firestore
      Map<String, dynamic> data = {fieldName: imageUrl};
      await FirestoreGenericServices().insertDoc(colRef, docID, data);
      return true;
    } catch (e) {
      alertSnackBar(e.toString());
    }
    return false;
  }
}
