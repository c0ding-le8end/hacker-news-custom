import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';

///contains the code to share an article url to other apps

shareArticle({url, String altUrl,BuildContext context}) {
  RenderBox box=context.findRenderObject();
  Share.share("Check this article out ${url=='N/A'?altUrl:url}",sharePositionOrigin: box.localToGlobal(Offset.zero)&box.size);
}