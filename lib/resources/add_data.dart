import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class StoreData {
  Future<String> uploadImage(String filename, Uint8List file) async {
    Reference ref = _storage.ref().child(filename);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
