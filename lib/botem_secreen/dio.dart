import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocmangement/cubitbloc.dart';
import 'package:flutter_application_1/blocmangement/sqlstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant.dart';

class Dio extends StatelessWidget {
  const Dio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cubitcloc cubitcloc = Cubitcloc.get(context);

    return BlocConsumer<Cubitcloc, Appstates>(
      listener: (context, stat) {},
      builder: (context, stat) {
        return ListView.separated(
            itemBuilder: (context, index) =>
                itemlist(cubitcloc.donetask[index], context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.amberAccent,
                ),
            itemCount: cubitcloc.donetask.length);
      },
    );
  }
}
