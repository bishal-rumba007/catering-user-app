import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionCard extends StatelessWidget {
  final String text;
  final String subText;
  final VoidCallback onPressed;
  final IconData iconData;
  const OptionCard(
      {super.key,
        required this.text,
        required this.subText,
        required this.onPressed,
        required this.iconData,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(10.r), // Set the border radius here
      ),
      margin: const EdgeInsets.only(bottom: 2,),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(10.r), // Set the border radius
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Icon(iconData),
              SizedBox(width: 15.w),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        subText,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}