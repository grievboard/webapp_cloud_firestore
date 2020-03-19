import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:convert';
//import 'dart:developer';

class DragTry extends StatefulWidget {
  @override
  createState() => _DragTryState();
}

class _DragTryState extends State<DragTry> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var startData = await _fireStore.collection('notAck').getDocuments();
    var midData = startData.documents;
    for (var x in midData) {
      notAcknowledged.add(x.data);
    }
    startData = await _fireStore.collection('ack').getDocuments();
    midData = startData.documents;
    for (var x in midData) {
      acknowledged.add(x.data);
    }
    startData = await _fireStore.collection('completed').getDocuments();
    midData = startData.documents;
    for (var x in midData) {
      completed.add(x.data);
    }
    setState(() {});
  }

  final myController = TextEditingController();
  final myController1 = TextEditingController();
  var _fireStore = Firestore.instance;
  final List notAcknowledged = [];
  final List acknowledged = [];
  final List completed = [];
  Map<String, dynamic> acknowledgedData1;
  Map<String, dynamic> acknowledgedData2;
  String dragStatus;
  int ind, ind1;

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color(0xFF030423),
            ),
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
                            title: Text(notAcknowledged[index]['name']),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                        SingleChildScrollView(
                                          child: Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                notAcknowledged[index]['description'],
                                                maxLines: 10,
                                              ),
                                            ),
                                        ),
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
                                        Text("Likes"),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                            '${notAcknowledged[index]['likes'].length}'),
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
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.fiber_manual_record,
                              color: Colors.red),
                          title: Text('${notAcknowledged[index]['name']}'),
                        ),
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
                      child: Text(notAcknowledged[index]['name']),
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDragStarted: () {
                    acknowledgedData1 = notAcknowledged[index];
                    dragStatus = 'notAcknowledged';
                    ind = index;
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color(0xFF030423),
            ),
            margin: EdgeInsets.fromLTRB(70.0, 110.0, 70.0, 110.0),
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
                          color: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title:
                                    Text('${acknowledged[index]['username']}'),
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
                                                '${acknowledged[index]['description']}'),
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
                                                '${acknowledged[index]['location']}'),
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
                            title: Text('${acknowledged[index]['name']}'),
                            leading: Icon(Icons.fiber_manual_record,
                                color: Colors.deepOrangeAccent),
                          ),
                        ),
                      ),
                      feedback: Material(
                        elevation: 5.0,
                        child: Container(
                          width: 284.0,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.yellow,
                          child: Text('${acknowledged[index]['username']}'),
                        ),
                      ),
                      onDragStarted: () {
                        acknowledgedData2 = acknowledged[index];
                        dragStatus = 'acknowledged';
                        ind1 = index;
                      },
                    );
                  },
                );
              },
              onAccept: (data) {
                if (!acknowledged.contains(acknowledgedData1)) {
                  acknowledged.add(acknowledgedData1);
                  notAcknowledged.remove(acknowledgedData1);
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
                          onPressed: () async {
                            acknowledgedData1['gpocname'] = myController.text;
                            acknowledgedData1['gpoccontact'] =
                                myController1.text;
                            acknowledgedData1['status'] = 'ack';
                            _fireStore
                                .collection('ack')
                                .document(acknowledgedData1['postId'])
                                .setData(acknowledgedData1);
                            _fireStore
                                .collection('notAck')
                                .document(acknowledgedData1['postId'])
                                .delete();
                            _fireStore
                                .collection('posts')
                                .document(acknowledgedData1['ownerId'])
                                .collection('userPosts')
                                .document(acknowledgedData1['postId'])
                                .updateData({
                              'gpocname': acknowledgedData1['gpocname'],
                              'gpoccontact': acknowledgedData1['gpoccontact'],
                              'status': 'ack'
                            });
                            myController1.clear();
                            myController.clear();
                            Navigator.pop(context);
                            setState(() {});
                          },
                          color: Colors.yellow,
                          child: Text('close'),
                        )
                      ],
                    ),
                    barrierDismissible: false,
                  );
                  //setState(() {});
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color(0xFF030423),
            ),
            margin: EdgeInsets.fromLTRB(70.0, 110.0, 70.0, 110.0),
            width: 292.0,
            height: 500.0,
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: completed.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            {
                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                      '${completed[index]['description']}'),
                                  content: Wrap(
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text('${completed[index]['location']}'),
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
                            title: Text('${completed[index]['name']}'),
                            leading: Icon(
                              Icons.fiber_manual_record,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              onAccept: (data) async {
                if (dragStatus == 'notack') {
                  completed.add(acknowledgedData1);
                  notAcknowledged.remove(acknowledgedData1);
                } else {
                  completed.add(acknowledgedData2);
                  acknowledged.remove(acknowledgedData2);
                }
                acknowledgedData2['status'] = 'done';
                _fireStore
                    .collection('completed')
                    .document(acknowledgedData2['postId'])
                    .setData(acknowledgedData2);
                _fireStore
                    .collection('ack')
                    .document(acknowledgedData2['postId'])
                    .delete();
                _fireStore
                    .collection('posts')
                    .document(acknowledgedData2['ownerId'])
                    .collection('userPosts')
                    .document(acknowledgedData2['postId'])
                    .updateData(acknowledgedData2);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

