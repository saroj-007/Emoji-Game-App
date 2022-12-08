import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = 
        await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
          await _auth.signInWithCredential(authCredential);

        print(_auth.currentUser!.uid); 
      }
    }
    on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  googleLogout() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}