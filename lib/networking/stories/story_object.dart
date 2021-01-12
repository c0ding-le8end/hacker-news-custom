/*This file contains the code to create a PODO(Plain Old Dart Object)
A PODO is created to access the fetched JSON data in a Dart fashion
Example: intead of writing something like
data=json_data['field']
we write:
data=json_data.field
 */


class StoryObject {
  String by;
  int descendants;
  int id;
  //List<int> kids;
  int score;
  int time;
  String title;
  String type;
  String url;
  String text;
  bool deleted;

  StoryObject(
      {this.by,
        this.descendants,
        this.id,
       // this.kids,
        this.score,
        this.time,
        this.title,
        this.type,
        this.url,
      this.deleted});

  StoryObject.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    descendants = json['descendants'];
    id = json['id'];
    //kids = json['kids'].cast<int>();
    score = json['score'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    if(json.containsKey('url'))
      {
        url = json['url'];
      }
    else
      url="N/A";
    if(json.containsKey('deleted'))
      deleted=json['deleted'];
    else
      deleted=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    //data['kids'] = this.kids;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['deleted']=this.deleted;
    return data;
  }
}