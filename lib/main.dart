import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/my_animation.dart';
import 'package:musicefreixdevgrp22024/view/my_dash_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:musicefreixdevgrp22024/controller/MyPermissionImage.dart';
import 'package:musicefreixdevgrp22024/view/playMusicView.dart';
import 'package:musicefreixdevgrp22024/view/addMusicView.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyPermissionImage().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "cocuou"),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
              children: [
                //image
                Container(
                  height: 450,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage("lib/assets/woman.jpg"),
                          fit: BoxFit.fill
                      )
                  ),


                ),
                const SizedBox(height: 10,),


                //adresse mail
                MyAnimation(
                  time: 1,
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: mail,
                      decoration: InputDecoration(
                          hintText: "Entrer votre mail",
                          prefixIcon: const Icon(Icons.mail),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )

                      ),

                    ),
                  ),
                ),
                const SizedBox(height: 10,),



                //mot de passe
                MyAnimation(
                  time: 2,
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Entrer votre password",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )

                      ),

                    ),
                  ),
                ),

                const SizedBox(height: 10,),



                //bouton connexion
                MyAnimation(
                  time: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Connexion"),
                        onPressed: (){
                          MyFirebaseHelper().connect(mail.text, pass.text).then((onValue){
                            setState(() {
                              monUtilisateur = onValue;
                            });
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> MyDashBoard()));

                          }).catchError((onError){
                            //afficher un pop up
                          });


                        },
                      ),

                      //bouton inscription
                      TextButton(
                        child: const Text("Inscription"),
                        onPressed: (){
                          MyFirebaseHelper().register(mail.text,pass.text).then((onValue){
                            setState(() {
                              monUtilisateur = onValue;
                            });
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> MyDashBoard()));
                          }).catchError((onError){

                          });

                        },
                      ),


                    ],
                  ),
                ),





                const Spacer()
              ]
          ),
        ),
      ),






      /*GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 20,
        children: [
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
        ],
        crossAxisCount: 3,
      )


      ListView(
        children: [
           Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key : Key("dgfsgdf"),
            child: Container(
               color: Colors.blue,
              height: 200,
              width: double.infinity,
            ),
          ),
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key : Key("dgfsgdfyfjf,hgfhg"),
            child: Container(
               color: Colors.yellow,
              height: 200,
              width: double.infinity,
            ),
          ),
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key : Key("dgfsgdfhfht"),
            child: Container(
               color: Colors.purple,
              height: 200,
              width: double.infinity,
            ),
          ),
        ],
      )


       Container(
        height: 400,
        width: double.infinity,
        color: Colors.blue,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: [
              Image.asset("lib/assets/woman.jpg",
          height: 350,
          width: 200,),

           ElevatedButton(
            onLongPress: (){
              print("j'ai pressé longtemps");
            },
            child: Text("Inscription"),
            onPressed: (){
              print("j'ai appuyé");
            },

            ),
            Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),


            ],
          ),
        ),
      )



      TextField(
        obscureText: true,

      )


       Image.asset("lib/assets/woman.jpg",
      height: 350,
      width: 200,)




      ElevatedButton(
        onLongPress: (){
          print("j'ai pressé longtemps");
        },
        child: Text("Inscription"),
        onPressed: (){
          print("j'ai appuyé");
        },

        )



       Container(
        height: 250,
        width: 300,
        child: Text('je suis dans le container'),

        decoration: BoxDecoration(
          color: Colors.red,

          borderRadius: BorderRadius.circular(15)
        ),
      )



      Text("Je suis une chaine",
      style:TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        fontSize: 40
        )


      )
      */

    );
  }
}
