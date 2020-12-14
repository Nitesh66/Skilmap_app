//assigned to login
import 'package:flutter/material.dart';
import 'package:skilmap/firebase/authentication.dart';
import 'package:skilmap/firebase/login_screen.dart';

class SignupPage extends StatefulWidget {
  SignupPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _SignupPageState createState() => _SignupPageState();
}

enum FormMode { SIGNUP }

class _SignupPageState extends State<SignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  //String _errorMessage = "";

  // this will be used to identify the form to show
  //FormMode _formMode = FormMode.LOGIN;
  bool _isIos = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
              formWidget(),
              loginButtonWidget(),
              secondaryButton(),
              //errorWidget(),
              progressWidget()
            ]));
  }

//assigned to login

  Widget progressWidget() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _emailWidget(),
          _passwordWidget(),
        ],
      ),
    );
  }

  Widget _emailWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                // hintText: 'EMAIL',
                // hintStyle: ,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),
            validator: (value) =>
                value.isEmpty ? 'Email cannot be empty' : null,
            onSaved: (value) => _email = value.trim(),
          ),
        ],
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'PASSWORD ',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),
            validator: (value) =>
                value.isEmpty ? 'Password cannot be empty' : null,
            onSaved: (value) => _password = value.trim(),
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget nicknameWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
                labelText: 'NICK NAME ',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),
          ),
        ],
      ),
    );
  }

  Widget loginButtonWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          Container(
              height: 40.0,
              child: MaterialButton(
                //borderRadius: BorderRadius.circular(20.0),
                //shadowColor: Colors.greenAccent,
                color: Colors.green,
                elevation: 7.0,
                // child: GestureDetector(
                onPressed: _validateAndSubmit,
                //showForm();

                child: Center(
                  child: Text(
                    'SIGNUP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget secondaryButton() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Container(
            height: 40.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text('Go Back',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void showForm() {
  //  _errorMessage = "";
  // }

  /*Widget errorWidget() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }*/

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _validateAndSubmit() async {
    setState(() {
      //_errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        /*if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
        } else {
          userId = await widget.auth.signUp(_email, _password);
        }
        */
        userId = await widget.auth.signUp(_email, _password);
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          // if (_isIos) {
          //  _errorMessage = e.details;
          //} else
          //  _errorMessage = e.message;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
    //Login();
  }
}
