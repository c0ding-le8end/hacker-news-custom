import 'package:url_launcher/url_launcher.dart';


///this file stores the code to open a webpage


openUrl(String url,var id) async
{
  if (url == 'N/A') {if (await canLaunch("https://news.ycombinator.com/item?id=$id")) {
    await launch("https://news.ycombinator.com/item?id=$id");
  }
  else
    throw Exception("Exception");

  }
  else {

    if (await canLaunch(url)) {
      await launch(url);
    }
    else
      throw Exception("Exception");
  }
}