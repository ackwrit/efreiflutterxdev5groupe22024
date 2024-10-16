import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class PlayMusicView extends StatefulWidget {
  const PlayMusicView({Key? key}) : super(key: key);

  @override
  _PlayMusicViewState createState() => _PlayMusicViewState();
}

class _PlayMusicViewState extends State<PlayMusicView> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration positionnement = Duration(seconds: 0);
  late StreamSubscription positionStream;
  late StreamSubscription stateStream;
  Duration dureeTotal = Duration(seconds: 0);
  double valueSlider = 0;
  double volumeSound = 0.5;
  bool isPlaying = false;

  void configPlayer() {
    // Définir la musique à partir des assets
    audioPlayer.setSourceAsset("reggae.mp3");

    // Écouteur pour la position
    positionStream = audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        positionnement = event;
      });
    });

    // Écouteur pour la durée totale
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        dureeTotal = event;
      });
    });

    // Écouteur pour l'état de lecture
    stateStream = audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else if (event == PlayerState.paused || event == PlayerState.stopped) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  void play() async {
    await audioPlayer.play(AssetSource("reggae.mp3"), position: positionnement, volume: volumeSound);
    print(positionnement);
  }

  void pause() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    super.initState();
    configPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    positionStream.cancel();
    stateStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecteur Audio'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Pochette de l'album
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            height: isPlaying ? 300 : 150,
            width: isPlaying ? 450 : 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/modeling.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Informations sur la musique
          Text("Titre de la musique"),
          Text("Artiste de la musique"),
          Text("Type de la musique"),

          // Slider de progression
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(positionnement.toString().split('.').first),
                Text(dureeTotal.toString().split('.').first),
              ],
            ),
          ),
          Slider(
            min: 0.0,
            max: dureeTotal.inSeconds.toDouble(),
            value: positionnement.inSeconds.toDouble(),
            onChanged: (value) {
              setState(() {
                //valueSlider = value;
                positionnement = Duration(seconds: value.toInt());
              });
            },
          ),

          // Boutons de contrôle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  print("retour en arrière");
                },
                icon: FaIcon(FontAwesomeIcons.backward),
              ),

              IconButton(
                onPressed: () {

                  (isPlaying)?pause():play();
                },
                icon: FaIcon(isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play),
              ),
              IconButton(
                onPressed: () {
                  print("on avance");
                },
                icon: FaIcon(FontAwesomeIcons.forward),
              ),
            ],
          ),

          // Slider de volume
          Slider(
            min: 0.0,
            max: 1.0,
            value: volumeSound,
            onChanged: (value) {
              setState(() {
                volumeSound = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

