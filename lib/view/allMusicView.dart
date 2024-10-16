import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/model/my_music.dart';
import 'package:musicefreixdevgrp22024/view/playMusicView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Allmusicview extends StatefulWidget {
  const Allmusicview({super.key});

  @override
  State<Allmusicview> createState() => _AllmusicviewState();
}

class _AllmusicviewState extends State<Allmusicview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: MyFirebaseHelper().mesMusiques.snapshots(),
        builder: (context,snap){
          if(snap.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          else if(!snap.hasData){
            return Center(
              child: Text("Aucune musique"),
            );
          }
          else {
            List documents = snap.data!.docs;
            return GridView.builder(
              itemCount: documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context,index){
                MyMusic lesmusics = MyMusic.dbb(documents[index]);
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayMusicView(music:lesmusics)));
                  },
                  child: Container(
                    child: Text(lesmusics.nom,
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 30,
                        )
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(lesmusics.pochette)
                        )
                    ),
                  ),
                );
                }
            );
          }
        }
    );
  }
}
