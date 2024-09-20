import 'package:databasemarch/functions.dart';
import 'package:databasemarch/screens/studentdetails.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

class StudentListGridView extends StatefulWidget {
  const StudentListGridView({super.key});

  @override
  State<StudentListGridView> createState() => _StudentListGridViewState();
}

class _StudentListGridViewState extends State<StudentListGridView> {
  void initState() {
    getstudentdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentList,
      builder: (context, value, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: value.length,
          itemBuilder: (context, index) {
            final student = value[index];

            return Card(
              margin: const EdgeInsets.all(5),
              elevation: 5,
              color: const Color.fromARGB(255, 204, 221, 184),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctr) => StudentDetails(stdetails: student),
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(
                        File(student.imagex),
                      ),
                      radius: 45,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      student.name,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Colors.black)),
                    ),
                    Text(
                      "Class: ${student.classname}, \nMobile: +91 - ${student.pnumber}",
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
