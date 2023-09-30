import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocmangement/cubitbloc.dart';

import 'package:flutter_application_1/main.dart';
import 'package:sqflite/sqflite.dart';

import 'myhom.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Database database;
  late Cubitcloc cubitcloc;
  var namecontroler = new TextEditingController();
  var passwordcontroler = new TextEditingController();
  var keyfrom = GlobalKey<FormState>();
  bool scerty = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creatinstancedb();
  }

  @override
  Widget build(BuildContext context) {
    cubitcloc = Cubitcloc.get(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: keyfrom,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Image(
                    image: AssetImage('images/user.png'),
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: namecontroler,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'thies filed null';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        label: Text('User name'),
                        prefixIcon: Icon(Icons.person, color: Colors.red[700])),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: passwordcontroler,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'thies filed null';
                      }
                    },
                    decoration: InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.red[600],
                        ),
                        suffixIcon: IconButton(
                          icon: scerty
                              ? Icon(Icons.visibility, color: Colors.red[700])
                              : Icon(Icons.visibility_off_outlined,
                                  color: Colors.red[700]),
                          onPressed: () {
                            setState(() {
                              scerty = !scerty;
                            });
                          },
                        )),
                    obscureText: scerty,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(15.0)),
                      child: MaterialButton(
                          child: Text(
                            'login',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          onPressed: () {
                            if (keyfrom.currentState!.validate()) {
                              String name = cubitcloc.users[0]['name'];
                              String passw = cubitcloc.users[0]['password'];
                              print(passw);
                              if (name.contains(
                                  namecontroler.text.toString().trim())) {
                                if (passw.contains(
                                    passwordcontroler.text.toString().trim())) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Myhome()),
                                  );
                                }
                              }
                            }
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void creatinstancedb() async {
    database = await openDatabase('task.db', version: 1,
        onCreate: (database, version) {
      print('created');
    }, onOpen: (database) {
      getallUser(database).then((value) {
        cubitcloc.users = value;
        //print(users);
      });
    });
  }

  Future<List<Map>> getallUser(database) async {
    return await database.rawQuery('SELECT * FROM USER');
  }
}
