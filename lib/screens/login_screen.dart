import 'package:flutter/material.dart';
import 'package:wooyoungsoo/services/member_service/google_login_service.dart';
import 'package:wooyoungsoo/services/member_service/kakao_login_service.dart';
import 'package:wooyoungsoo/services/member_service/social_login_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/social_login_button_widget.dart';

/// 로그인 화면
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  late SocialLoginService socialLoginService;
  // TODO(Cho-SangHyun): 추후 기로그인 여부에 따라 바로 홈으로 가도록 해야 함
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.66,
              height: MediaQuery.of(context).size.width * 0.66,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appLogoPath),
                ),
              ),
            ),
            SosialLoginButton(
              assetName: "assets/images/kakao-logo.svg",
              buttonText: "Kakao 계정으로 로그인",
              buttonColor: kakaoButtonColor,
              textColor: kakaoTextColor,
              onPressed: () {
                socialLoginService = KakaoLoginService();
                socialLoginService.login();
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SosialLoginButton(
              assetName: "assets/images/google-logo.svg",
              buttonText: "Google 계정으로 로그인",
              buttonColor: googleButtonColor,
              textColor: googleTextColor,
              onPressed: () {
                socialLoginService = GoogleLoginService();
                socialLoginService.login();
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SosialLoginButton(
              assetName: "assets/images/apple-logo.svg",
              buttonText: "Apple 계정으로 로그인",
              buttonColor: appleButtonColor,
              textColor: appleTextColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
