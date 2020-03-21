import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProblemCard extends StatelessWidget {
  final status, index, color;
  List<Widget> consequences;
  int count = 1;
  ProblemCard(this.status, this.index, this.color);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        count = 1;
        consequences = [];
        for (var i in status[index]['consequences']) {
          consequences.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$count ' + i,
              maxLines: null,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ));
          count++;
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 50.0, top: 30.0),
                        child: Text(
                          status[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50.0),
                        ),
                      ),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 500,
                            width: 700,
                            child: DataTable(
                              dataRowHeight: 100,
                              columns: [
                                DataColumn(label: Text('')),
                                DataColumn(label: Text(''))
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(
                                    Text(
                                      'Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataCell(
                                    SingleChildScrollView(
                                      child: Text(
                                        status[index]['description'],
                                        style: TextStyle(fontSize: 14),
                                        maxLines: null,
                                      ),
                                    ),
                                  )
                                ]),
                                DataRow(cells: [
                                  DataCell(
                                    Text(
                                      'Likes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataCell(SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 2.5,
                                        ),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 0.0)),
                                    child: Slider(
                                      min: 0,
                                      max: 100,
                                      value: status[index]['likes'].length * 10,
                                      onChanged: (val) {},
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(
                                    Text(
                                      'Consequences',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                        height: 100.0,
                                        width: 500.0,
                                        child: ListView(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          children: consequences,
                                        )),
                                  )
                                ]),
                              ],
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            color: Color(0xFF030423),
                            textColor: Colors.white,
                            child: Center(
                              widthFactor: 50.0,
                              child: Text('Close'),
                            ),
                          )
                        ],
                      )),
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
          leading: Icon(Icons.fiber_manual_record, color: color),
          title: Text('${status[index]['name']}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
