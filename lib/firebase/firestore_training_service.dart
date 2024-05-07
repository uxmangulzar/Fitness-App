import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/firebase/firestore_generic_services.dart';
import 'package:fitness_app/fitness_app/model/training_model.dart';
import 'package:fitness_app/fitness_app/model/training_title_model.dart';

class FirestoreTrainingService {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  final CollectionReference _titleRef =
      FirebaseFirestore.instance.collection('Training Titles');
  final CollectionReference _trainingRef =
      FirebaseFirestore.instance.collection('Trainings');
  final String _subCol = 'records';

  Future<bool> addTraining(TrainingModel trainingModel) async {
    CollectionReference colRef = _trainingRef.doc(uid).collection(_subCol);
    return await FirestoreGenericServices()
        .insertDoc(colRef, '', trainingModel.toJson());
  }

  Future<bool> updateTraining(TrainingModel trainingModel, String id) async {
    CollectionReference colRef = _trainingRef.doc(uid).collection(_subCol);

    // If the ID exists, it means it's an existing training and needs updating
    try {
      await colRef.doc(id).update(trainingModel.toJson());
      return true; // Return true if the update is successful
    } catch (e) {
      log('Error updating training: $e');
      // Handle error cases or show an error message
      return false; // Return false to indicate failure
    }
  }

  Stream<List<TrainingModel>> getTrainingsStream() {
    return _trainingRef.doc(uid).collection(_subCol).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => TrainingModel.fromJson(doc.data(), doc.id))
            .toList()
          ..sort((a, b) => a.startTime!
              .toLowerCase()
              .compareTo(b.startTime!.toLowerCase())));
  }

  Stream<List<TrainingTitleModel>> getTrainingTitlesStream() {
    return _titleRef.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => TrainingTitleModel.fromJson(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList()
      ..sort(
          (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase())));
  }

  Future<void> deleteTraining(String trainingId) async {
    try {
      await _trainingRef.doc(uid).collection(_subCol).doc(trainingId).delete();
    } catch (e) {
      log('Error deleting training: $e');
      // Handle error cases or show an error message
    }
  }
}
