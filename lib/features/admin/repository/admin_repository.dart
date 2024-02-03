import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shri_ram_mandir/models/event_model.dart';

final adminRepositoryProvider =
    StateNotifierProvider<AdminRepository, bool>((ref) {
  return AdminRepository(firebaseStorage: FirebaseStorage.instance);
});

class AdminRepository extends StateNotifier<bool> {
  final FirebaseStorage _firebaseStorage;
  AdminRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage,
        super(false);
  Future<List<String>> storeImagetoStorage(String name, List<File> file) async {
    try {
      List<String> imageUrls = [];
      for (int i = 0; i < file.length; i++) {
        final ref = _firebaseStorage.ref().child(name).child(i.toString());
        final UploadTask uploadTask = ref.putFile(file[i]);
        final snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
      return imageUrls;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> uploadEvent(Event event, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("Events")
          .add(event.toMap())
          .whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Service Added"),
              ),
            ),
          );
    } catch (e) {
      throw (e.toString());
    }
  }

  Stream<List<Event>> fetchEvents() {
    return FirebaseFirestore.instance
        .collection("Events")
        .orderBy('year', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Event.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
