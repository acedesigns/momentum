/* =======================================================
 *
 * Created by anele on 2020/05/05.
 *
 * @anele_ace
 *
 * =======================================================
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momentum_app/API/momentum_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:momentum_app/screens/appScreens/userProfileScreen.dart';
import 'package:momentum_app/screens/appScreens/userAccountScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const darkBlue = Color(0xFF265E9E);
const extraDarkBlue = Color(0xFF91B4D8);

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DateTime currentBackPressTime;

  var showSpinner = false;
  //var userData;

  @override
  void initState() {
    super.initState();
    _getUserProfile();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _getUserProfile() async {
    /*
    var res = await CallApi().getWithToken('profile');
    var body = res.body;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', body);
    */
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.amberAccent,
              centerTitle: true,
              title: Text(
                'Momentum Bank',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              leading: Container(),
              bottom: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.indigo,
                  unselectedLabelStyle: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                  tabs: [
                    Tab(
                      text: 'Profile',
                    ),
                    Tab(
                      text: 'My Account',
                    )
                  ])),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: TabBarView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: UserProfile(),
                  //child: Text('User Profile'),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: UserAccount(),
                    //child: Text('User Accounts'),
                  ),
                )
              ],
              controller: _tabController,
            ),
          ),
        ),
        onWillPop: onWillPop);
  }
}
