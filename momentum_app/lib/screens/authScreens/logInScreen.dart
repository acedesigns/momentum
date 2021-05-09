/* =======================================================
 *
 * Created by anele on 2020/05/05.
 *
 * @anele_ace
 *
 * =======================================================
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:connectivity/connectivity.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:momentum_app/API/momentum_api.dart';
import 'package:momentum_app/screens/appScreens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

const darkBlue = Color(0xFF265E9E);
const containerShadow = Color(0xFF91B4D8);
const extraDarkBlue = Color(0xFF91B4D8);

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode userName = FocusNode();
  FocusNode password = FocusNode();
  var showSnipper = false;
  var playerIddd;
  final _formKey = GlobalKey<FormState>();

  ScaffoldState scaffoldState;

  bool _isLoading = false;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSnipper,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Image(
                        alignment: Alignment.center,
                        width: 252.0,
                        height: 100,
                        image: AssetImage('assets/images/momentum_logo.jpg'),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(45.0)),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Log In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60.0,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    height: MediaQuery.of(context).size.height /
                                        3.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(35.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: containerShadow,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 1,
                                                )
                                              ]),
                                          child: TextFormField(
                                            controller: _emailController,
                                            onFieldSubmitted: (a) {
                                              userName.unfocus();
                                              FocusScope.of(context)
                                                  .requestFocus(password);
                                            },
                                            enableSuggestions: false,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              border: InputBorder.none,
                                              suffixIcon: SvgPicture.asset(
                                                'assets/icons/usericon.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                              hintText: 'E-mail',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(35.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: containerShadow,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 1,
                                                )
                                              ]),
                                          child: TextFormField(
                                            controller: _passwordController,
                                            onFieldSubmitted: (a) {
                                              password.unfocus();
                                            },
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              border: InputBorder.none,
                                              suffixIcon: SvgPicture.asset(
                                                'assets/icons/lockicon.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                              hintText: 'Password',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Forgot Password?',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _isLoading ? null : _loginMethod();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary:
                                                  Theme.of(context).hintColor,
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              35.0)))),
                                          child: Text(
                                            _isLoading ? 'Loging...' : 'Signin',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    ));
  }

  void _loginMethod() async {
    if (_emailController.text == '' || _passwordController.text == '') {
      _showMsg('Please fill in all fields');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': _emailController.text,
      'password': _passwordController.text
    };
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);

    //print(body['user']);
    //return;

    if (body['message'] == "The given data was invalid") {
      _showMsg(body['message']);
    } else if (body['code'] == 401) {
      _showMsg(body['error']);
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', body['token']);
      pref.setString('user', json.encode(body['user']));
      setState(() {
        _isLoading = false;
      });

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    setState(() {
      _isLoading = false;
    });
  } // Login method

}
