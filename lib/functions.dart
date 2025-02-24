import 'package:databasemarch/model/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentList = ValueNotifier([]);
late Database _db;
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student_db',
    version: 1,
    onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, classname TEXT, father TEXT, pnumber TEXT, imagex TEXT)');
    },
  );
  print("Database created successfully.");
}

Future<void> getstudentdata() async {
  final result = await _db.rawQuery("SELECT * FROM student");
  // print('All Students data : ${result}');
  studentList.value.clear();
  for (var map in result) {
    final student = StudentModel.fromMap(map);
    studentList.value.add(student);
  }
  studentList.notifyListeners();
}

Future<void> addstudent(StudentModel value) async {
  await _db.rawInsert(
    'INSERT INTO student(name,classname,father,pnumber,imagex) VALUES(?,?,?,?,?)',
    [
      value.name,
      value.classname,
      value.father,
      value.pnumber,
      value.imagex,
    ],
  );
  getstudentdata();
}

Future<void> deleteStudent(id) async {
  await _db.delete('student', where: 'id=?', whereArgs: [id]);
  getstudentdata();
}

Future<void> editStudent(
  id,
  name,
  classname,
  father,
  pnumber,
  imagex,
) async {
  final dataflow = {
    'name': name,
    'classname': classname,
    'father': father,
    'pnumber': pnumber,
    'imagex': imagex,
  };
  await _db.update('student', dataflow, where: 'id=?', whereArgs: [id]);
  getstudentdata();
}
