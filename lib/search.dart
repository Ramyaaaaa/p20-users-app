import 'package:flutter/material.dart';
import 'team.dart';
import 'viewResults.dart';

class DataSearch extends SearchDelegate<String> {
  List<int> resultsList = new List<int>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {

  final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.dark,
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
        body1: TextStyle(fontWeight: FontWeight.normal,color: Colors.black)
      ),
    );
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

    return
    ListView.separated(
      itemCount: resultsList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (resultsList.length >= 1) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ResultsContent(
                team: Team(
                  teamID: 'Team ID',
                  members: <String>['Team Members'],
                  marks: 'Score',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }
          return new ResultsContent(team: teamDetails[resultsList[index - 1]]);
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

     
    resultsList = [];
    if (query.isNotEmpty) {
      for (var index = 0; index < teamDetails.length; index++) {
        List<dynamic> memberList = teamDetails[index].memberList();
        // print(memberList);
        memberList.forEach((member) {
          
          if (member['name'].toLowerCase().startsWith(query.toLowerCase()) && member['name'] != null) {
            if(!resultsList.contains(index))
              resultsList.add(index);
          }
        });
      }
      resultsList.toSet().toList();

      return Container(
        color: Color.fromRGBO(58, 66, 86, 1.0),
      child : ListView.separated(
        itemCount: resultsList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (resultsList.length >= 1) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ResultsContent(
                  team: Team(
                    teamID: 'Team ID',
                    members: <String>['Team Members'],
                    marks: 'Score',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              );
            }
            return new ResultsContent(
                team: teamDetails[resultsList[index - 1]]);
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          if(index == 0)
                return Divider(color: Colors.white,thickness: 0.5);
                else 
                return Divider(color: Colors.white);
                
        },
      ));
    } else {
      return Text("");
    }
  }
}