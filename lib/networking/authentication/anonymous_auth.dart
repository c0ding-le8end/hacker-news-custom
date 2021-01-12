
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishing_chimes/util/data_service.dart';


class AnonymousAuth//Used to create an anonymous user
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future signInAnon() async
  {
    try
        {
          UserCredential result=await _auth.signInAnonymously();
          User user=result.user;
          DataService(user.uid).updateData();
          return user;
        }
        catch (e)
    {
      e.toString();
      print(e);
      return null;
    }

  }
}