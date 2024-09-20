import 'dart:io';

import 'package:databasemarch/functions.dart';
import 'package:databasemarch/model/StudentModel.dart';
import 'package:databasemarch/screens/studentdetails.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<StudentModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = studentList.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<StudentModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = studentList.value;
      // Reset to the original list if the search is empty
    } else {
      // Filter based on student properties
      result = studentList.value
          .where((student) =>
              student.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.classname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          backgroundColor: Color(0xFF1E1E2F),
          title: const Text(
            'Search Student',
            style: TextStyle(
                color: const Color.fromARGB(255, 183, 215, 143),
                fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 350, height: 55, // Adjust the width as needed
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 183, 215, 143),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 183, 215, 143),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<StudentModel>>(
          valueListenable: studentList,
          builder: (context, studentListValue, child) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: finduser.length,
                      itemBuilder: (context, index) {
                        final finduserItem = finduser[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: const Color.fromARGB(255, 204, 221, 184),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(File(finduserItem.imagex)),
                            ),
                            title: Text(finduserItem.name),
                            subtitle: Text('CLASS : ${finduserItem.classname}'),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (ctr) =>
                                    StudentDetails(stdetails: finduserItem),
                              ));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
