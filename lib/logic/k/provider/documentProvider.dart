import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../widget/showToas.dart';

class documentProvider extends ChangeNotifier {
  String fileName = '';
  File? file;
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  setFilename(String name) {
    fileName = name;
    notifyListeners();
  }

  pickFile(context) async {
    await FilePicker.platform
        .pickFiles(
            allowMultiple: false,
            allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
            type: FileType.custom)
        .then((result) {
      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        file = File(selectedFile.path!);
        setFilename(selectedFile.name);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No File Selected')));
      }
    });
  }

  bool isFileUploading = false;
  setisFileUploading(value) {
    isFileUploading = value;
    notifyListeners();
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;
  sendDocument({required String title, required String note}) async {
    try {
      setisFileUploading(true);
      TaskSnapshot taskSnapshot = await _firebaseStorage
          .ref()
          .child('files')
          .child(fileName)
          .putFile(file!);
      String getDownloadURL = await taskSnapshot.ref.getDownloadURL();

      await _firebaseDatabase.ref().child('file_info$userId').push().set({
        'title': title,
        'note': note,
        'fileUrl': getDownloadURL,
        'date': DateTime.now().toString(),
        'fileName': fileName,
        'fileType': fileName.split('.').last
      }).then((value) {
        showGoodToast('Successfully uploaded document');
      });
      setisFileUploading(false);
    } on FirebaseException catch (error) {
      setisFileUploading(false);
      showErrorToast(error.message!);
    } catch (error) {
      setisFileUploading(false);
      showErrorToast(error.toString());
    }
  }
}
