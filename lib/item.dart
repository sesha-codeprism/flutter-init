import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'utils/globals.dart';
import 'utils/helpers.dart';

import 'SecondRoute.dart';


class Item extends StatefulWidget {
  @override
  RenderState createState() => RenderState();
}

class RenderState extends State<Item> {
  Map data;
  List userData;
  Brightness brightness = Brightness.light;
  Color buttonColor = HexColor(GLOBALS.colors.primary);

  Future getData() async {
    http.Response response =
        await http.get("https://reqres.in/api/users?page=1");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = new ThemeData(
      primarySwatch: Colors.purple,
    );
    final materialDarkTheme = new ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.teal,
    );

    final cupertinoTheme = new CupertinoThemeData(
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: Colors.purple,
        darkColor: Colors.cyan,
      ),
    );

    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Center(
            child: PlatformText(
              'API',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return ListView.builder(
                itemCount: userData == null ? 0 : userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: (MediaQuery.of(context).size.height /
                              userData.length) *
                          0.87,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(userData[index]["avatar"]),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30.0),
                                  child: PlatformText(
                                    userData[index]['first_name'],
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: PlatformText(
                                    userData[index]['last_name'],
                                    style: TextStyle(
                                        color:
                                            HexColor(GLOBALS.colors.primary)),
                                  ),
                                ),
                                PlatformButton(
                                  child: PlatformText(
                                    "Something",
                                    style: TextStyle(
                                        color:
                                            HexColor(GLOBALS.colors.primary)),
                                  ),
                                  onPressed: () => {
                                    debugPrint(GLOBALS.colors.primary),
                                    GLOBALS.colors.primary = '#ed3636',
                                    setState(() {
                                      buttonColor =
                                          HexColor(GLOBALS.colors.primary);

                                    }),
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => SecondRoute()) )
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                });
          },
        ));
  }
}
