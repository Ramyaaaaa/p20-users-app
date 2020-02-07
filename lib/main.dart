import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'eventCard.dart';
import 'eventDetails.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

 BuildContext context;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Prayatna',
      home: HomePage(title: "Prayatna '20"),
    );
  }
}

class HomePage extends StatelessWidget {

  HomePage({Key key, this.title}) : super(key: key);

 
  final String title;

  final techEvents = <Event>[
    Event(
      title: 'C Noobies',
      id: 'cnob',
      tagline: 'Dive into the magic of C',
      time: 'Feb 9, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '9444948968',
      image: 'assets/images/cnob.jpg',
      teamSize: 'Max. 2 members, only for First Years',
      qrcode: 'R9UswyX6>9)nN}R\$',
     ),
     Event(
      title: 'Hexathlon',
      id: 'hex',
      tagline: 'The Mega Event',
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '9698654157',
      image: 'assets/images/hex.jpg',
      teamSize: 'Exactly 2 per team',
      qrcode: '[k,me6g3MGbUM-As',
    ),
    Event(
      title: 'OSPC',
      id: 'ospc',
      tagline: "The Problem solver's Paradise",
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '9600867345',
      image: 'assets/images/ospc.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: "@#'6<&sW5UFT)~pW",
    ),
    Event(
      title: "DB Dwellers",
      id: 'dbd',
      tagline: 'Select * from the universe',
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '8608217957',
      image: 'assets/images/dbd.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: '>ny]djSv\$yt#2C&]',
    ),
    Event(
      title: "Python",
      id: 'python',
      tagline: 'Express your fluency in Python',
      time: 'Feb 9, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '9655066244',
      image: 'assets/images/python.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: "7Ws5k2B]'C-r^6=y",
    ),
    Event(
      title: 'Web Hub',
      id: 'web',
      tagline: "What you see is what you get",
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '9500960760',
      image: 'assets/images/web.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: '6kv%4CUdT,PEwE&Z',
    ),
   
    Event(
      title: "Coffee with Java",
      id: 'java',
      tagline: 'Are you a jaw-dropping Java developer?',
      time: 'Feb 9, 9am - 12:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '8939021336',
      image: 'assets/images/java.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: 'ww9@#mCdWc`n[=-H',
    ),
    
    Event(
      title: "Think-a-thon",
      id: 'think',
      tagline: 'A battle of wits!',
      time: 'Feb 9, 9am - 10:30pm (Prelims)',
      duration: '2700',
      venue: 'LHC',
      contact: '8675955857',
      image: 'assets/images/think.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: 'S6Kp[F+/Dh~\$vRj>',
    ),
  ];

  final nonTechEvents = <Event>[
    Event(
      title: 'Prestige',
      duration: '2100',
      id: 'pres',
      tagline: 'The Mega Event',
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      venue: 'LHC',
      contact: '8825772487',
      image: 'assets/images/pres.jpg',
      teamSize: 'Max. 3 per team',
      qrcode: "x%s4yB4'L-[.^`j",
    ),
    Event(
      title: 'IPL Auction',
      tagline: 'Bid, Win, Have a Grin',
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      venue: 'LHC',
      id : 'ipl',
      duration: '1800',
      contact: '9629847329',
      image: 'assets/images/ipl.jpg',
      teamSize: 'Max. 2 per team',
      qrcode: '7[(UC66+VL5tEt7[',
    ),
    Event(
      title: "Sherlock Holmes",
      duration: '2100',
      tagline: 'Life is short, Game more',
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      venue: 'LHC',
      id : 'sheh',
      contact: '9629847329',
      image: 'assets/images/sheh.jpg',
      teamSize: 'Max. of 3 members',
      qrcode: "JE8A'bd7)Yx-}a>;",
    ),
    Event(
      title: "Connexions",
      id : 'conn',
      duration: '2700',
      tagline: 'Crack it quicker and collar up as connectors',
      time: 'Feb 9, 9am - 12:30pm (Prelims)',
      venue: 'LHC',
      contact: '8015888316',
      image: 'assets/images/conn.jpg',
      teamSize: 'Exactly 2 per team',
      qrcode: '%4U<=J<#GrK2Zr7~',
    ),
    Event(
      title: "Treasure Hunt",
      tagline: 'Clear Vision holds the key',
      time: 'Feb 8, 9am - 12:30pm (Prelims)',
      venue: 'LHC',
      duration: '2400',
      id : 'thunt',
      contact: '9489079110',
      image: 'assets/images/thunt.jpg',
      teamSize: 'Max. 3 per team',
      qrcode: 'eB<\<&JSD,%p3`3J',
    ),
    Event(
      title: 'Math O Mania',
      id : 'math',
      tagline: 'Do you speak the language of the Gods?',
      time: 'Feb 9, 9am - 12:30pm (Prelims)',
      venue: 'LHC',
      contact: '7092694272',
      duration: '2100',
      image: 'assets/images/math.jpg',
      teamSize: 'Max. 2 per team',
       qrcode: 'c2e/`fMF45*e(*p\$',
    ),
     
    Event(
      title: "GQuiz",
      id: 'gquiz',
      tagline: 'Do you read news ?',
      time: 'Feb 8, 9am - 10:30pm (Prelims)',
      duration: '1200',
      venue: 'LHC',
      contact: '8825772487',
      image: 'assets/images/gquiz.jpg',
      teamSize: 'Exactly 2 per team',
      qrcode: '/(92#GD(;\$g&v<NP',
    ),
  ];
  final workshops = <Event>[
    Event(
      title: 'Amazon Web Services',
      id : 'aws',
      tagline: 'Learn to deploy applications in a scalable way',
      time: 'Feb 8, 9am - 4pm',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_aws.jpg',
      teamSize: 'Individual participation',
    ),
    Event(
      title: 'Digging into Data',
      tagline: 'Master the Future',
      time: 'Feb 8, 9am - 4pm',
      id: 'data',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_data.jpg',
      teamSize: 'Individual participation',
    ),
    Event(
      title: "Artificial Intelligence",
      id:'aiml',
      tagline: 'You choose how to use the AI tool',
      time: 'Feb 8, 9am - 4pm',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_aiml.jpg',
      teamSize: 'Individual Participation',
    ),
    Event(
      title: "Web Development",
      tagline: 'Bring out the creative side in you',
      time: 'Feb 8, 9am - 4pm',
      id : 'web',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_web.jpg',
      teamSize: 'Individual participation',
    ),
    Event(
      title: 'Ethical Hacking',
      tagline: "Be a WHITE HAT HACKER in no time",
      time: 'Feb 9, 9am - 4pm',
      id : 'hack',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_hack.jpg',
      teamSize: 'Individual participation',
    ),
    Event(
      title: "App Development",
      tagline: 'Design apps like Instagram, your style, your way',
      time: 'Feb 8, 9am - 4pm',
      id : 'app',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_app.jpg',
      teamSize: 'Individual participation',
    ),
    Event(
      title: 'Deep Learning',
      tagline: 'Break into AI via Deep Learning',
      time: 'Feb 9, 9am - 4pm',
      id:'deep',
      venue: 'LHC',
      contact: '‎9080667260',
      image: 'assets/images/w_deep.jpg',
      teamSize: 'Individual participation',
    ),
  ];

  final String techEventsTitle = 'Tech Events',
      nonTechEventsTitle = 'Non Tech ',
      workshopTitle = 'Workshops';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 7,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            this.title,
          ),
          bottom: TabBar(
            indicatorColor: Colors.white10,
            indicatorWeight: 4,
            tabs: [
              new Tab(
                child: 
                Text(
                  techEventsTitle,
                  softWrap: true,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/24)
                )
              ),
              new Tab(
                child: 
                Text(
                  nonTechEventsTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/24)
                )
              ),
              new Tab(
                child: 
                Text(
                  workshopTitle,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/24)
                )
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return EventCard(
                  event: techEvents[index],
                  viewResults: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      DetailsPageRoute(
                        techEvents[index],
                        showResults: true,
                      ),
                    );
                  },
                );
              },
              itemCount: techEvents.length,
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return EventCard(
                  event: nonTechEvents[index],
                  viewResults: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      DetailsPageRoute(
                        nonTechEvents[index],
                        showResults: true
                      ),
                    );
                  },
                );
              },
              itemCount: nonTechEvents.length,
            ),
          
          ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return EventCard(
                  event: workshops[index],
                  viewResults: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      DetailsPageRoute(
                        workshops[index],
                      ),
                    );
                  },
                );
              },
              itemCount: workshops.length,
            ),
           ],
        ),
      ),
    );
  }
}
