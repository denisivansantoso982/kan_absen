import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> getCurrentUser() async {
  User? theUser;
  auth.authStateChanges().listen((user) {
    if (user != null) {
      theUser = user;
    }
  }).onError((error) => Future.error(error));

  await Future.delayed(const Duration(seconds: 1));

  return theUser;
}

Future<GoogleSignInAccount?> signInWithGoogle() async {
  final GoogleSignInAccount? result = await GoogleSignIn().signIn();

  return result;
}

Future<UserCredential> authenticationEmail(
    GoogleSignInAccount googleUser) async {
  final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;
  final theCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await auth.signInWithCredential(theCredential);
}

Future<void> signOut() async {
  auth.signOut();
  GoogleSignIn().signOut();
}
