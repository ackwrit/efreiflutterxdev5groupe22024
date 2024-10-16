import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:random_string/random_string.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:musicefreixdevgrp22024/globale.dart';




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
  bool choice = true;
  Uint8List? byteImage;
  String? lienSon;
  String? nameSong;
  Uint8List? byteSon;
  bool isLoading = false;



  //méthode
  //uploader l'image
  Future UploadPicture() async {

    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData : true,
      type : (choice)?FileType.image:FileType.audio
    );
    if(resultat != null){
      if(choice) {
        nameImage = resultat.files.first.name;
        byteImage = resultat.files.first.bytes;
        popUpImage();
      }
      else
        {
          nameSong = resultat.files.first.name;
          byteSon = resultat.files.first.bytes;
          MyFirebaseHelper().uploadData(dossier: "SONS", nomData: nameSong!, bytesData: byteSon!, uuid: monUtilisateur.uid).then((onValue){
            print(onValue);
            setState(() {
              lienSon = onValue;
              isLoading = true;
            });
          });
        }

    }
  }


  popUpImage(){
    showDialog(
      barrierDismissible:false,
      context : context,
      builder:(context){
        return AlertDialog(
          title: Text("Souhaitez enregistrer cette image ?"),
          content : Image.memory(byteImage!),
          actions : [
            TextButton(
              onPressed : (){

                Navigator.pop(context);

              },
              child : Text("Annuler")
            ),
            TextButton(
                onPressed : (){
                  MyFirebaseHelper().uploadData(dossier:"IMAGES",uuid:monUtilisateur.uid,nomData : nameImage!,bytesData:byteImage!).then((onValue){
                    setState(() {
                      lienImage = onValue;
                    });

                  });




                  Navigator.pop(context);

                },
                child : Text("valider")
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
              choice = false;
               UploadPicture();




            },
                child: Text("Upload sons")
            ),
            Spacer(),

            (isLoading) ? ElevatedButton(onPressed: (){
              print(lienSon);
              print(auteur.text);
              print(nom.text);
              if(lienSon != null && auteur.text != "" && nom.text != ""){
                Map<String,dynamic> map = {
                "AUTEUR":auteur.text,
                "NOM":nom.text,
                "POCHETTE": lienImage,
                "LIENS":lienSon,


              };
                //création de l'uuid pour les musiques
              String uid = randomAlphaNumeric(20);

              MyFirebaseHelper().addMusic(uid,map);
              Navigator.pop(context);
              }


            },
                child: const Text("Valider")
            ): Container(),
          ],
        ),
      ) ,
    );
  }
}
