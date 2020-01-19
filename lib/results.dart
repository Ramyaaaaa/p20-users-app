import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  final Widget child;
  final String title, id;
  ResultsPage({this.title, this.id, Key key, this.child}) : super(key: key);

  @override
  _ResultsPageState createState() => new _ResultsPageState(this.title, this.id);
}

class _ResultsPageState extends State<ResultsPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<List<String>> names = new List<List<String>>();
  List<List<String>> filteredNames = new List<List<String>>();
  Icon _searchIcon = new Icon(Icons.search, color: Colors.yellowAccent);
  String title, id;
  Widget _appBarTitle;

  _ResultsPageState(this.title, this.id) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
    _appBarTitle = new Text(this.title, style: TextStyle(color: Colors.white));
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("BUILDSECONDPAGE");
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: _buildBar(context),
     body: _buildList(),
      //resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    print("INSIDE BUILDLIST");
    if (!(_searchText.isEmpty)) {
      print("BUILDING");
      List<List<String>> tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        for (int j = 0; j < filteredNames[i].length; j++) {
          if (filteredNames[i][j]
              .toLowerCase()
              .contains(_searchText.toLowerCase())) {
            tempList.add(filteredNames[i]);
            break;
          }
        }
      }
      filteredNames = tempList;
      for (int i = 0; i < filteredNames.length; i++) {
        for (int j = 0; j < filteredNames[i].length; j++) {
          print(filteredNames[i][j]);
        }
      }
    }

    l = filteredNames.length;

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: filteredNames == null ? 0 : filteredNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: makeListTile2(index),
            ),
          );
        },
      ),
    );
  }

  int l = 1;
  Widget makeListTile2(index) {
    print("INSIDE MAKE LIST $index");
    if (filteredNames[index].length == 0) {
      print("LEN IS 0");
    } else {
      List<Widget> team = List<Widget>();
      for (int i = 0; i < filteredNames[index].length; i++) {
        print(filteredNames[index][i]);
        print("==");
        // teamNames.add(filteredNames[index][i]);
        team.add(Align(
          alignment: Alignment.centerLeft,
          child: Text('${filteredNames[index][i]}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ));
        team.add(new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)));
      }
      print("_____");

      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Row(children: <Widget>[
          Column(children: team),
          Column(children: <Widget>[
            new Padding(
                padding:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0)),
            Align(
              alignment: Alignment.centerRight,
              child: Text('                  Marks',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            new Padding(
                padding:
                    new EdgeInsets.symmetric(horizontal: 13.0, vertical: 3.0)),
            Align(
              alignment: Alignment.centerRight,
              child: Text('                      Selected',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ]),
        ]),
      );
    }
  }

  void _searchPressed() {
    Icon _searchIcon1 = new Icon(Icons.search, color: Colors.yellowAccent);
    Icon _close = new Icon(Icons.close, color: Colors.yellowAccent);

    setState(() {
      if (this._searchIcon.icon == _searchIcon1.icon) {
        this._searchIcon = _close;
        this._appBarTitle = new TextField(
          controller: _filter,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              prefixIcon: _searchIcon1, hintText: 'Search...'),
        );
      } else {
        this._searchIcon = _searchIcon1;
        this._appBarTitle =
            new Text(this.title, style: TextStyle(color: Colors.white));
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void returnAlert(String promptText) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(promptText, textAlign: TextAlign.center),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        );
      },
    );
  }

  void _getNames() async {
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    // } on SocketException catch (_) {
    //   return returnAlert('Connect to Internet and try again!');
    // }
    // String url = 'http://34.73.200.44/getResult',
    //     body = '{"event": "${this.id}"}';
    // print('Sending request to server');
    // final response = await http.post(Uri.encodeFull(url),
  //       headers: {
  //         "Accept": "application/json",
  //         HttpHeaders.contentTypeHeader: 'application/json'
  //       },
  //       body: body);
  //   print('Request Body: ' + body);
  //   print('Response: ' + response.body.toString());
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print('Response: ' + response.body.toString());
  //     setState(() {
  //       Map<String, dynamic> tempResponse =
  //           Map<String, dynamic>.from(json.decode(response.body));
  //       List<List<String>> tempList = new List<List<String>>();
  //       for (int i = 1; i <= tempResponse.keys.length; i++) {
  //         tempList.add(['a','b','b','bd']);
  //       }
  //       names = tempList;
  //       filteredNames = names;
  //     });
  //   }
  //   print(names);
    print("_GETNAMESENd");
  }
}