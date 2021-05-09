/* =======================================================
 *
 * Created by anele on 2020/05/05.
 *
 * @anele_ace
 *
 * =======================================================
 */

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:momentum_app/screens/appScreens/depositToAccount.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

TextEditingController firstNameController = TextEditingController();

class _UserAccountState extends State<UserAccount>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getUserAccountData();
  }

  var showSnipper = false;
  var userData;
  final currency = new NumberFormat("#,##0.00");

  Future<void> getUserAccountData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });

    print(userData['accounts']);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          inAsyncCall: showSnipper,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Your Accounts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Container(
                      child: userData['accounts'].length == 0
                          ? Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                'You Have no Accccounts',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                ),
                              )))
                          : Column(
                              children: <Widget>[
                                SizedBox(
                                    height: 370,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: userData['accounts'].length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          child: Card(
                                            elevation: 5.0,
                                            color: Colors.white,
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 40,
                                                  bottom: 40),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    ListTile(
                                                        contentPadding:
                                                            EdgeInsets.all(7.0),
                                                        title: Text(
                                                          (userData['accounts'][
                                                                          index]
                                                                      [
                                                                      'account_type'] ==
                                                                  'ch')
                                                              ? 'Cheque'
                                                              : (userData['accounts']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'account_type'] ==
                                                                      'cr')
                                                                  ? 'Credit'
                                                                  : 'Loan',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Account number : ' +
                                                                userData['accounts']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'account_number']
                                                                    .toString()),
                                                            Text('Balance : ' +
                                                                currency.format(
                                                                    userData['accounts']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'account_balance']))
                                                          ],
                                                        )),
                                                    Divider(),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: TextButton(
                                                              onPressed: () {
                                                                DepositToAccount();
                                                              },
                                                              child: Text(
                                                                  'Deposit'),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                primary: Colors
                                                                    .white,
                                                                elevation: 5,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFFF835F),
                                                                onSurface:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: TextButton(
                                                                child: Text(
                                                                    'Withdraw'),
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .white,
                                                                  elevation: 5,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blueAccent,
                                                                  onSurface:
                                                                      Colors
                                                                          .grey,
                                                                ),
                                                                onPressed:
                                                                    () {}),
                                                          ),
                                                        ])
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {},
                                        );
                                      },
                                    ))
                              ],
                            )),
                ],
              ),
            ),
          ))),
    );
  }
}
