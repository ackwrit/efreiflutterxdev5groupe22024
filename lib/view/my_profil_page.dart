import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/globale.dart';

class MyProfilPage extends StatefulWidget {
  const MyProfilPage({super.key});

  @override
  State<MyProfilPage> createState() => _MyProfilPageState();
}

class _MyProfilPageState extends State<MyProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(monUtilisateur.avatar ?? defaultImage),
          radius: 60,
        ),
        Text(monUtilisateur.email),
        Divider(),
        Spacer(),
        ElevatedButton(
            onPressed: (){

            },
            child: Text("PAIEMENT")
        ),
      ],

    );
  }
}