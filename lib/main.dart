import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fishing_chimes/ui/main_screen.dart';
import 'package:fishing_chimes/util/data_service.dart';
import 'package:fishing_chimes/util/hexcolor.dart';
import 'package:flutter/material.dart';
import 'networking/authentication/anonymous_auth.dart';


StreamController<int> streamController=StreamController<int>();//used later for setting GoogleNavigationBar State

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AnonymousAuth _auth=AnonymousAuth();
  await _auth.signInAnon();// for anonymous user log in
  var userData=FirebaseFirestore.instance.collection('users').doc(userId).snapshots();//extraction of anonymous user history
  ThemeData themeData=theme();
  runApp(MaterialApp(home:MainScreen(stream:streamController.stream,userData: userData,),theme: themeData,));
}

 theme()
{
  final ThemeData base=ThemeData.light();
  return base.copyWith(
    appBarTheme: AppBarTheme(color:  HexColor("#FF5700	"),textTheme: TextTheme(headline6: TextStyle(
    fontSize: 25,)))
  );
}
