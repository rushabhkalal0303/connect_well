import 'package:connect_well/ui/SplashView/splashScreenHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connect_well/utils/image_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SplashScreenHelpers.NavigateToNextScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashVectors),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(AppImages.companyLogo),
        ),
      ),
    );
  }
}
