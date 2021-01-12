import 'package:cloud_firestore/cloud_firestore.dart';
/*
When the anonymous user is created, this file sets two fields in the user record
id-> this stores the ids of the articles clicked by the user,i.e,it stores the user history(set to an empty list by the DataService class
time->sets the time of anonymous user creation
 */
 var userId;//stores the user Id that is also a document id of the users collection in the firestore
 var userLoginTime;
class DataService
{
  final String id;

  DataService(this.id);

  final CollectionReference sample=FirebaseFirestore.instance.collection("users");

  Future updateData() async
  {print(id.toString());
    final collectionExistence= await FirebaseFirestore.instance.collection("users").doc(id).get();
    if(collectionExistence==null ||!collectionExistence.exists) {
      List a=[];
      userLoginTime=DateTime.now();
      await sample.doc(id).set({'time':userLoginTime,'id':FieldValue.arrayUnion(a)});
    }
   userId=id;

  }
}