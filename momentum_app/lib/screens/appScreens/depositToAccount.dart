/* =======================================================
 *
 * Created by anele on 2020/05/09.
 *
 * @anele_ace
 *
 * =======================================================
 */

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:momentum_app/API/momentum_api.dart';

class DepositToAccount extends StatefulWidget {
  //final appoinmentId;
  //final String process;
  //final String path;

  @override
  _DepositToAccountState createState() => _DepositToAccountState();
}

class _DepositToAccountState extends State<DepositToAccount> {
  var showSpinner = false;

  @override
  void initState() {
    super.initState();
    _getAccountInfo();
  }

  _getAccountInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            print(currentFocus);
          },
          child: Stack(children: <Widget>[Text('Let Us Deposit')]),
        ),
      ),
    );
  }
}
