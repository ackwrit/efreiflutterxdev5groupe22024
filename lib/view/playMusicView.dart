import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class PlayMusicView extends StatefulWidget {
  const PlayMusicView({super.key});

  @override
  State<PlayMusicView> createState() => _PlayMusicViewState();
}

class _PlayMusicViewState extends State<PlayMusicView> {
  //variable
  StatutLecture lecture =  StatutLecture.stop;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration positionnement = Duration(seconds: 0);
  late StreamSubscription positionStream;
  late StreamSubscription stateStream;
  Duration dureeTotal = Duration(seconds: 0);



  double valueSlider = 0;
  double volumeSound = 0.5;
  bool isPlaying = false;

  //méthode
  configPlayer(){
    //définir la musique qui va être lu
    audioPlayer.setSourceAsset("lib/music/reggae.mp3");
    //définier ce flux
    positionStream = audioPlayer.onPositionChanged.listen((onData){
      setState(() {
        positionnement = onData;
      });
      audioPlayer.onDurationChanged.listen((onData){
        setState(() {
          print(onData);
          dureeTotal = onData;
        });
      });

      stateStream = audioPlayer.onPlayerStateChanged.listen((onData){
        if(PlayerState.playing == onData){
          setState(() async {
            print(dureeTotal);
            dureeTotal = await audioPlayer.getDuration() as Duration;
            lecture = StatutLecture.play;
          });
        }
        else if(onData == PlayerState.stopped){
          setState(() async{
            lecture = StatutLecture.stop;
            dureeTotal = await audioPlayer.getDuration() as Duration;
          });

        }
      });

    });
  }

  //fonction lecture
  play() async{
    if(positionnement < dureeTotal){

      await audioPlayer.play(AssetSource("lib/music/reggae.mp3"),volume:volumeSound,position: positionnement);
    }
    else {
      lecture = StatutLecture.stop;
      positionnement = Duration(seconds: 0);
    }


  }

  pause() async {
    await audioPlayer.pause();
  }


  @override
  void initState(){
    super.initState();
    configPlayer();
  }


  @override
  void dispose(){
    super.dispose();
  }


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
            height: (!isPlaying)?150:300,
            width : (!isPlaying)?250:450,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/modeling.png")
              )
            ),
          ),



          //titre de la musique
          Text("Titre le musique"),

          //artiste
          Text("Artiste de la musique"),


          //type de la musique
          Text("type de la musique"),
          Spacer(),





          //Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(positionnement.toString().substring(2,7)),
              Text(dureeTotal.toString().substring(2,7)),
            ],
          ),
          Slider(
              min: 0.0,
              max : dureeTotal.inSeconds.toDouble(),
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
                    print("retour en arrière");
                  },
                  icon: FaIcon(FontAwesomeIcons.backward)
              ),
              IconButton(
                  onPressed: (){
                    print("pause");
                    pause();
                  },
                  icon: FaIcon(FontAwesomeIcons.pause)
              ),
              IconButton(
                  onPressed: (){
                    print("lecture");
                    play();
                  },
                  icon: FaIcon(FontAwesomeIcons.play)
              ),
              IconButton(
                  onPressed: (){
                    print("on avance");
                  },
                  icon: FaIcon(FontAwesomeIcons.forward)
              ),
            ],
          ),


          //slider pour le volume
          Slider(
              min: 0.0,
              max : 1,
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