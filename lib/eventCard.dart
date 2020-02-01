import 'package:flutter/material.dart';
import 'results.dart';
// import 'resultsPage.dart';
import 'viewResults.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
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
  final Event event;
  final VoidCallback onTap;
  EventCard({Key key, @required this.event, this.onTap})
      : assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Card(
            elevation: 7.0,
            margin: new EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
            child:  
              
              new Container
              (
              //  height: double.infinity,
                //width: double.infinity,
                // child : new Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromRGBO(64, 75, 99, .6),
                        blurRadius: 20.0,
                      ),
                    ]),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: this.onTap,
                  splashColor: Color.fromRGBO(48, 56, 76, 1),
                  child: 
                  // new SizedBox.expand(
                    // child: 
                    EventCardContent(this.event, context),
                    
                ))
              // )
            )
          );
  }

  ListTile EventCardContent(event, context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        
       // padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: new Image(
            image: new AssetImage(event.image), height: 50, width: 60),
      ),
      title: Text(event.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle:
          
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
              Widget>[
        new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
        new Row(children: <Widget>[
          Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
          Align(
              alignment: Alignment.center,
              child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(IconData(0xe916, fontFamily: 'MaterialIcons'),
                        color: Colors.yellowAccent),
                    Text(event.time, style: TextStyle(color: Colors.white)),
                  ])),
        ]),
        new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
        new 
        // Expanded(child:
        Row(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
                onPressed: () =>
                    _contactPressed("tel:${event.contact.toString()}"),
                icon: new Icon(IconData(0xe0b0, fontFamily: 'MaterialIcons'),
                    color: Colors.yellowAccent),
                label: Text("")),
            OutlineButton.icon(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                
                icon: Icon(
                  Icons.assessment,
                  color: Colors.yellowAccent,
                ),
                label: Text(
                  'View Results',
                
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
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
                    final snackBar = SnackBar(content: Text(value,style : TextStyle(color: Colors.white)),backgroundColor: Colors.black,behavior: SnackBarBehavior.floating);
                    // Find the Scaffold in the Widget tree and use it to show a SnackBar
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                
              },
                // onPressed: () {
                //   Navigator.push(context,
                //       CupertinoPageRoute(builder: (context) {
                //     return new MaterialApp(
                //       title: event.title,
                //       home: new ResultsPage(title: event.title, id: event.id),
                //     );
                  
                
                ),
            
            
            ],
        )
      ]),
    );
  }

  void _contactPressed(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
