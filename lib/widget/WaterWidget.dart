import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samrt_garden/config/size_config.dart';

class WaterWidget extends StatelessWidget {
  final String iconAsset;
  final VoidCallback onTap;
  final String device;
  final bool itsOn;
  final bool switchCenter;
  final VoidCallback switchButton;
  const WaterWidget({
    Key? key,
    required this.iconAsset,
    required this.onTap,
    required this.device,
    required this.itsOn,
    required this.switchCenter,
    required this.switchButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: getProportionateScreenWidth(45),
        height: getProportionateScreenHeight(45),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: itsOn
              ? Colors.green
              : const Color(0xffededed),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: itsOn
                          ? Colors.green
                          : const Color(0xffdadada),
                      borderRadius:
                      const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: Image.asset(
                      iconAsset,
                      color: itsOn ? Colors.blue : const Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
