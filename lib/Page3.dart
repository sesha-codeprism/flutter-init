import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:testapp/CircleProgress.dart';

class Page3 extends StatefulWidget {
  Page3State createState() => Page3State();
}

class Page3State extends State<Page3> with TickerProviderStateMixin {
  AnimationController progressController;
  Animation animation;
  double end = 10.0;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 0,end: this.end).animate(progressController)..addListener((){
      setState(() {
      });
    });
    this.progressController.forward();
  }


  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Page 3"),
      ),
      body: Center(
        child: CustomPaint(

          foregroundPainter: CircleProgress(animation.value), // this will add custom painter after child
          child: Container(
            width: 200,
            height: 200,
            child: PlatformButton(
                onPressed: (){
                  end = this.end + 10;
                  progressController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
                  animation = Tween<double>(begin: 0,end: this.end).animate(progressController)..addListener((){
                    setState(() {
                      end = this.end;
                    });
                  });
                  if(animation.value < this.end)
                    {
                      this.progressController.forward();
                    }
                  else{
                    this.progressController.animateTo(this.end);
                  }
                },
                child: Center(child: PlatformText("${animation.value.toInt()} %",style: TextStyle(
                    fontSize: 18,
                ),))),
          ),
        ),

      ),
    );
  }
}
