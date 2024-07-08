import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_profile/image_helper.dart';
import 'package:simple_profile/resources/add_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  void pickImage(ImageSource source) async {
    final img = getImage(source);

    setState(() {
      _image = img;
    });
  }

  void saveProgile() async {
    String name = nameController.text;
    String bio = bioController.text;
    await StoreData().saveData(name, bio, _image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Profile')),
      body: ListView(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  imageSheet();
                },
                child: Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 110,
                        color: Colors.blueAccent.withOpacity(.8),
                      ),
                    ),
                    const Positioned(
                        top: 80,
                        left: 70,
                        child: Icon(Icons.add_a_photo_rounded))
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Name'),
                      hintText: 'Enter Name'),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: bioController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Bio'),
                      hintText: 'Enter Bio'),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(200, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  onPressed: () {},
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }

  imageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(.2),
              ),
              child: IconButton(
                  onPressed: () async {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    size: 80,
                  )),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(.2),
              ),
              child: IconButton(
                  onPressed: () async {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.filter,
                    size: 80,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
