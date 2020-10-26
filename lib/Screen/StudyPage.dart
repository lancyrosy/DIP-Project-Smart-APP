
import 'package:dip_taskplanner/components/StudyMode.dart';
import 'package:dip_taskplanner/components/quad_clipper.dart';
import 'package:dip_taskplanner/components/MUsicPlayer.dart';
import 'package:dip_taskplanner/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:flutter/cupertino.dart';

/*void main() {
  runApp(new MaterialApp(
    title: 'Study',
    home: new FirstScreen(),
  ));
}*/

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STUDY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'STUDY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 */
class StudyPageEntry extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPageEntry> {

  String _path = null;

  Color buttonColor1 = LightColor.orange;
  Color buttonColor2 = LightColor.seeBlue;

 /* class FirstScreen extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
  return new Scaffold(
  appBar: new AppBar(
  title: new Text('StudyMode'),
  ),
  body: new Center(
  child: new RaisedButton(
  child: new Text('Launch new screen'),
  onPressed: () {
  Navigator.push(
  context,
  new MaterialPageRoute(builder: (context) => MusicPLayer()),
  );
  },
  ),
  ),
  );
  }
  }*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: buttonColor1,
                  color: buttonColor1,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                            "Music Player",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      new Expanded(
                        child: Container(),
                      ),
                      new Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(28.0)),
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                            onPressed: () => {},
                          ),
                        ),
                      )
                    ],
                  ),
                  //onPressed: () => {},
                    onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MusicPLayer()),)
                    },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: buttonColor2,
                  color: buttonColor2,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Study Mode (Silence)",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      new Expanded(
                        child: Container(),
                      ),
                      new Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(28.0)),
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                            onPressed: () =>  { },
                          ),
                        ),
                      )
                    ],
                  ),
                  //onPressed: () => {},
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => StudyMode()),);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
 }






