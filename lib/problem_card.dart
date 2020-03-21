import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProblemCard extends StatelessWidget {
  final status, index;
  var consequences;
  ProblemCard(this.status, this.index);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        consequences = [];
        for (var i in status[index]['consequences']) {
          consequences.add(i);
        }
        showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    title: Text(status[index]['name']),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          color: Color(0xFFFBFBFB),
                          child: Padding(
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Wrap(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  Text(
                                    "Description",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      status[index]['description'],
                                      maxLines: 10,
                                    ),
                                  ),
                                ],
                              ),
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
                                    '${status[index]['likes'].length}'),
                              ],
                            ),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                        Card(
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            height: 100.0, //consequences.length  * 70,
                            width: 500.0,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: consequences.length,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  // return the header
                                  return Text('Consequences',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$index '+' ${consequences[index]}',
                                    maxLines: null,
                                    textAlign: TextAlign.left,
                                  ),
                                );
                              },
                            ),
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
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (context, animation1, animation2) {
              return null;
            });
      },
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          leading: Icon(Icons.fiber_manual_record, color: Colors.red),
          title: Text('${status[index]['name']}'),
        ),
      ),
    );
  }
}
