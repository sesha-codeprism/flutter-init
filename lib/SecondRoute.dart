import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:testapp/Page3.dart';
import 'package:testapp/utils/globals.dart';
import 'package:testapp/utils/helpers.dart';
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: "Main App",
      home: Screen2(),
    );
  }
}

class CircleControllerState extends State<Screen2> {
  double renderTime = 0.0;
  Controller controller;

  @override
  void initState() {
    controller = Controller(renderTime: this.renderTime, demoUpdated: _update);
    super.initState();
    print("Init State");
  }

  _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(
          "RenderText",
          style: TextStyle(
            color: HexColor(GLOBALS.colors.primary),
          ),
        ),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Flexible(
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 300,
                  width: 300,
                  child: FlareActor("assets/dynamicCirlcle.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      controller: controller),
                ),
                PlatformButton(
                    child: PlatformText("10%"),
                    onPressed: () => {
                          setState(() {
                            renderTime = 0.1;
                            print(this.renderTime);
                            controller.demoUpdated();
                          })
                        }),
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

                    }),
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Page3()) )
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

typedef void OnUpdated();

class Controller implements FlareController {
  ActorAnimation _circle;

  double renderTime;
  final OnUpdated demoUpdated;

  Controller({this.renderTime, this.demoUpdated});

  @override
  ValueNotifier<bool> isActive;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    debugPrint("Reanimate");
    this._circle.apply(renderTime, artboard, 1.0);
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _circle = artboard.getAnimation("Dynamic Circle");
    debugPrint('initialized');
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}

class Screen2 extends StatefulWidget {
  CircleControllerState createState() => CircleControllerState();
}
