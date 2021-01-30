import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_auth/services/auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final authService = AuthServices();
  final googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => authService.currentUser;

  loginInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      /// sign in user to firebase
      final result = await authService.signInWithCredential(credential);
      print('${result.user.displayName}');
    } catch (e) {
      print(e.toString());
    }
  }

  logOut() {
    googleSignIn.signOut();
    authService.logout();
  }
}
