import 'package:flutter/material.dart';
import 'package:qr_control/services/auth.dart';

class SignupWithEmail extends StatelessWidget {
  final _eController = TextEditingController();
  final _pController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _eController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff2470c7),
                ),
                labelText: 'email'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: _pController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff2470c7),
                ),
                labelText: 'password'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 1.4 * (MediaQuery.of(context).size.height / 20),
              width: 5 * (MediaQuery.of(context).size.width / 10),
              margin: EdgeInsets.only(bottom: 20),
              child: RaisedButton(
                elevation: 5.0,
                color: Color(0xff2470c7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  AuthService()
                      .signInWithEmailandPassword(
                          _eController.text.trim(), _pController.text.trim())
                      .then((value) => print(value));
                },
                child: Text(
                  "Sign In!",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
