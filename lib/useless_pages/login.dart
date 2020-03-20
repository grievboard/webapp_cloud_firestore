import '../drag_try.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  static String id = '/login_screen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void initState() {
    super.initState();
    getData();
  }

  @override
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  List<String>  idData= [];
  bool showSpinner = false;
  String email, password, id;
  var eController = TextEditingController();
  var pController = TextEditingController();
  var iController = TextEditingController();

  void getData() async {
    var startData = await _fireStore.collection('admins').getDocuments();
    var midData = startData.documents;
    for (var x in midData) {
      idData.add(x.data['Teacher ID']);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final emailField = Container(
      width: 550,
      child: TextField(
        controller: eController,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        onChanged: (value) {
          email = value;
        },
      ),
    );
    final idField = Container(
      width: 550,
      child: TextField(
        controller: iController,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Admin ID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        onChanged: (value) {
          id = value;
        },
      ),
    );
    final passwordField = Container(
      width: 550.0,
      child: TextField(
        controller: pController,
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        onChanged: (value) {
          password = value;
        },
      ),
    );
    final loginButon = Container(
      width: 250.0,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF030423),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            setState(() {
              showSpinner = true;
            });
            try {
              final user = await _auth.signInWithEmailAndPassword(
                  email: email, password: password
              );
              if (user != null) {
                Navigator.pushNamed(context, DragTry.id);
                if(!idData.contains(id)){
                  _fireStore.collection('admins').add({
                    'Teacher ID': id,
                    'Email': email,
                    'Password': password
                  });
                }
              }
              setState(() {
                showSpinner = false;
                eController.clear();
                pController.clear();
                iController.clear();
              });
            } catch (e) {
              showSpinner = false;
//              AlertDialog(
//                title: Text('Wrong Password'),
//                content: Text('$e')
//              );
            print(e);
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF030423),
          title: Text('GrievBoard'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: FlatButton(
                  color: Color(0xFF030423),
                  onPressed: () {},
                  child: Text('Home'),
                  textColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: FlatButton(
                  color: Color(0xFF030423),
                  onPressed: () {},
                  child: Text('About'),
                  textColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: FlatButton(
                  color: Color(0xFF030423),
                  onPressed: () {},
                  child: Text('Login'),
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Container(
            color: Color(0xFFFAFAFA),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                Container(
//                  height: 155.0,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: FileImage(
//                       height: 50.0,
//                        width: 50.0,
//                        fit: BoxFit.contain,
//                      ),
//                    )
//                  )
//                ),
                  SizedBox(height: 45.0),
                  idField,
                  SizedBox(height: 25.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
