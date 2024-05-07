import 'package:fitness_app/firebase/firestore_profile_services.dart';
import 'package:fitness_app/fitness_app/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  // void setProfile(ProfileModel profile) {
  //   _profile = profile;
  //   notifyListeners();
  // }

  Future<void> getProfile() async {
    _profile = await FirestoreProfileServices().getProfile();
    notifyListeners();
  }

  clearProfile() {
    _profile = null;
    notifyListeners();
  }
}
