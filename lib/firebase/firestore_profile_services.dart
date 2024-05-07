import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/firebase/firestore_generic_services.dart';
import 'package:fitness_app/firebase/storage_services.dart';
import 'package:fitness_app/fitness_app/model/profile_model.dart';

class FirestoreProfileServices {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  final CollectionReference _profileRef =
      FirebaseFirestore.instance.collection('Profiles');

  Future<bool> createProfile(ProfileModel profileModel,
      {bool isAge = false}) async {
    return await FirestoreGenericServices().insertDoc(_profileRef, uid!,
        isAge ? profileModel.ageToJson() : profileModel.toJson());
  }

  Future<ProfileModel?> getProfile() async {
    try {
      DocumentSnapshot documentSnapshot = await _profileRef.doc(uid).get();

      if (documentSnapshot.exists) {
        // Assume you have a method to convert Map to ProfileModel
        return ProfileModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      // Handle errors here
      log('Error getting profile: $e');
      return null;
    }
  }

  Future<bool> uploadProfilePic(File file) async {
    return await StorageServices().uploadImage(
        file, 'profile_pics', '$uid.jpg', _profileRef, uid, 'profilePicUrl');
  }
}
