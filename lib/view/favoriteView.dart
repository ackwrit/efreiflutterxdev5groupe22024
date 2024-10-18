import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:musicefreixdevgrp22024/model/my_music.dart';
import 'package:musicefreixdevgrp22024/view/playMusicView.dart';
class MyFavoriteView extends StatefulWidget {
  const MyFavoriteView({super.key});

  @override
  State<MyFavoriteView> createState() => _MyFavoriteViewState();
}

class _MyFavoriteViewState extends State<MyFavoriteView> {
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
          else
            {
              if(!snap.hasData){
                return Center(
                  child: Text("Il n'y aucune musique dans la base"),
                );
              }else {
                List documents = snap.data!.docs;
                return GridView.builder(
                    itemCount: documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context,index){
                      MyMusic other = MyMusic.dbb(documents[index]);
                      print("avant le if ${other.uid}");
                      if(monUtilisateur.favoris.contains(other.uid)){
                        print("dans le if ${other.uid}");
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayMusicView(music: other)));
                          },
                          child: Container(
                            child: Text(other.auteur),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(other.pochette),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),

                        );

                      }
                      else
                        {
                          return SizedBox(height: 0,width: 0,);
                        }


                    }
                );
              }
            }
        }
    );
  }
}
