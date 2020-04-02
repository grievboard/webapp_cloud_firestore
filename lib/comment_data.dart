import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class CommentData extends StatelessWidget {

  final firestore = Firestore.instance;
  final postId;
  CommentData({Key key, this.postId});
  int count = 0;
  List<Widget> commentData = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:  firestore.collection('comments').document(postId).collection('comments').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final data = snapshot.data.documents;
          for(var i in data){
            final commData = i.data['comment'];
            commentData.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$count ' + commData,
                maxLines: null,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
              ),
            ),
            );
            count++ ;
          }
        }
        return Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: commentData,
            ),
          ),
        );
      }
    );
  }
}
