
import 'package:fishing_chimes/model/article_list.dart';
import 'package:fishing_chimes/util/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



///Code to create a top stories page

class TopStories {
  int storyCount;
  int _pageIndex = 0; //used by ArticleList to display the type of story(NewStories or TopsStories)
  ScrollController scrollController = ScrollController();

  TopStories({this.scrollController});

  topStoriesUi() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(decoration: BoxDecoration(
                color: HexColor("#EFF7FF").withOpacity(1)),
              child: ArticleList(navigationBarIndex: _pageIndex,
                controller: scrollController,
                articleType: "TopStories",),
            ),
          ),
        ],
      ),
    );
  }
}












// class TopStories extends StatefulWidget {
//  ScrollController scrollController=ScrollController();

//   TopStories({this.scrollController});
//   @override
//   _TopStoriesState createState() => _TopStoriesState(this.scrollController);
// }
//
// class _TopStoriesState extends State<TopStories> {
//
//   int storyCount;
//   int _pageIndex=0; //used by ArticleList to display the type of story(NewStories or TopsStories)
//   ScrollController _controller=ScrollController();
//
//   _TopStoriesState(this._controller);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(decoration: BoxDecoration(color: HexColor("#EFF7FF").withOpacity(1)),
//                 child: ArticleList(navigationBarIndex: _pageIndex,controller: _controller,articleType: "TopStories",),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//
//   }
//
//
//   }
