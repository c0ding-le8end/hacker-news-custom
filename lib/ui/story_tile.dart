import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_chimes/util/data_service.dart';
import 'package:fishing_chimes/util/hexcolor.dart';
import 'package:fishing_chimes/util/share.dart';
import 'package:fishing_chimes/util/webpage_opener.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
List userHistoryList = List();


///this file has the code of the ui of a story tile

Widget storyTile(
    BuildContext context, AsyncSnapshot snapshot, String storyType) {
  var userData = FirebaseFirestore.instance.collection("users").doc(userId);

  var articleData = snapshot.data;


  String altUrl = "https://news.ycombinator.com/item?id=${articleData.id}";

  var time = DateTime.fromMillisecondsSinceEpoch(articleData.time * 1000);

  var timeDifference = DateTime.now().difference(time).inMinutes;
  String timeDuration = timeDifference > 60
      ? DateTime.now().difference(time).inHours.toString() + "h ago"
      : timeDifference.toString() + "mins ago";

  if(articleData.deleted)
    return Divider();//returned when the article is deleted
  return InkWell(
    child: Container(
      height: 330,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 15.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "HackerNews/$storyType ",
              style: TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.w600),
            ),
            Text("Written By ${articleData.by}   $timeDuration  ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,

                )),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.blueGrey.shade900,
            ),
            Expanded(
              child: Text(
                articleData.title,
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                color: Colors.black87),
              ),
            ),
            Divider(
              color: Colors.blueGrey.shade900,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    FontAwesomeIcons.share,
                    color: HexColor("#FF5700	"),
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Share",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ]),
                onTap: () {
                  shareArticle(
                      url: articleData.url, altUrl: altUrl, context: context);
                },
              ),
            )
          ],
        ),
      ),
    ),
    onTap: () {
      openUrl(articleData.url, articleData.id);//a webpage is opened
      print(articleData.url);
      userHistoryList.add(articleData.id);//the id of the article is added to the local userHistoryList
      userData.set({'time':userLoginTime,'id':userHistoryList});//the id of the article is added to the firestore id array
    },
  );
}

