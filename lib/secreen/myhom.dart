import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocmangement/cubitbloc.dart';
import 'package:flutter_application_1/blocmangement/sqlstates.dart';
import 'package:flutter_application_1/botem_secreen/Dio.dart';
import 'package:flutter_application_1/botem_secreen/Tasks.dart';
import 'package:flutter_application_1/botem_secreen/arcich.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class Myhome extends StatelessWidget {
  var scffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController controlertitle = new TextEditingController();
  TextEditingController controlerdate = new TextEditingController();
  TextEditingController controlertime = new TextEditingController();

  var formkey = GlobalKey<FormState>();

  late Database database;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Cubitcloc()..creatdatabase(),
      child: BlocConsumer<Cubitcloc, Appstates>(
        listener: (context, stat) {
          if (stat is Appinsertdatabasestat) {
            Navigator.pop(context);
          }
        },
        builder: (context, stat) {
          Cubitcloc cubitcloc = Cubitcloc.get(context);
          return Scaffold(
              key: scffoldkey,
              appBar: AppBar(
                title: Text(cubitcloc.titles[cubitcloc.cureentindex]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubitcloc.ionbutten) {
                    if (formkey.currentState!.validate()) {
                      cubitcloc.inserttodatabase(
                          title: controlertitle.text,
                          time: controlertime.text,
                          date: controlerdate.text);
                      /*  inserttodatabase(
                              title: controlertitle.text,
                              time: controlertime.text,
                              date: controlerdate.text)
                          .then((value) {
                        getalldata(database).then((value) {
                         
                         
                          /* setState(() {
                          iconfloat = Icons.edit;
                          datatas = value;
                        });*/

                          ionbutten = !ionbutten;

                          print('add sucsessfly with then $value');
                          print(datatas);
                        });
                      });*/
                    }
                  } else {
                    scffoldkey.currentState!
                        .showBottomSheet((context) => Container(
                              padding: EdgeInsets.all(12),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: controlertitle,
                                      decoration: InputDecoration(
                                          label: Text('Titel'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          prefixIcon: Icon(Icons.title)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'this is faled';
                                        }

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: controlertime,
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          controlertime.text =
                                              value!.format(context).toString();
                                          print('time ${controlertime.text}');
                                        });
                                      },
                                      decoration: InputDecoration(
                                          label: Text("Time"),
                                          prefixIcon:
                                              Icon(Icons.watch_later_outlined),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'this is faled';
                                        }

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: controlerdate,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          label: Text('Date'),
                                          prefixIcon: Icon(
                                              Icons.calendar_today_rounded)),
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-12-12'))
                                            .then((value) {
                                          controlerdate.text =
                                              DateFormat.yMMMd().format(value!);
                                          print(DateFormat.yMMMd()
                                              .format(value)
                                              .toString());
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'this is faled';
                                        }

                                        return null;
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .closed
                        .then((value) {
                      cubitcloc.changeicon(ischow: false, iconbf: Icons.edit);
                      //  cubitcloc.ionbutten = !cubitcloc.ionbutten;

                      //cubitcloc.iconfloat = Icons.edit;
                    });
                    cubitcloc.changeicon(ischow: true, iconbf: Icons.add);

                    //cubitcloc.ionbutten = true;

                    //cubitcloc.iconfloat = Icons.add;
                  }
                  ///////////////////////////////////
                  //
                },
                child: Icon(cubitcloc.iconfloat),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: Cubitcloc.get(context).cureentindex,
                onTap: (val) {
                  Cubitcloc.get(context).changecurent(val);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Do Task'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archive'),
                ],
              ),
              body: ConditionalBuilder(
                  condition: stat is! Appgetloodstat,
                  builder: (context) =>
                      cubitcloc.screeens[cubitcloc.cureentindex],
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator())));
        },
      ),
    );
  }
}
