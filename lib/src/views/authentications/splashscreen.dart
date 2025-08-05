import 'package:flutter/material.dart';
import 'package:rrfx/src/views/authentications/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rrfx/src/components/alerts/default.dart';
import 'package:rrfx/src/controllers/two_factory_auth.dart';
import 'package:get/get.dart';
import 'package:rrfx/src/controllers/home.dart';
import 'package:rrfx/src/helpers/handlers/permissions.dart';
import 'package:rrfx/src/service/auth_service.dart';
import 'package:rrfx/src/views/mainpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  TwoFactoryAuth twoFactoryAuth = Get.put(TwoFactoryAuth());
  HomeController homeController = Get.put(HomeController());
  AuthService authService = Get.find();

  Future<bool> getLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('loggedIn') ?? false;
  }

  @override
  void initState() {
    PermissionHandlers.requestPermissions();
    super.initState();
    getLoggedIn().then((loggedIn) async {
      if(loggedIn){
        Map<String, dynamic> result = await authService.get("profile/info");
        if(result['statusCode'] == 200){
          homeController.profile().then((resultProfile){
            if(!resultProfile){
              CustomAlert.alertError(message: homeController.responseMessage.value, onTap: (){
                Get.offAll(() => const IntroductionScreen());
              });
              return;
            }
            Get.offAll(() => const Mainpage());
          });
          return;
        }
        Get.offAll(() => const IntroductionScreen());
      }else{
        Get.offAll(() => const IntroductionScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo-rrfx.png', width: size.width / 2),
          ],
        ),
      ),
    );
  }
}
