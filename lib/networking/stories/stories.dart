import 'dart:convert';

import 'package:fishing_chimes/networking/stories/story_object.dart';

import 'package:http/http.dart';

class NewStoriesId//to extract the IDs of the new stories from HackerNews
    {
  final String url="https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty";

  Future fetchData() async
  {
    Response response=await get(Uri.encodeFull(url));
    if(response.statusCode==200)
    {
      return json.decode(response.body);
    }
    else
    {
      throw Exception("Error Recieving Data:\n${response.statusCode}");
    }
  }
}

class Stories//used to create PODO (Plain Old Dart Object) from the fetched JSON data
{
  final String url;

  Stories(this.url);

  Future<StoryObject> fetchData() async
  {
    Response response=await get(Uri.encodeFull(url));
    if(response.statusCode==200)
      {
        return StoryObject.fromJson(json.decode(response.body));
      }
    else
      {
        throw Exception("Error Recieving Data\n${response.statusCode} ");
      }
  }

}
class TopStoriesId //to extract the IDs of top stories from HackerNews
{
  final String url="https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";

  Future fetchData() async
  {
    Response response=await get(Uri.encodeFull(url));
    if(response.statusCode==200)
    {
      return json.decode(response.body);
    }
    else
    {
      throw Exception("Error Recieving Data:\n${response.statusCode}");
    }
  }
}

