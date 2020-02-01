import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'globals.dart' as g;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:fluttertoast/fluttertoast.dart';
import 'eventCard.dart';

Event event;
class QuestionPaperPage extends StatefulWidget {
  final Event event;
  QuestionPaperPage({Key key, @required this.event}) : super(key: key);

  @override
  _QuestionPaperPageState createState() => _QuestionPaperPageState();
}
Future<bool> setAttendedMinus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  int value = await prefs.getInt(event.id.toString()+"chances") ?? 6;
     return prefs.setInt(event.id.toString()+"chances", value-1);
  }
Future<bool> setAttended(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     return prefs.setInt(event.id.toString()+"chances", value);
  }
bool displayQuestionPaper;
bool checksecurity;
class _QuestionPaperPageState extends State<QuestionPaperPage> {
 
  bool _isLoading;
  String scanCode;
  PDFDocument document;


  @override
  void initState() {
    
    super.initState();
    event = widget.event;
    displayQuestionPaper = false;
        checksecurity =  true;
    _isLoading = false;
  }

  loadFromAssets() async {
    setState(() {
      _isLoading = true;
    });
    try {
      document = await PDFDocument.fromAsset('assets/${event.id}.pdf');
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void scanQR() async {
    try {
      scanCode = await scanner.scan();
    } catch (e) {
      print(e);
    }
    print(scanCode);
    if (scanCode == widget.event.qrcode.toString()) {
      print("Question paper");
      setState(() {
        displayQuestionPaper = true;
      });
      loadFromAssets();
    } else {
      print("Code didn't match");
       print(widget.event.id.toString());
     
      Fluttertoast.showToast(
          msg: "QR Code did not match", toastLength: Toast.LENGTH_LONG);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () {
        Future.value(false);
      },
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            if (displayQuestionPaper == false)
              Navigator.pop(context);
            else {
              Fluttertoast.showToast(
                  msg: "Test in progress",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white);
            }
          },
        ),
        elevation: 7,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          '${widget.event.title}',
        ),
        actions: <Widget>[displayQuestionPaper ? TIMER() : Text("")],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            displayQuestionPaper
                ? Expanded(
                    child: Center(
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PDFViewer(
                              document: document,
                            ),
                    ),
                  )
                : new Padding(padding: new EdgeInsets.all(25.0)),
            !displayQuestionPaper
                ? new MaterialButton(
                    minWidth: 100.0,
                    height: 25.0,
                    padding: const EdgeInsets.all(25.0),
                    textColor: Colors.white,
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                    splashColor: Colors.black38,
                    onPressed: () => scanQR(),
                    child: new Text(
                      "Scan Volunteer's QR to view ",
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                : new MaterialButton(
                    minWidth: double.infinity,
                    height: 25.0,
                    padding: const EdgeInsets.all(25.0),
                    textColor: Colors.white,
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                    splashColor: Colors.black38,
                    onPressed: () => {
                      setAttended(0),
                      Navigator.pop(context,'Test has ended!'),
                    },
                    child: new Text(
                      "End Test ",
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ))
          ],
        ),
      ),
    ));
  }
}

// class _MainState extends State<Main> {
//   loadFromAssets() async {
//     setState(() {
//       _isInit = false;
//       _isLoading = true;
//     });
//     document = await PDFDocument.fromAsset('assets/amz.pdf');
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
// leading: IconButton(
//   icon: Icon(Icons.arrow_back),
//   color: Colors.white,
//   onPressed: () {
//     // if (initiateTime == 0)
//       // Navigator.pushNamed(context, '/login');
//     // else {
//       Fluttertoast.showToast(
//           msg: "Test in progress",
//           toastLength: Toast.LENGTH_SHORT,
//           backgroundColor: Colors.grey,
//           textColor: Colors.white);
//     // }
//   },
// ),
//         title: Text(g.events[g.eventIndex]),
//         actions: <Widget>[
//           _isInit == true
//               ? IconButton(
//                   icon: Icon(Icons.settings_overscan),
//                   onPressed: () {
//                     scanQR();
//                   },
//                 )
//               : TIMER(),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: _isInit
//                   ? Text("Press button to load")
//                   : _isLoading
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : PDFViewer(
//                           document: document,
//                         ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//  Future<bool> setAttended(bool value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.setBool(event.id, value);
//   }

  Future<int> getAttended() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return  await prefs.getInt(event.id.toString()+"chances") ?? 6;
  }
 Future<bool> setStoppedTime(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(event.id.toString()+"time", value);
  }

class TIMER extends StatefulWidget {
  @override
  // final Event event;
  // TIMER({this.event});
  // TIMER({Key key, this.event}) : super(key: key);

  _TIMERState createState() => _TIMERState();
}
 

int temp = 0;

class _TIMERState extends State<TIMER> with WidgetsBindingObserver{
  Timer _timer;
  int _start;
  int minutes;
  int seconds;
  Timer timer;

  bool lessThanTenSec = false;
  bool lessThanTenMin = false;

  int initiateTime = 0;
bool isMoved;
  String scanCode;
  bool _isLoading, _isInit;
 Future<int> getStoppedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _start = prefs.getInt(event.id.toString()+"time");
    minutes = (_start ~/ 60);
    seconds = (_start % 60);
  
    return _start;
  }

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addObserver(this);
   
    _isInit = true;
    isMoved = false;
    getStoppedTime();
    // _start = int.parse(event.duration);
      initiateTime = 0;
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        print('paused state');
        setAttendedMinus();
       // isMoved = true;
        Fluttertoast.showToast(
            msg: "Go to full screen mode",
            toastLength: Toast.LENGTH_LONG); 
        break;
      case AppLifecycleState.resumed:
        print('resumed state');
         isMoved = true;
        break;
      case AppLifecycleState.inactive:
        print('inactive state');
      //  isMoved = true;
        Fluttertoast.showToast(
            msg: "Go to full screen mode",
            toastLength: Toast.LENGTH_LONG);
		    
         
        break;
      
      case AppLifecycleState.detached:
        print('detached state');
        // TODO: Handle this case.
        break;
    }
  }

  

  void startTimer() async {
    const oneSec =
        const Duration(seconds: 1); // Change to minutes to decrease by minutes
    _timer = new Timer.periodic(
      oneSec,
      (timer) => setState(
        () {
          if(isMoved)
          {
            timer.cancel();
            setStoppedTime(minutes * 60 + seconds);
            Navigator.pop(context,"Trying to switch tabs leads to disqualification!");
          }
          
          if (seconds < 1 && minutes == 0) {
            _isLoading = false;
            _isInit = true;
            lessThanTenSec = false;
            lessThanTenMin = false;
            setAttended(0);
            timer.cancel();
            Navigator.pop(context);
            //  = true;
            // Navigator.pushNamed(context, '/login');
            
          } else {
            if (seconds == 0 && minutes != 0) {
              minutes = minutes - 1;
              seconds = 60;
              lessThanTenSec = false;
            }
            if (seconds <= 10) {
              lessThanTenSec = true;
            }
            if (minutes < 10) {
              lessThanTenMin = true;
            }
            seconds = seconds - 1;
            // if (seconds % 10 == 0) {
            //   {
            //     check();
            //     if (g.offed == false) {
            //       timer.cancel();
            //       setStoppedTime(minutes * 60 + seconds);
            //     }
            //   }
            // }
          }
        },
      ),
    );
  }

  // check() async {
  //   var result = await (Connectivity().checkConnectivity());
  //   if (result == ConnectivityResult.mobile) {
  //     if (g.chances >= 0)
  //       Fluttertoast.showToast(
  //           msg: "Turn off mobile data \n" +
  //               "Warning! You are " +
  //               g.chances.toString() +
  //               " step away from disqualification",
  //           toastLength: Toast.LENGTH_LONG);
  //     else {
  //       seconds = 0;
  //       minutes = 0;
  //       setAttended(true);
  //       Navigator.pop(context);
  //       displayQuestionPaper = false;
  //       setStoppedTime(minutes * 60 + seconds);
  //      // g.eventTime[g.eventIndex] = minutes * 60 + seconds;
  //     }
  //     g.offed = false;
  //     temp = 0;
  //     g.chances = g.chances - 1;
  //     // Navigator.pushNamed(context, '/login');
  //   } else if (result == ConnectivityResult.wifi) {
  //     if (g.chances >= 0)
  //       Fluttertoast.showToast(
  //           msg: "Turn off wifi \n" +
  //               "WARNING! You are " +
  //               g.chances.toString() +
  //               " step away from disqualification",
  //           toastLength: Toast.LENGTH_LONG);
  //     else {
  //       seconds = 0;
  //       minutes = 0;
  //       setState((){
  //       displayQuestionPaper = false;
  //       });
  //       setAttended(true);
        
  //       Navigator.pop(context);
  //       setStoppedTime(minutes*60 + seconds);
  //     //  g.eventTime[g.eventIndex] = minutes * 60 + seconds;
  //     }
  //     g.offed = false;
  //     temp = 0;
  //     g.chances = g.chances - 1;
  //     // Navigator.pushNamed(context, '/login');
  //   } else {
  //     g.offed = true;
  //     if (temp == 0) {
  //       startTimer();
  //       temp = 1;
  //     }
  //     print("HELLO" + g.offed.toString());
  //   }
  // }

  @override
  void dispose() {
    _timer.cancel();
  WidgetsBinding.instance.removeObserver(this);
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initiateTime == 0) {
      startTimer();
      initiateTime = 1;
    }
    if (!lessThanTenMin && !lessThanTenSec) {
      return Text(
        minutes.toString() + ":" + seconds.toString(),
        style: TextStyle(
          fontSize: 40.0,
          color: (seconds > 10 || minutes > 0) ? Colors.white : Colors.red,
        ),
      );
    }
    if (lessThanTenSec && !lessThanTenMin) {
      return Text(
        minutes.toString() + ":0" + seconds.toString(),
        style: TextStyle(
          fontSize: 40.0,
          color: (seconds > 10 || minutes > 0) ? Colors.white : Colors.red,
        ),
      );
    }
    if (!lessThanTenSec && lessThanTenMin) {
      return Text(
        "0" + minutes.toString() + ":" + seconds.toString(),
        style: TextStyle(
          fontSize: 40.0,
          color: (seconds > 10 || minutes > 0) ? Colors.white : Colors.red,
        ),
      );
    }
    if (lessThanTenMin && lessThanTenSec) {
      return Text(
        "0" + minutes.toString() + ":0" + seconds.toString(),
        style: TextStyle(
          fontSize: 40.0,
          color: (seconds > 10 || minutes > 0) ? Colors.white : Colors.red,
        ),
      );
    }
  }
}
