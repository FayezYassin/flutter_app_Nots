import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'blocmangement/cubitbloc.dart';

Widget itemlist(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.0,
            child: Text(
              '${model['time']}',
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
          SizedBox(width: 12.0),
          IconButton(
            onPressed: () {
              Cubitcloc.get(context).updattask(id: model['id'], status: 'done');
            },
            icon: Icon(Icons.check_box),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              Cubitcloc.get(context)
                  .updattask(id: model['id'], status: 'archive');
            },
            icon: Icon(Icons.archive),
            color: Colors.black,
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      Cubitcloc.get(context).delettask(id: model['id']);
    },
  );
}
