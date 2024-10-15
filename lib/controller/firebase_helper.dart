

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseHelper{
  //attributs
  final auth = FirebaseAuth.instance;
  final mesUtilisateurs = FirebaseFirestore.instance.collection("UTILISATEURS");
  final mesMusiques = FirebaseFirestore.instance.collection("MUSIQUES");
  final mesStorages = FirebaseStorage.instance;


  //méthode
  //ajouter des utilisateurs
  addUser(String uid,Map<String,dynamic> data){
    mesUtilisateurs.doc(uid).set(data);

  }

 //inscription
  register(String email,String password) async{
    UserCredential credential = await auth.createUserWithEmailAndPassword(email:email,password:password);
    String uid = credential.user!.uid;
    Map<String,dynamic> data = {
      "MAIL":email,
      "FAVORIS":[]
    };
    addUser(uid,data);

  }


//se connecter
connect(String email, String password) async {
  UserCredential credential = await auth.signInWithEmailAndPassword(email:email,password:password);
}



}