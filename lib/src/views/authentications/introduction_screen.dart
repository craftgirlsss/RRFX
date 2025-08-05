import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rrfx/src/components/buttons/custom_buttons.dart';
import 'package:rrfx/src/components/colors/background.dart';
import 'package:rrfx/src/components/utilities/utilities.dart';
import 'package:rrfx/src/controllers/firebase_api_controller.dart';
import 'package:rrfx/src/controllers/google_auth_controller.dart';
import 'package:rrfx/src/helpers/handlers/permissions.dart';
import 'package:rrfx/src/views/authentications/signin.dart';
import 'package:rrfx/src/views/authentications/signup.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  GoogleSignInController googleController = Get.put(GoogleSignInController());
  // int _currentImageIndex = 0;
  double opacity = 1.0;
  // late Timer _timer;

  // final List<String> _images = [
  //   'assets/images/1.jpg',
  //   'assets/images/2.jpg',
  //   'assets/images/3.jpg',
  // ];

  @override
  void initState() {
    super.initState();
    // _startImageFadeAnimation();
    FirebaseAPI.getToken();
    PermissionHandlers.requestPermissions();
  }

  // void _startImageFadeAnimation() {
  //   _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
  //     setState(() {
  //       opacity = 0.0;
  //     });

  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       setState(() {
  //         _currentImageIndex = (_currentImageIndex + 1) % _images.length;
  //         opacity = 1.0;
  //       });
  //     });
  //   });
  // }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // SizedBox(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: AnimatedOpacity(
          //     duration: const Duration(milliseconds: 600),
          //     opacity: _opacity,
          //     child: Image.asset(
          //       _images[_currentImageIndex],
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          BackgroundColor.defaultBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UtilitiesComponents.titlePage(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width,
                        child: CustomButtons.buildFilledButton(
                          text: "Masuk",
                          onPressed: (){
                            Get.to(() => const SignIn());
                          }
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SizedBox(
                        width: size.width,
                        child: CustomButtons.buildOutlinedButton(
                          text: "Daftar",
                          onPressed: () {
                            Get.to(() => const Signup());
                          }
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      /*
                      Text("Atau"),
                      CustomButtons.buildGoogleLoginButton(
                        text: "Masuk dengan Google",
                        onPressed: () async {
                          try {
                            final userCredential = await googleController.signInWithGoogle();
                            if (userCredential.user != null) {
                              print("Berhasil login dengan nama akun ${userCredential.user?.email}");
                              Get.offAll(() => const SelectUsersType());
                              // Navigator.pushReplacementNamed(context, '/home'); // ganti dengan route kamu
                            }
                          } catch (e) {
                            debugPrint('Login gagal: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login gagal. Silakan coba lagi.")),
                            );
                          }
                        }
                      ),
                      */
                      const SizedBox(height: 20.0),
                      UtilitiesComponents.privacyPolicy(context),
                      const SizedBox(height: 9.0),
                      UtilitiesComponents.rrfx(context)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}