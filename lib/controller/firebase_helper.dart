

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:musicefreixdevgrp22024/model/my_user.dart';

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

  addMusic(String uid,Map<String,dynamic> data){
    mesMusiques.doc(uid).set(data);
  }

 //inscription
  Future<MyUser>register(String email,String password) async{
    UserCredential credential = await auth.createUserWithEmailAndPassword(email:email,password:password);
    String uid = credential.user!.uid;
    Map<String,dynamic> data = {
      "MAIL":email,
      "FAVORIS":[]
    };
    addUser(uid,data);
    return getUser(uid);

  }


//se connecter
Future <MyUser>connect(String email, String password) async {
  UserCredential credential = await auth.signInWithEmailAndPassword(email:email,password:password);
  String uid = credential.user!.uid;
  return getUser(uid);
}

Future<MyUser>getUser(String uid) async {
    DocumentSnapshot snapshot = await mesUtilisateurs.doc(uid).get();
    return MyUser.dbb(snapshot);
}

//stocker des données
Future<String>uploadData({required String dossier,required String nomData, required Uint8List bytesData, required String uuid}) async{
    //déposer les données

  TaskSnapshot snap = await mesStorage.ref("$dossier/$uuid/$nomData").putData(bytesData);

  //récupérer l'url
  String urlData = await snap.ref.getDownloadUrl();
  return urlData;

}




}