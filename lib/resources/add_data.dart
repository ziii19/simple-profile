import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImage(String filename, Uint8List file) async {
    Reference ref = _storage.ref().child(filename);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> saveData(String name, String bio, Uint8List file) async {
    String resp = 'Some Error Occured';
    try {
      String imgUrl = await uploadImage('profile', file);

      await _firestore.collection('profile').add({
        'name': name,
        'bio': bio,
        'image': imgUrl,
      });
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
