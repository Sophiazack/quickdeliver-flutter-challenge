import 'package:flutter/material.dart';

class OrderProgressStepper extends StatelessWidget {
  final String status;

  OrderProgressStepper({required this.status});

  final List<String> steps = [
    'Pending',
    'Picked Up',
    'In Transit',
    'Delivered',
  ];

  int get currentStepIndex {
    final index = steps.indexOf(status);
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      currentStep: currentStepIndex,
      controlsBuilder: (context, details) => const SizedBox.shrink(), // hide Next/Back buttons
      steps: List.generate(steps.length, (index) {
        final stepTitle = steps[index];
        final isCompleted = index < currentStepIndex;
        final isActive = index == currentStepIndex;

        return Step(
          title: Text(
            stepTitle,
            style: TextStyle(
              color: isCompleted
                  ? Colors.green
                  : isActive
                      ? Colors.blue
                      : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          content: const SizedBox.shrink(), // no content, just progress
          state: isCompleted
              ? StepState.complete
              : isActive
                  ? StepState.editing
                  : StepState.indexed,
          isActive: isActive,
        );
      }),
    );
  }
}
