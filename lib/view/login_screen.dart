import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:len_den1/view/lend.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  googleLogin(BuildContext context) async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      } else {
        final userData = await reslut.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken,
          idToken: userData.idToken,
        );
        var finalResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print("Result $reslut");
        print(reslut.displayName);
        print(reslut.email);
        print(reslut.photoUrl);
        //final userPhotoURL = reslut.photoUrl;

        

        // Assuming this code is inside your Google Sign-In success block
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override

  Widget build(BuildContext context) {
    double baseWidth = 520.875;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Login'),
        actions: [
          TextButton(
            onPressed: () => logout(),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),*/
      body: Center(
        child: Column(
          children: [ 
          Container(
        width: double.infinity,
        child: Container(
          // getotp1v9 (1:2)
          padding: EdgeInsets.fromLTRB(0*fem, 184.7*fem, 0*fem, 0*fem),
          width: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xff0a2647),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // image1GzV (2:8)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 32.47*fem),
                width: 176.52*fem,
                height: 176.04*fem,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0302085876*fem),
                  child: Image.asset(
                    'assets/page-1/images/image-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                // autogroup6fkd92h (Ruof6BMGnQGnbbn19A6Fkd)
                width: double.infinity,
                height: 746.91*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // vector1fmj (2:22)
                      left: (-100)*fem,
                      top: 104.9812774658*fem,
                      child: Align(
                        child: SizedBox(
                          width: 1086.84*fem,
                          height: 641.93*fem,
                          child: Image.asset(
                            'assets/page-1/images/vector-1.png',
                            width: 1086.84*fem,
                            height: 641.93*fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // vector1Lcy (2:21)
                      left: (-250)*fem,
                      top: 94.8531341553*fem,
                      child: Align(
                        child: SizedBox(
                          width: 1018.12*fem,
                          height: 645.31*fem,
                          child: Image.asset(
                            'assets/page-1/images/vector-1-6TB.png',
                            width: 1018.12*fem,
                            height: 645.31*fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // logintoyouraccountrbK (1:8)
                      left: 94.4374389648*fem,
                      top: 300.1458282471*fem,
                      child: Align(
                        child: SizedBox(
                          width: 332*fem,
                          height: 45*fem,
                          child: Text(
                            'Log in to your Account',
                            textAlign: TextAlign.center,
                            style: TextStyle (
                              //'Poppins',
                              fontSize: 29.9020843506*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5*ffem/fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // borrowhM3 (2:5)
                      left: 105.1964111328*fem,
                      top: 0*fem,
                      child: Center(
                        child: Align(
                          child: SizedBox(
                            width: 350*fem,
                            height: 150*fem,
                            child: Text(
                              'BORROW',
                              textAlign: TextAlign.center,
                              style: TextStyle (
                                fontFamily: 'EuphoriaScript',
                                //'Euphoria Script',
                                fontSize: 75.3656234741*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.1625*ffem/fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    Positioned(
                      // group48096024ypM (680:125)
                      left: 162*fem,
                      top: 390.9802398682*fem,
                      child: ElevatedButton(
                        child: const Text('Login with Google'),
                          style: ElevatedButton.styleFrom(
                            
                            primary:Color(0xff0a2647)),
                        onPressed: () => googleLogin(context), // Pass the context here
          ),
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
            ),
          ]
        ),
      ),
      
    );
  }
}
