import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'eventCard.dart';
import 'questionPaperPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPageRoute extends MaterialPageRoute {
  DetailsPageRoute(Event event, {bool showResults = false})
      : super(
          builder: (context) => new DetailsPage(
            event: event,
            showResults: showResults,
          ),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class DetailsPage extends StatelessWidget {
  final Event event;
  final bool showResults;

  DetailsPage({this.event, this.showResults});
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool(event.id);
    return boolValue ?? false;
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(event.id, true);
  }

  Future<int> getAttended() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getInt(event.id.toString() + "chances") ?? 3;
  }

  void _contactPressed(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {

      if(!url.contains('tel'))  {
      Fluttertoast.showToast(
          msg: "Cannot open prayatna website !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.title.copyWith(
        color: Colors.white, fontSize: MediaQuery.of(context).size.width / 20);
    final TextStyle subheadStyle = theme.textTheme.subhead.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width / 22);
    final TextStyle descriptionStyle = theme.textTheme.body1.copyWith(
      color: Colors.white,
      fontSize: MediaQuery.of(context).size.width / 24,
    );
    final EdgeInsetsGeometry textPadding = const EdgeInsets.only(bottom: 3.0);

    List<Widget> getChildren(context) {
      final List<Widget> children = <Widget>[
        Padding(
          padding: textPadding,
          child: Text(
            this.event.title,
            style: titleStyle,
          ),
        ),
        Padding(
          padding: textPadding,
          child: Text(
            this.event.tagline,
            style: descriptionStyle,
          ),
        ),
        Divider(),
        Padding(
          padding: textPadding,
          child: Text(
            'Date & Time',
            style: subheadStyle,
          ),
        ),
        Padding(
          padding: textPadding,
          child: Text(
            this.event.time,
            style: descriptionStyle,
          ),
        ),
        Divider(),
        Padding(
          padding: textPadding,
          child: Text(
            'Venue',
            style: subheadStyle,
          ),
        ),
        Padding(
          padding: textPadding,
          child: Text(
            this.event.venue,
            style: descriptionStyle,
          ),
        ),
        Divider(),
        Padding(
          padding: textPadding,
          child: Text(
            'Team Size',
            style: subheadStyle,
          ),
        ),
        Padding(
          padding: textPadding,
          child: Text(
            this.event.teamSize,
            style: descriptionStyle,
          ),
        ),
        Divider(),
        //  Row(children: <Widget>[
        FlatButton.icon(
            onPressed: () => _contactPressed("tel:${event.contact.toString()}"),
            icon: new Icon(IconData(0xe0b0, fontFamily: 'MaterialIcons'),
                color: Colors.yellowAccent, size: 20),
            label: Text(
              "Contact ",
              style: subheadStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.normal,
                  fontSize: MediaQuery.of(context).size.width/23),
            )),
        Divider(),
      ];

      if (this.showResults) {
        children.add(
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                  child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width/2,
                
                child: OutlineButton.icon(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  icon: Icon(
                    Icons.border_color,
                    color: Colors.yellowAccent,
                    size : MediaQuery.of(context).size.width/20,
                  ),
                  label: Text(
                    'Participate',
                    style: subheadStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal
                        ,fontSize: MediaQuery.of(context).size.width/23),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int attempts =
                        await prefs.getInt(event.id.toString() + "chances") ??
                            3;
                    //  int attempts = 6;
                    int startTime =
                        await prefs.getInt(event.id.toString() + "time") ??
                            int.parse(event.duration);
                    event.remainingTime = startTime.toString();
                    print("Remaining time :" + event.remainingTime);
                    print("Attempts:" + attempts.toString());

                    if (attempts != 0) {
                      String value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionPaperPage(event: event),
                        ),
                      );
                      if (value != null) {

                        final snackBar = SnackBar(
                            content: Text(value,
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating);

                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                            content: Text(
                              "Already participated!",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                            actions: <Widget>[
                              new OutlineButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: new Text(
                                    'Ok',
                                    style: new TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ))),
        );
      }

      else {
        children.add(
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                  child: ButtonTheme(
                minWidth: 185.0,
                height: 45.0,
                child: OutlineButton.icon(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  icon: Icon(
                    IconData(58936, fontFamily: 'MaterialIcons'),
                    color: Colors.yellowAccent,
                  ),
                  label: Text(
                    'Buy Pass',
                    style: subheadStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  onPressed: () async {
                    _contactPressed('https://www.prayatna.org.in/workshop/workshop_${this.event.id}.html');
                  }
                )))
          )
        );
            
      }

      return children;
    }

    return new Scaffold(
        backgroundColor: Color.fromRGBO(64, 75, 99, .9),
        appBar: AppBar(
            elevation: 7,
            backgroundColor: Color.fromRGBO(58, 66, 86, 0.3),
            title: Text(
              this.event.title,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
            ),

            
            actions: this.showResults? <Widget>[
          IconButton(
            icon: Icon(Icons.border_color,color: Colors.yellowAccent,
                    size : MediaQuery.of(context).size.width/15),
            onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    // bool hasAttended = await prefs.getBool('${event.id}') ?? false;
                    int attempts =
                        await prefs.getInt(event.id.toString() + "chances") ??
                            3;
                    ;
                    //  int attempts = 6;
                    int startTime =
                        await prefs.getInt(event.id.toString() + "time") ??
                            int.parse(event.duration);
                    event.remainingTime = startTime.toString();
                    print("Remaining time" + event.remainingTime);
                    print("Attempts:" + attempts.toString());

                    if (attempts != 0) {
                      String value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionPaperPage(event: event),
                        ),
                      );
                      if (value != null) {
                        
                        Fluttertoast.showToast(
                          msg: value,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1);
                      }
 
                      //   final snackBar = SnackBar(
                      //       content: Text(value,
                      //           style: TextStyle(color: Colors.white)),
                      //       backgroundColor: Colors.black,
                      //       behavior: SnackBarBehavior.floating);

                      //  Scaffold.of(context).showSnackBar(snackBar);
                      // }
                    } else {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                            content: Text(
                              "Already participated!",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                            actions: <Widget>[
                              new OutlineButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: new Text(
                                    'Ok',
                                    style: new TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          );
                        },
                      );
                    }
                  },
          )]: null
            ) ,
            
        body: Builder(
            builder: (context) => Center(
                    child: SizedBox.expand(
                        // height: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Photo and title.
                    SizedBox(
                      height: MediaQuery.of(context).size.height/5,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Ink.image(
                              image: AssetImage(this.event.image),
                              fit: BoxFit.cover,
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: DefaultTextStyle(
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: descriptionStyle,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getChildren(context),
                        ),
                      ),
                    ),
                  ],
                )
              )
            )
          )
        );
  }
}
