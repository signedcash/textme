import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/profile.dart';
import 'package:textme/domain/model/user.dart';
import 'package:textme/domain/user_info.dart';
import 'package:textme/presentation/profile_views/profile.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController descriptTextController = TextEditingController();
  TextEditingController imgUrlTextController = TextEditingController();

  updateProfile(Profile curr) async {
    if (nameTextController.text.isNotEmpty ||
        ageTextController.text.isNotEmpty ||
        countryTextController.text.isNotEmpty ||
        cityTextController.text.isNotEmpty ||
        descriptTextController.text.isNotEmpty) {
      bool statusUpdate = await ServiceUtil().profileService.update(Profile(
          user: User(
              id: curr.user.id,
              name: nameTextController.text.isNotEmpty
                  ? nameTextController.text
                  : curr.user.name,
              username: curr.user.username,
              imgUrl: imgUrlTextController.text.isNotEmpty
                  ? imgUrlTextController.text
                  : curr.user.imgUrl),
          city: cityTextController.text.isNotEmpty
              ? cityTextController.text
              : curr.city,
          country: countryTextController.text.isNotEmpty
              ? countryTextController.text
              : curr.country,
          age: ageTextController.text.isNotEmpty
              ? int.parse(ageTextController.text)
              : curr.age,
          descript: descriptTextController.text.isNotEmpty
              ? descriptTextController.text
              : curr.descript));
      if (!statusUpdate) {
        errorAlert(context);
      } else
        Navigator.of(context).pop();
    } else {
      emptyAlert(context);
    }
  }

  void emptyAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Text("Oops..."),
        content: Text("All fields are empty"),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void errorAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Text("Oops..."),
        content: Text("Data update error"),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
        future: ServiceUtil().profileService.getProfileByUser(currentUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black38,

                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        )
                      ],
                      color: Color(0xcc83efff),
                      fontSize: 42,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    color: Colors.grey,
                    iconSize: 32,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    icon: const Icon(EvaIcons.arrowIosBackOutline),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => ProfilePage()),
                      (Route<dynamic> route) => false,
                    ),
                  ),
                ),
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 20,
                            bottom: 0,
                          ),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 95.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                  ),
                                  controller: nameTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.user.name == ""
                                        ? "None"
                                        : "${snapshot.data.user.name}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 20,
                            bottom: 0,
                          ),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: Text(
                                  'Image Url',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 95.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                  ),
                                  controller: imgUrlTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.user.imgUrl == ""
                                        ? "None"
                                        : "${snapshot.data.user.imgUrl}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 20,
                            bottom: 0,
                          ),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: Text(
                                  'Age',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 95.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                  ),
                                  controller: ageTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.age == 0
                                        ? "None"
                                        : "${snapshot.data.age}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 20,
                            bottom: 0,
                          ),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: Text(
                                  'Country',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 95.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                  ),
                                  controller: countryTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.country == ""
                                        ? "None"
                                        : "${snapshot.data.country}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 20,
                            bottom: 0,
                          ),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: Text(
                                  'City',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 95.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                  ),
                                  controller: cityTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.city == ""
                                        ? "None"
                                        : "${snapshot.data.city}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 20,
                            bottom: 0,
                          ),
                          width: 350,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 125.0 *
                                    MediaQuery.of(context).devicePixelRatio,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 3,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  obscureText: false,
                                  controller: descriptTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "${snapshot.data.descript}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        InkWell(
                          onTap: () => updateProfile(snapshot.data),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 20,
                              bottom: 0,
                            ),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black38,

                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        )
                      ],
                      color: Color(0xcc83efff),
                      fontSize: 42,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    color: Colors.grey,
                    iconSize: 32,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    icon: const Icon(EvaIcons.arrowIosBackOutline),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Container(
                  child: Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ));
          }
        });
  }
}
