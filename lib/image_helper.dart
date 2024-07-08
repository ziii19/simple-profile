import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

getImage(ImageSource source) async {
  try {
    final picker = ImagePicker();

    XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      return await image.readAsBytes();
    }
    return null;
  } catch (e) {
    throw ErrorDescription(e.toString());
  }
}
