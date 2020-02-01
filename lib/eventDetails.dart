import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'eventCard.dart';
import 'questionPaperPage.dart';
class DetailsPageRoute extends MaterialPageRoute {
  DetailsPageRoute(Event event,
      {bool showResults = false})
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
  // final int initPosition;
  // final List<Event> events;
  final Event event;
  final bool showResults;

  DetailsPage({this.event,this.showResults});


getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool boolValue = prefs.getBool(event.id);
  return boolValue ?? false;
}
addBoolToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(event.id, true);
}

  @override
  Widget build(BuildContext context) {

    
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.title.copyWith(color: Colors.white);
    final TextStyle subheadStyle = theme.textTheme.subhead
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    final TextStyle descriptionStyle =
        theme.textTheme.body1.copyWith(color: Colors.white);
        final EdgeInsetsGeometry textPadding = const EdgeInsets.only(bottom: 3.0);
    
   List<Widget> getChildren(context)  {

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
    ];
    
    if (this.showResults) {
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
                  Icons.border_color,
                  color: Colors.yellowAccent,
                ),
                label: Text(
                  'Participate',
                  style: subheadStyle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
                onPressed: () async 
                {
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                    // bool hasAttended = await prefs.getBool('${event.id}') ?? false;
                    // if(!hasAttended) {
                   int attempts = 6;
                       int startTime = await prefs.getInt(event.id.toString()+"time") ?? int.parse(event.duration);
                       event.remainingTime = startTime.toString();
                       print("In Details" + event.remainingTime);
                       print("In Details attempts:" + attempts.toString());
                     
                    if(attempts != 0) {

                      String value = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionPaperPage(event: event),
          ),          
                   );
                   if (value != null) {
                    final snackBar = SnackBar(content: Text(value,style : TextStyle(color: Colors.white)),backgroundColor: Colors.black,behavior: SnackBarBehavior.floating);
                    // Find the Scaffold in the Widget tree and use it to show a SnackBar
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                  
                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                      //  new QuestionPaperPage(event: event)));
                      // Navigator.pushNamed(context, '/questionPaper');
                    }
                    else {
                      return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog (
                  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                
                  content: Text("Already participated!", textAlign: TextAlign.center,style: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              
                              ),),
                  actions: <Widget>[
                    new OutlineButton(
                      onPressed: () => Navigator.pop(context), child: new Text('Ok',style: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              ),))],
                );
              },
      );
                    }
                },
                        // techEvents[index],
                        // showResults: true,
                      ),
                    ))));
                    }
                    else {
                     // alert();
                    }
              
            
return children; 
    }
    
    return 
    new Scaffold(

        
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

        appBar: AppBar(
          elevation: 7,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            this.event.title,
          )),
          body:
          Builder(builder : (context) => Center(
      
          child:
          SizedBox.expand(
            
          // height: MediaQuery.of(context).size.width * 0.65,
            child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Photo and title.
        SizedBox(

          height: MediaQuery.of(context).size.width * 0.55,
          
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                // must use Ink.image. This allows the image to be painted as part
                // of the Material and display ink effects above it. Using a
                // standard Image will obscure the ink splash.
                child: Ink.image(
                  image: AssetImage(this.event.image),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
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
    ))));
    
  }

  
}
