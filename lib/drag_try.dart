import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
//import 'package:firebase/firebase.dart' as fireBase;
//import 'dart:developer';


class User {
  final String location;
  final String description;
  final String username;
  final String postId;
  final String name;
  final String ownerId;
  final String mediaUrl;
  var status;
  String gpocName;
  String gpocContact;
  final bool isPrivate;
  final List<dynamic> consequences;
  final String timestamp;
  final Map<String,dynamic> likes;
  User(this.location, this.description, this.username, this.postId, this.name, this.ownerId, this.consequences, this.isPrivate,
      this.mediaUrl, this.status, this.timestamp, this.gpocName, this.gpocContact, this.likes);
}

class DragTry extends StatefulWidget {
  @override
  createState() => _DragTryState();
}

class _DragTryState extends State<DragTry> {
  @override
  void initState() {
    super.initState();
    getAllCardData();
  }

  Future addData() async{
    await _fireStore.collection('ack').document('${acknowledgedData1.postId}').setData({
      'status': 'acknowledged',
      'username': '${acknowledgedData1.username}',
      'location': '${acknowledgedData1.location}',
      'description': '${acknowledgedData1.description}',
      'postId': '${acknowledgedData1.postId}',
      'name': '${acknowledgedData1.name}',
      'ownerId': '${acknowledgedData1.ownerId}',
      'mediaUrl': '${acknowledgedData1.mediaUrl}',
      'isPrivate': '${acknowledgedData1.isPrivate}',
      'consequences': acknowledgedData1.consequences,
      'timestamp': '${acknowledgedData1.timestamp}',
      'likes': acknowledgedData1.likes,
      'gpocname': '${acknowledgedData1.gpocName}',
      'gpoccontact': '${acknowledgedData1.gpocContact}'
    });
  }

  Future getAllCardData() async {
    var data = await _fireStore.collection('notAck').getDocuments();
    var data1 = data.documents;
    for(var x in data1){
      notAcknowledged.add(User(x['location'], x['description'], x['username'], x['postId'], x['name'], x['ownerId'], x['consequences'], x['isPrivate'],
      x['mediaUrl'], x['status'], x['timestamp'].toString(), x['gpocname'], x['gpoccontact'], x['likes']));
    }
    data = await _fireStore.collection('ack').getDocuments();
    data1 = data.documents;
    for(var x in data1){
      acknowledged.add(User(x['location'], x['description'], x['username'], x['postId'], x['name'], x['ownerId'], x['consequences'], x['isPrivate'],
          x['mediaUrl'], x['status'], x['timestamp'].toString(), x['gpocname'], x['gpoccontact'], x['likes']));
    }
    data = await _fireStore.collection('completed').getDocuments();
    data1 = data.documents;
    for(var x in data1){
      completed.add(User(x['location'], x['description'], x['username'], x['postId'], x['name'], x['ownerId'], x['consequences'], x['isPrivate'],
          x['mediaUrl'], x['status'], x['timestamp'].toString(), x['gpocname'], x['gpoccontact'], x['likes']));
    }
    setState(() {});
  }

  final myController = TextEditingController();
  final myController1 = TextEditingController();
  var _fireStore = Firestore.instance;
  final List notAcknowledged = [];
  final List<User> acknowledged = [];
  final List<User> completed = [];
  User acknowledgedData1;
  User acknowledgedData2;
  var dragStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draggable"),
        backgroundColor: Colors.black,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color(0xFF030423),
            margin: EdgeInsets.fromLTRB(70.0, 110.0, 70.0, 110.0),
            height: 500.0,
            width: 292.0,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notAcknowledged.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Draggable(
                  child: Padding(
                    child: RaisedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text('${notAcknowledged[index].username}'),
                            content: Wrap(
                              direction: Axis.vertical,
                              children: <Widget>[
                                Card(
                                  color: Color(0xFFFBFBFB),
                                  child: Padding(
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Text("Description"),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                            '${notAcknowledged[index].description}'),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                  ),
                                ),
                                Card(
                                  color: Color(0xFFFBFBFB),
                                  child: Padding(
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Text("Location"),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                            '${notAcknowledged[index].location}'),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Color(0xFF030423),
                                textColor: Colors.white,
                                child: Text('Close'),
                              )
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                      color: Colors.red,
                      child: ListTile(
                        title: Text('${notAcknowledged[index].username}'),
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                  feedback: Material(
                    elevation: 5.0,
                    child: Container(
                      width: 284.0,
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.yellow,
                      child: Text(notAcknowledged[index].username),
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDragStarted: () {
                    acknowledgedData1 = notAcknowledged[index];
                    dragStatus = 'notAcknowledged';
                  },
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(70.0, 110.0, 70.0, 110.0),
            color: Color(0xFF030423),
            width: 292.0,
            height: 500.0,
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: acknowledged.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Draggable(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('${acknowledged[index].username}'),
                                content: Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Card(
                                      color: Color(0xFFFBFBFB),
                                      child: Padding(
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            Text("Description"),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                                '${acknowledged[index].description}'),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                      ),
                                    ),
                                    Card(
                                      color: Color(0xFFFBFBFB),
                                      child: Padding(
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            Text("Location"),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                                '${acknowledged[index].location}'),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Color(0xFF030423),
                                    textColor: Colors.white,
                                    child: Text('Close'),
                                  )
                                ],
                              ),
                              barrierDismissible: false,
                            );
                          },
                          child: ListTile(
                            title: Text('${acknowledged[index].username}'),
                          ),
                        ),
                      ),
                      feedback: Material(
                        elevation: 5.0,
                        child: Container(
                          width: 284.0,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.yellow,
                          child: Text('${acknowledged[index].username}'),
                        ),
                      ),
                      onDragStarted: () {
                        acknowledgedData2 = acknowledged[index];
                        dragStatus = 'acknowledged';
                      },
                    );
                  },
                );
              },
              onAccept: (data) {
                if (!acknowledged.contains(acknowledgedData1)) {
                  acknowledged.add(acknowledgedData1);
                  var l = acknowledged.length;
                  acknowledged[l-1].status = 'acknowledged';
                  notAcknowledged.remove(acknowledgedData1);
                  setState(() {});
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Wrap(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(labelText: 'GPOC Name'),
                            controller: myController,
                          ),
                          TextField(
                            decoration:
                            InputDecoration(labelText: 'GPOC Number'),
                            controller: myController1,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            acknowledgedData1.gpocName = myController.text;
                            acknowledgedData1.gpocContact = myController1.text;
                            Navigator.pop(context);
                          },
                          color: Colors.yellow,
                          child: Text('close'),
                        )
                      ],
                    ),
                    barrierDismissible: false,
                  );
                  addData();
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(70.0, 110.0, 70.0, 110.0),
            width: 292.0,
            height: 500.0,
            color: Color(0xff030423),
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: completed.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        color: Color(0xFF67FD64),
                        onPressed: () {
                          {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('${completed[index].description}'),
                                content: Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text('${completed[index].location}'),
                                  ],
                                ),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.yellow,
                                    child: Text('Close'),
                                  )
                                ],
                              ),
                              barrierDismissible: false,
                            );
                          }
                        },
                        child: ListTile(
                          title: Text('${completed[index].username}'),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    );
                  },
                );
              },
              onAccept: (data) {
                if (dragStatus == 'notAcknowledged') {
                  completed.add(acknowledgedData1);
                  notAcknowledged.remove(acknowledgedData1);
                } else {
                  completed.add(acknowledgedData2);
                  acknowledged.remove(acknowledgedData2);
                }
                _fireStore.collection('completed').add({
                  'description': acknowledgedData2.description,
                  'location': acknowledgedData2.location,
                  'username': acknowledgedData2.username,
                });
                setState(() {});
                print("hello");
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}