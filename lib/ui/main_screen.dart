import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_chimes/ui/history_page.dart';
import 'package:fishing_chimes/ui/navigation_bar.dart';
import 'package:fishing_chimes/ui/new_stories_ui.dart';
import 'package:fishing_chimes/ui/story_tile.dart';
import 'package:fishing_chimes/ui/top_stories_ui.dart';
import 'package:fishing_chimes/util/data_service.dart';
import 'package:fishing_chimes/util/hexcolor.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


PageController pageController = PageController(initialPage: 0);// to swipe between pages:NewStories and Top Stories

StreamController<int> navigationStream=StreamController<int>();//to change the GoogleNavigationBar state while swiping between pages



// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
final Stream<int> stream;
var userData;
String user;
   MainScreen({ this.stream,this.user,this.userData});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navigationIndex=0;
  ScrollController _controller = ScrollController();//used later by GoogleNavigation bar to scrollback to the top of a stories ui




  Stream<DocumentSnapshot> userStream;

@override
  void initState() {
userStream=widget.userData;
super.initState();
}
resetState()//used when there is a userData extraction delay
{
  setState(() {
    userStream=FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
  });
}


  @override
  Widget build(BuildContext context) {


    return Scaffold(appBar: AppBar(
      actions: [IconButton(icon: Icon(FontAwesomeIcons.history), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HistoryPage();
        }));
      })
      ],
      title: Text("Hacker News ",),
      centerTitle: true,
     ),
      body: Column(
        children: [
          NavBar(context: context,
            controller: _controller,
            index: navigationIndex,
            pageController: pageController,stream: navigationStream.stream,),
          Flexible(
            child: PageView(controller: pageController,
              scrollDirection: Axis.horizontal,
              children: [TopStories(scrollController: _controller,).topStoriesUi(), NewStories(scrollController: _controller).newStoriesUi()],onPageChanged:
              (i)
              {
                int value=i;
                setState(() {
                  navigationStream.add(value);
                  print("$navigationIndex is the nav index");
                });
              },),
          ),
        ],
      ),
    floatingActionButton:/*
    displays the count of the articles clicked by the user
    changes everytime the user clicks on an article*/
    StreamBuilder<DocumentSnapshot>(
      stream: userStream,
      builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(snapshot.hasData &&snapshot.data.data()!=null) {

          Map<String, dynamic> documentFields=snapshot.data.data();
          userHistoryList=documentFields['id'];/*setting the userHistoryList here with the id array in the firestore database
          The id array in firestore database stores the article ids which the user visited
          */
          return FloatingActionButton(child: Text(documentFields['id'].length.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),onPressed:
              (){
            Navigator.push(context, MaterialPageRoute(builder: (context)
            {
              return HistoryPage();
            }));
          }
            ,backgroundColor: HexColor("#FF5700	"),elevation: 10,splashColor: HexColor("#FF5700	").withOpacity(0.1),tooltip: "${documentFields['id'].length} pages viewed",);
        }
        else
          if(snapshot.hasData &&snapshot.data.data()!=null)
          return FloatingActionButton(child:Icon(Icons.refresh),backgroundColor: HexColor("#FF5700	"),elevation: 10,splashColor: HexColor("#FF5700	").withOpacity(0.1),onPressed: ()=>resetState());
      else
        {
          userStream=FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
          return
          FloatingActionButton(backgroundColor: HexColor("#FF5700	"),child:Icon(Icons.refresh),onPressed:  (){
          resetState();
        });
      }}
    ),);
  }


}
