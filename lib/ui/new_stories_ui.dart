
import 'package:fishing_chimes/model/article_list.dart';

import 'package:fishing_chimes/util/hexcolor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///Code to create a new stories page



class NewStories {
  int storyCount;
  int _pageIndex = 1; //used by ArticleList to display the type of story(NewStories or TopsStories)
  ScrollController scrollController = ScrollController();

  NewStories({this.scrollController});

  newStoriesUi() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(decoration: BoxDecoration(
                color: HexColor("#EFF7FF").withOpacity(1)),
              child: ArticleList(navigationBarIndex: _pageIndex,
                controller: scrollController,
                articleType: "NewStories",),
            ),
          ),
        ],
      ),
    );
  }
}












// // ignore: must_be_immutable
// class NewStories extends StatefulWidget {
//   ScrollController scrollController=ScrollController();
//   NewStories({this.scrollController});
//   @override
//   _NewStoriesState createState() => _NewStoriesState(this.scrollController);
// }
//
// class _NewStoriesState extends State<NewStories> {
//
//   int storyCount;
//   int _pageIndex=1;//used by ArticleList to display the type of story(NewStories or TopsStories)
//   ScrollController _controller=ScrollController();
//
//   _NewStoriesState(this._controller);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(decoration: BoxDecoration(color: HexColor("#EFF7FF").withOpacity(1)),
//                 child: ArticleList(controller: _controller,navigationBarIndex: _pageIndex
//                   ,articleType: "NewStories",),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//   }