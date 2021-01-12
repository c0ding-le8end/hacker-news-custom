
import 'package:fishing_chimes/networking/stories/stories.dart';
import 'package:fishing_chimes/networking/stories/story_object.dart';
import 'package:fishing_chimes/ui/story_tile.dart';
import 'package:fishing_chimes/util/url_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleList extends StatefulWidget {

  final int navigationBarIndex;
  final ScrollController controller;
  final String articleType;

   ArticleList({Key key,   this.navigationBarIndex, this.controller,this.articleType}) : super(key: key);
  @override
  _ArticleListState createState() => _ArticleListState(navigationBarIndex,controller,articleType);
}

class _ArticleListState extends State<ArticleList> {
   Future id;
  final int navigationBarIndex;
  final ScrollController controller;
  final String articleType;
  int storyCount;
   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
   GlobalKey<RefreshIndicatorState>();//for page refreshing purposes

  _ArticleListState( this.navigationBarIndex, this.controller,this.articleType);
@override
  void initState() {
  id=navigationBarIndex==0?TopStoriesId().fetchData():NewStoriesId().fetchData();
    id.then((value) {
      storyCount=value.length;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: ()
      {
        return onRefresh();
      },
      child: FutureBuilder(future: id,builder:(context,AsyncSnapshot snapshot)
        {
          if(snapshot.hasData)
          {
            return ListView.separated(controller:controller,scrollDirection:Axis.vertical,
              separatorBuilder: (context,index)
              {
                return  SizedBox(width:MediaQuery.of(context).size.width,height: 5,);
              },
              itemBuilder: (context,index)
              {
                Future<StoryObject> _fetchStories=Stories(urlProvider(snapshot.data[index])).fetchData();

                return FutureBuilder(future:_fetchStories,builder: (context,AsyncSnapshot snapshotInside)
                {
                  if(snapshotInside.hasData)
                  {
                    print("${snapshotInside.data.type}  ${snapshotInside.data.id}");
                    return storyTile(context, snapshotInside,articleType);
                  }
                  else {

                    return Container(
                        height: 330,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.white),
                        child:Center(child: CircularProgressIndicator()));
                  }
                });
              },itemCount: storyCount,);
          }
          else
            return Center(child: CircularProgressIndicator(),);
        }),
    );
    }

   Future<void> onRefresh() //refreshes the page
   async
   {print("Refreshed");
   id=navigationBarIndex==0?TopStoriesId().fetchData():NewStoriesId().fetchData();
   id.then((value) => setState(() {
     storyCount=value.length;
   }));

   }

}
