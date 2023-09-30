import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocmangement/cubitbloc.dart';
import 'package:flutter_application_1/blocmangement/sqlstates.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cubitcloc cubitcloc = Cubitcloc.get(context);

    return BlocConsumer<Cubitcloc, Appstates>(
      listener: (context, stat) {},
      builder: (context, stat) {
        return ConditionalBuilder(
            condition: cubitcloc.datatas.length > 0,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(microseconds: 1300),
                      child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                              child:
                                  itemlist(cubitcloc.datatas[index], context))),
                    ),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.blue,
                    ),
                itemCount: cubitcloc.datatas.length),
            fallback: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.blue,
                        size: 35,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'لا يوجد مهام جديدة',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ));
      },
    );
  }
}
