import 'package:flutter/material.dart';

class PlayMusicView extends StatefulWidget {
  const PlayMusicView({super.key});

  @override
  State<PlayMusicView> createState() => _PlayMusicViewState();
}

class _PlayMusicViewState extends State<PlayMusicView> {
  double valueSlider = 0;
  double volumeSound = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

      ),
      body: Column(
        children: [
          //pochette
          AnimatedContainer(
              duration: Duration(seconds: 2),
            //height: (quand la lecture se en pause ou non )?150:300,
            //width : (quand la lecture se en pause ou non )?250:450,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("/lib/assets/modeling.png")
              )
            ),
          ),



          //titre de la musique
          Text("Titre le musique")

          //artiste
          Text("Artiste de la musique")


          //type de la musique
          Text("type de la musique")





          //Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("afficher le positionnement de la musique en minutes"),
              Text("afficher la durée total de la musique en minutes"),
            ],
          )
          Slider(
              min: 0.0,
              //max : durée de notre musique
              value: valueSlider,
              onChanged: (value){
                setState(() {
                  valueSlider = value;
                });
              }
          ),


          //Icone pour la lecture,pause , avance rapide , retour en arrière
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    print("retour en arrière")
                  },
                  icon: FaIcon(FontAwesomeIcons.backward)
              ),
              IconButton(
                  onPressed: (){
                    print("pause")
                  },
                  icon: FaIcon(FontAwesomeIcons.pause)
              ),
              IconButton(
                  onPressed: (){
                    print("lecture")
                  },
                  icon: FaIcon(FontAwesomeIcons.play)
              ),
              IconButton(
                  onPressed: (){
                    print("on avance")
                  },
                  icon: FaIcon(FontAwesomeIcons.forward)
              ),
            ],
          )


          //slider pour le volume
          Slider(
              min: 0.0,
              max : 1
              value: volumeSound,
              onChanged: (value){
                setState(() {
                  volumeSound = value;
                });
              }
          ),



        ],
      ),

    );
  }
}