import 'package:databasemarch/functions.dart';
import 'package:databasemarch/model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  File? image25;
  String? imagepath;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 216, 212, 212),
      backgroundColor: Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Text(
            'Add Student',
            style: TextStyle(
                // color: Color.fromARGB(255, 69, 237, 74),
                color: const Color.fromARGB(255, 183, 215, 143),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF1E1E2F),
          actions: [
            IconButton(
              onPressed: () {
                addstudentclicked(context);
              },
              icon: const Icon(
                Icons.save_rounded,
                color: const Color.fromARGB(255, 183, 215, 143),
              ),
            )
          ],
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 103, 103, 125),
                        backgroundImage: image25 != null
                            ? FileImage(image25!)
                            : const AssetImage('') as ImageProvider,
                        radius: 99),
                    Positioned(
                      bottom: 20,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          getimage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                        color: Colors.white,
                        iconSize: 40,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Name input field with validation
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  style: TextStyle(
                      // color: const Color.fromARGB(255, 183, 215, 143)
                      color: const Color.fromARGB(255, 224, 233, 237)),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 183, 215, 143)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 131, 236, 134), width: 1),
                    ),
                    suffixIcon: const Icon(
                      Icons.abc_outlined,
                      color: const Color.fromARGB(255, 183, 215, 143),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Class input field with validation
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  controller: _classController,
                  style: TextStyle(
                      // color: const Color.fromARGB(255, 183, 215, 143)
                      color: const Color.fromARGB(255, 224, 233, 237)),
                  decoration: InputDecoration(
                    labelText: "Class",
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 183, 215, 143)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 131, 236, 134),
                          width: 1), // Border color when focused
                    ),
                    suffixIcon: const Icon(
                      Icons.class_outlined,
                      color: const Color.fromARGB(255, 183, 215, 143),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Class';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Guardian input field with validation
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  controller: _guardianController,
                  style: TextStyle(
                      // color: const Color.fromARGB(255, 183, 215, 143)
                      color: const Color.fromARGB(255, 224, 233, 237)),
                  decoration: InputDecoration(
                    labelText: "Guardian",
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 183, 215, 143)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 131, 236, 134), width: 1),
                    ),
                    suffixIcon: const Icon(
                      Icons.person,
                      color: const Color.fromARGB(255, 183, 215, 143),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Guardian';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Mobile input field with validation
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: _mobileController,
                  style: TextStyle(
                      // color: const Color.fromARGB(255, 183, 215, 143)
                      color: const Color.fromARGB(255, 224, 233, 237)),
                  decoration: InputDecoration(
                    labelText: "Mobile",
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 183, 215, 143)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 131, 236, 134),
                          width: 1), // Border color when focused
                    ),
                    suffixIcon: const Icon(
                      Icons.phone_sharp,
                      color: const Color.fromARGB(255, 183, 215, 143),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Mobile';
                    } else if (value.length != 10) {
                      return 'Mobile number should be 10 digits';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addstudentclicked(mtx) async {
    if (_formKey.currentState!.validate() && image25 != null) {
      final name = _nameController.text.toUpperCase();
      final classA = _classController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final stdData = StudentModel(
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: imagepath!,
      );
      await addstudent(stdData);

      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        image25 = null;
        _nameController.clear();
        _classController.clear();
        _guardianController.clear();
        _mobileController.clear();
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text('Please Fill The Required Fields'),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      image25 = File(image.path);
      imagepath = image.path.toString();
    });
  }
}
