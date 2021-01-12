
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_chimes/networking/stories/stories.dart';
import 'package:fishing_chimes/networking/stories/story_object.dart';
import 'package:fishing_chimes/ui/story_tile.dart';
import 'package:fishing_chimes/util/data_service.dart';
import 'package:fishing_chimes/util/url_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var tappedArticleIds =
      FirebaseFirestore.instance.collection("history").orderBy("time",descending: true).snapshots();

  var userData=FirebaseFirestore.instance.collection("users").doc(userId).get();



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()
      {
        return refreshState();
      },
      child: FutureBuilder(future:userData,builder:
      (context,AsyncSnapshot snapshot)
      {
        if(snapshot.hasData)
          {
            return ListView.separated(itemBuilder: (context,index)
                {var sortedList=List.from(snapshot.data['id'].reversed);
                  Future<StoryObject>  tappedStories=Stories(urlProvider(sortedList[index])).fetchData();
                  return FutureBuilder(future:tappedStories,builder:
                  (context,AsyncSnapshot snapshotInside)
                  {
                    if(snapshotInside.hasData) {
                      return storyTile(context, snapshotInside, "history");
                    }
                      else
                      return Container(
                          height: 330,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child:Center(child: CircularProgressIndicator()));
                  });
                }, separatorBuilder: (context,index)
              {return SizedBox(height: 20,);}, itemCount: snapshot.data['id'].length);
          }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }

  Future<void> refreshState() async{


   setState(() {
       userData=FirebaseFirestore.instance.collection("users").doc(userId).get();
     });
  }

}
