import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';

class AllPersonn extends StatefulWidget {
  const AllPersonn({super.key});

  @override
  State<AllPersonn> createState() => _AllPersonnState();
}

class _AllPersonnState extends State<AllPersonn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: MyFirebaseHelper().mesUtilisateurs.snapshots(),
        builder: (context,snap){
          if(ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            if(!snap.hasData){
              return Center(
                child: Text("Aucune donnée disponible"),
              );
            }else
              {
                List documents = snap.data();
                return ListView.builder(
                  itemCount: documents.length,
                    itemBuilder: (context,index){
                     MyUser other = MyUser.dbb(documents[index]);
                     return ListTile(
                       title: Text(other.nom!),
                       subtitle: Text(other.email),
                     )
                    }
                );
              }
          }
        }
    );
  }
}
