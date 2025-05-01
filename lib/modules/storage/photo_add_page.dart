import 'dart:io';
import 'package:firebase_learning/modules/storage/storage_operations.dart';
import 'package:firebase_learning/shared/widget/button/future_button.dart';
import 'package:firebase_learning/shared/widget/dialog/snackbar_dialog.dart';
import 'package:firebase_learning/shared/widget/scaffold/base_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAddPage extends StatefulWidget {
  const PhotoAddPage({super.key});

  @override
  State<PhotoAddPage> createState() => _PhotoAddPageState();
}

class _PhotoAddPageState extends State<PhotoAddPage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;

    File file = File(image.path);
    var result = await StorageOperations.addImage(file: file);
    if (mounted) {
      if (result.status) {
        Navigator.of(context).pop();
      } else {
        SnackbarDialog.show(context: context, message: result.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureButton(
              onPressed: () => _pickAndUploadImage(ImageSource.camera),
              text: "Camera",
            ),
            FutureButton(
              onPressed: () => _pickAndUploadImage(ImageSource.gallery),
              text: "Gallery",
            ),
          ],
        ),
      ),
    );
  }
}
