import 'package:databasemarch/functions.dart';
import 'package:databasemarch/model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class EditStudent extends StatefulWidget {
  final student;
  const EditStudent({super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  File? image25;
  String? updatedImagepath;

  final _formKey = GlobalKey<FormState>(); //  form key for the validation

  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            backgroundColor: Color(0xFF1E1E2F),
            title: const Text(
              'Edit Student',
              style: TextStyle(
                  color: const Color.fromARGB(255, 183, 215, 143),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  editstudentclicked(
                    context,
                    widget.student,
                  );
                },
                icon: const Icon(Icons.cloud_upload,
                    color: const Color.fromARGB(255, 183, 215, 143)),
                color: Colors.white,
              )
            ],
            centerTitle: false,
          )),
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
                      InkWell(
                        onTap: () {
                          getimage(ImageSource.gallery);
                        },
                        child: CircleAvatar(
                          backgroundImage: updatedImagepath != null
                              ? FileImage(File(updatedImagepath!))
                              : FileImage(File(widget.student.imagex)),
                          radius: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // Name input field
                  Row(
                    children: [
                      const Icon(
                        Icons.abc_outlined,
                        color: const Color.fromARGB(255, 183, 215, 143),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 224, 233, 237)),
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 183, 215, 143)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 131, 236, 134),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 131, 236, 134),
                                    width: 1), // Border color when focused
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Class input field
                  Row(
                    children: [
                      const Icon(Icons.class_outlined,
                          color: const Color.fromARGB(255, 183, 215, 143)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _classController,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 224, 233, 237)),
                          decoration: InputDecoration(
                              labelText: "Class",
                              labelStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 183, 215, 143)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 131, 236, 134),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 131, 236, 134),
                                    width: 1), // Border color when focused
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Class';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Guardian input field
                  Row(
                    children: [
                      const Icon(Icons.person,
                          color: const Color.fromARGB(255, 183, 215, 143)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _guardianController,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 224, 233, 237)),
                          decoration: InputDecoration(
                              labelText: "Guardian",
                              labelStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 183, 215, 143)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 131, 236, 134),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 131, 236, 134),
                                    width: 1), // Border color when focused
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Parent Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mobile input field
                  Row(
                    children: [
                      const Icon(Icons.phone_sharp,
                          color: const Color.fromARGB(255, 183, 215, 143)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mobileController,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 224, 233, 237)),
                          decoration: InputDecoration(
                              labelText: "Mobile",
                              labelStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 183, 215, 143)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 131, 236, 134),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 131, 236, 134),
                                    width: 1), // Border color when focused
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Mobile';
                            } else if (value.length != 10) {
                              return 'Mobile number should be 10 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _classController.text = widget.student.classname;
    _guardianController.text = widget.student.father;
    _mobileController.text = widget.student.pnumber;
    updatedImagepath = widget.student.imagex;
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> editstudentclicked(
      BuildContext context, StudentModel student) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final classA = _classController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final updatedStudent = StudentModel(
        id: student.id,
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: updatedImagepath ?? student.imagex,
      );

      await editStudent(
        student.id!,
        updatedStudent.name,
        updatedStudent.classname,
        updatedStudent.father,
        updatedStudent.pnumber,
        updatedStudent.imagex,
      );

      // Refresh the data in the StudentList widget.
      getstudentdata();

      Navigator.of(context).pop();
    }
  }

  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      image25 = File(image.path);
      updatedImagepath = image.path.toString();
    });
  }
}
