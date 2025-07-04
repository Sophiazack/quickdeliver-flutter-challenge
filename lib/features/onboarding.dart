import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quick_deliver/components/onboarding_widget.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  List<Widget> onboardingitems = const [
    OnboardingWidget(
        title: "How does it work",
        description:
            "Signup, send delivery request\nget your package delivered."),
    OnboardingWidget(
        title: "Enjoy your peace of mind",
        description:
            "Get professional riders\nto handle your package with care."),
    OnboardingWidget(
        title: "Trusted Delivery Platform",
        description:
            "Get all your package to be\ndelivered on time avoid disapointment."),
  ];
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB075D1), // Purple
                  Color(0xFF0F172A), // Blue
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CarouselSlider(
                    items: onboardingitems,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1.5,
                        onPageChanged: (index, reason) {}),
                  ),
                ),
              ),
            )));
  }
}
