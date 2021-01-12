import 'dart:async';

import 'package:fishing_chimes/ui/new_stories_ui.dart';
import 'package:fishing_chimes/ui/top_stories_ui.dart';
import 'package:fishing_chimes/util/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


///This file holds the code to create a google navigation bar


// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  BuildContext context;
  int index;
  ScrollController controller;//Used to scroll back to the top of a listView
  PageController pageController;//used to change the state of the navigation bar while swiping between pages
  Stream<int> stream;

  NavBar({this.context, this.index, this.controller, this.pageController,this.stream});

  @override
  _NavBarState createState() => _NavBarState(
      controller: controller,
      index: index,
      context: context,
      pageController: this.pageController);
}

class _NavBarState extends State<NavBar> {
  _NavBarState(
      {this.context, this.index, this.controller, this.pageController});

  final BuildContext context;
  int index;
  final ScrollController controller;
  final PageController pageController;

  List pages = [TopStories(), NewStories()];
  Color redditOrange = HexColor("#FF5700	");
@override
  void initState() {
    widget.stream.listen((int index) {
      changeState(index);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GNav(
        gap: 8,
        activeColor: Colors.white,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.white,
        tabs: [
          GButton(
            icon: FontAwesomeIcons.fire,
            text: 'Top Stories',
            iconColor: redditOrange,
            iconActiveColor: redditOrange,
            textColor: Colors.black87,
          ),
          GButton(
            icon: FontAwesomeIcons.newspaper,
            text: 'New Stories',
            iconColor: redditOrange,
            iconActiveColor: redditOrange,
            textColor: Colors.black87,
          ),
        ],
        selectedIndex: index,
        onTabChange: (int i) {
          if (i != index)
            setState(() {
              index = i;
             pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
            });
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
          // {
          //   return pages[i];
          // }));
          else
            scrollTop(controller);
        });
  }
  changeState(int i)
  {
    setState(() {
      index=i;
    });
  }

  void scrollTop(ScrollController controller)
  {
    controller.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}






