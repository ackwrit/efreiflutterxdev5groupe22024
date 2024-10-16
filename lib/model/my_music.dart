import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMusic{

  late String uid;
  late String nom;
  late String auteur;
  late String pochette;
  late MyStyleMusic style;
  late String link;



  MyMusic(){
    uid = "";
    nom = "";
    auteur = "";
    pochette = "";
    style = MyStyleMusic.disco;
    link = "";
  }

  MyMusic.dbb(DocumentSnapshot snap){
    uid = snap.id;
    Map<String,dynamic> map = snap.data() as Map<String,dynamic>;
    nom = map["NOM"];
    auteur = map["AUTEUR"];
    pochette = map["POCHETTE"];
    link = map["LIENS"];
  }




}