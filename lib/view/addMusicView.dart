import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:random_string/random_string.dart';
import 'dart:typed_data';



class AddMusicView extends StatefulWidget {
  const AddMusicView({super.key});

  @override
  State<AddMusicView> createState() => _AddMusicViewState();
}

class _AddMusicViewState extends State<AddMusicView> {
  //variable
  TextEditingController nom = TextEditingController();
  TextEditingController auteur = TextEditingController();
  String? lienImage;
  String? nameImage;
  //donnée de l'image
  Uint8List? byteImage;



  //méthode
  //uploader l'image
  UploadPicture(){
    FilePickerResult? resultat = await FilePicker.platorm.pickFiles(
      withData : true,
      type : FileType.image
    );
    if(resultat != null){
      nameImage = resultat.files.first.name;
      byteImage = resultat.files.first.bytes;
      popUpImage();
    }
  }

  popUpImage(){
    showDialog(
      barrierDismissible:false,
      context : context,
      builder:(context){
        return AlertDialog(
          title: Text("Souhaitez enregistrer cette image ?"),
          content : Image.memory(bytesImage!),
          actions : [
            TextButton(
              onPressed : (){

                Navigator.pop(context);

              },
              Text("Annuler")
            ),
            TextButton(
                onPressed : (){
                  MyFirebaseHelper().uploadData(dossier:"IMAGES",uuid:monUtilusateur.uid,nameData : nameImage!,byteData:bytesImage!).then((onValue){
                    lienImage = onValue;
                  });




                  Navigator.pop(context);

                },
                Text("valider")
            ),

          ]
        );
      }

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: nom,
            ),
            TextField(
              controller: auteur,
            ),
            ElevatedButton(
                onPressed: (){
              UploadPicture();

            },
                child: Text("Upload Image")
            ),
            ElevatedButton(onPressed: (){

            },
                child: Text("Upload sons")
            ),
            Spacer(),

            ElevatedButton(onPressed: (){
              Map<String,dynamic> map = {
                "AUTEUR":auteur.text,
                "NOM":nom.text,
                "LIEN": lienImage;
              }
              String uid = randomAlphaNumeric(20);

              MyFirebaseHelper().addMusic(uid,map);

            },
                child: Text("Valider")
            ),
          ],
        ),
      ) ,
    );
  }
}
