import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/botem_secreen/Tasks.dart';
import 'package:flutter_application_1/botem_secreen/arcich.dart';
import 'package:flutter_application_1/botem_secreen/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'sqlstates.dart';

class Cubitcloc extends Cubit<Appstates> {
  Cubitcloc() : super(Appinitstats());

  static Cubitcloc get(context) => BlocProvider.of(context);

  late List<Map> datatas = [];
  late List<Map> users = [];
  late List<Map> donetask = [];
  late List<Map> archivdetask = [];

  IconData iconfloat = Icons.add;
  bool ionbutten = false;

  int cureentindex = 0;
  List<Widget> screeens = [Tasks(), Dio(), Archived()];
  List<String> titles = ['dio', 'Taske', 'archived'];

  void changecurent(int val) {
    cureentindex = val;
    emit(Appnavigterboutemcurentchange());
  }

  late Database database;

  void creatdatabase() {
    openDatabase('task.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE TASKS(id INTEGER PRIMARY KEY , title TEXT , date TEXT, time TEXT, status TEXT) ')
          .then((value) {
        print('creat table tasks');
      }).catchError((error) {
        print('error creat table ${error.toString()}');
      });

      database
          .execute(
              'CREATE TABLE USER(id INTEGER PRIMARY KEY , name TEXT , password TEXT) ')
          .then((value) {
        print('creat table user');
      }).catchError((error) {
        print('error creat table ${error.toString()}');
      });
    }, onOpen: (database) {
      getalldata(database);
    }).then((value) {
      database = value;
      emit(Appcreatdatabasestat());
    });
  }

  inserttodatabase(
      {required String title,
      required String time,
      required String date}) async {
    await database.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO TASKS(title,date,time,status) VALUES("$title","$date","$time","new do")')
            .then((value) {
          emit(Appinsertdatabasestat());
          print('add secssefly $value');
          getalldata(database);
        }).catchError((onError) {
          print('error inserting ${onError.toString()}');
        }));
  }

  getalldata(database) {
    emit(Appgetloodstat());
    datatas = [];
    donetask = [];
    archivdetask = [];
    database.rawQuery('SELECT * FROM TASKS').then((value) {
      value.forEach((element) {
        if (element['status'].toString().contains('new do')) {
          datatas.add(element);
        } else if (element['status'].toString().contains('done')) {
          donetask.add(element);
        } else if (element['status'].toString().contains('archive')) {
          print(' last els $element');
          archivdetask.add(element);
        }
        print('new task: $datatas');
        print('new done: $donetask');
        print('new arc: $archivdetask');
      });

      //print('value get : $value');
      emit(Appgetdatabasestat());
    });
    //print('data : $datataskes');
  }

  Future inserttodatabaseuser({
    required String name,
    required String password,
  }) async {
    return await database.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO USER(name,password) VALUES("$name","$password")')
            .then((value) {
          print('add secssefly user $value');
        }).catchError((onError) {
          print('error inserting ${onError.toString()}');
        }));
  }

  void changeicon({required bool ischow, required IconData iconbf}) {
    ionbutten = ischow;
    iconfloat = iconbf;
    emit(Appchangeiconsestat());
  }

  void updattask({required int id, required String status}) {
    database.rawUpdate('UPDATE TASKS SET status = ? WHERE id = ?',
        ['updated $status', id]).then((value) {
      emit(Appupdatdatabasestat());
      getalldata(database);
      print('data task updat:    $value');
    });
    //print('updated: $count');
  }

  void delettask({required int id}) {
    database.rawDelete('DELETE FROM TASKS WHERE id = ?', [id]).then((value) {
      emit(Appdeletdatabasestat());
      getalldata(database);
      print('data task updat:    $value');
    });
    //print('updated: $count');
  }

  void gettt(database) {
    database.rawQuery('SELECT * FROM Test').then((value) {});
  }
}
