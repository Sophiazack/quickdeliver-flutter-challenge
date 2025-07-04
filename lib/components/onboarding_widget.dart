// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_deliver/theme/theme.dart';

class OnboardingWidget extends StatefulWidget {
  final String title;
  final String description;
  const OnboardingWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 187,
          width: 350,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -10,
          child: GestureDetector(
            onTap: () => context.goNamed('/signin'),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF0F172A),
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.arrow_forward),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
