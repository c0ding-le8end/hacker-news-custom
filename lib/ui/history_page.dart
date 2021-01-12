import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_chimes/model/history.dart';
import 'package:fishing_chimes/util/data_service.dart';
import 'package:fishing_chimes/util/hexcolor.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget//displays the history page
{
  HistoryPage();
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
int historyCount;


Stream<DocumentSnapshot> userHistory=FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: userHistory,
          builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.hasData)
              {
                Map<String,dynamic> documentFields=snapshot.data.data();
            return Text("${documentFields['id'].length} pages viewed");
          }
          else
          return Text("History");}

        ),
        centerTitle: true,

      ),
      body: Container(
        decoration:
            BoxDecoration(color: HexColor("#EFF7FF").withOpacity(1)),
        child: History(),
      ),
    );
  }
}
