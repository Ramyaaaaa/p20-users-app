import 'package:flutter/material.dart';
import 'viewResults.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class Event {
  final String title,
      tagline,
      time,
      duration,
      venue,
      description,
      contact,
      image,
      teamSize,
      qrcode,
      id;

  String balanceTime;
  final Color color;
  Event({
    this.title,
    this.tagline,
    this.time,
    this.duration,
    this.venue,
    this.description,
    this.contact,
    this.image,
    this.teamSize,
    this.id,
    this.qrcode,
    this.color,
  });
  String get remainingTime => balanceTime;

  set remainingTime(String remainingTime) {
    balanceTime = remainingTime;
  }
}

class EventCard extends StatelessWidget {
  final bool viewResults;
  final Event event;
  final VoidCallback onTap;
  EventCard({Key key, @required this.event, this.onTap, this.viewResults})
      : assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double height = this.viewResults ? 130.0 : 100.0;
    return SafeArea(
        top: true,
        bottom: true,
        child: SizedBox(
            child:
                new Card(
                    elevation: 7.0,
                    clipBehavior: Clip.antiAlias,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 8.0),
                    child: new Container(
                        child: AnimatedContainer(
                            height: height,
                            width: MediaQuery.of(context).size.width * 0.2,
                            duration: Duration(seconds: 2),
                            curve: Curves.easeIn,
                            child: Material(
                                color: Color.fromRGBO(64, 75, 99, .9),
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  onTap: this.onTap,
                                  onDoubleTap: () {
                                    _contactPressed("http://prayatna.org.in");
                                  },
                                  splashColor: Colors.white10,
                                  child: EventCardContent(this.event, context),
                                )
                              )
                            )
                          )
                        )
                      )
                    );
  }

  ListTile EventCardContent(event, context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          child: new Image(
            image: new AssetImage(event.image),
            height: 50,
            width: 60,
            fit: BoxFit.fill,
          ),
        ),
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(event.title,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 20,
                      fontWeight: FontWeight.bold)),
            ]),
        subtitle: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.symmetric(vertical: 5.0)),
                new Row(children: <Widget>[
                  Padding(padding: new EdgeInsets.symmetric(vertical: 5.0)),
                  Align(
                      alignment: Alignment.center,
                      child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(IconData(0xe916, fontFamily: 'MaterialIcons'),
                                color: Colors.yellowAccent,
                                size: MediaQuery.of(context).size.width / 20),
                            Text(event.time,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            27)),
                          ])),
                ]),
                Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                this.viewResults
                    ? new
                        Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          OutlineButton.icon(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),

                            icon: Icon(
                              Icons.assessment,
                              color: Colors.yellowAccent,
                              size: MediaQuery.of(context).size.width / 18,
                            ),
                            label: Text(
                              'View Results',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 26),
                            ),
                            textColor: Colors.white,
                            onPressed: () async {
                              String value = await Navigator.push(
                                context,
                                ResultsPageRoute(
                                  title: event.title,
                                  id: event.id,
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
                            },
                          ),
                        ],
                      )
                    : Text("")
              ]),
        ));
  }

  void _contactPressed(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: "Cannot open prayatna website !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    }
  }
}
