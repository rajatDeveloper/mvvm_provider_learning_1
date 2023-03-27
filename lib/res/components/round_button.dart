import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  const RoundButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.buttonColor),
            height: 40,
            width: 200,
            child: Center(
                child: loading
                    ? const CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      )
                    : Text(
                        title,
                        style: const TextStyle(
                            color: AppColors.whiteColor, fontSize: 16),
                      ))));
  }
}
