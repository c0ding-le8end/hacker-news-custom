//provides the url where the json of a story article is stored
String urlProvider(var articleId) {
  return "https://hacker-news.firebaseio.com/v0/item/$articleId.json?print=pretty";
}