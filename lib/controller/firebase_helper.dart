

class MyFirebaseHelper{
  //attributs
  final auth = FirebaseAuth.instance;
  final mesUtilisateurs = FirebaseFirestore.instance.collection("UTILISATEURS");
  final mesMusiques = FirebaseFirestore.instance.collection("MUSIQUES");
  final mesStorages = FirebaseStorage.instance;


  //méthode
  //ajouter des utilisateurs
  addUser(String uid,Map<String,dynamic> data){
    mesUtilisateurs.doc(uid).set(data);

  }

 //inscription
  register(String email,String password) async{
    UserCredential credential = await auth.createUserWithEmailAndPassword(email:email,password:password);
    String uid = credential.user!.uid;
    Map<String,dynamic> data = {
      "MAIL":email,
      "FAVORIS":[]
    };
    addUser(uid,data);

  }


//se connecter
connect(String email, String password) async {
  UserCredential credential = await auth.sigInWithEmailAndPassword(email:email,password:password);
}



}