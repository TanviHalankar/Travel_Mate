import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/widget/back.dart';

import 'build2.dart';
import 'build3.dart';
import 'build4.dart';
import 'build_itinerary.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int _activeStepIndex = 0;
  String selectedDestination = '';
  int selectedDuration = 1;
  double selectedBudget = 1000;

  stepState(int step) {
    if (_activeStepIndex > step) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  stepList() => [
        Step(
          title: const Text(''),
          content: BuildItinerary(place: selectedDestination,),
          state: stepState(0),
          isActive: _activeStepIndex >= 0,
        ),
        Step(
          title: const Text(''),
          content: Build2(),
          state: stepState(1),
          isActive: _activeStepIndex >= 1,
        ),
        Step(
          title: const Text(''),
          content: Build3(),
          state: stepState(2),
          isActive: _activeStepIndex >= 2,
        ),
    Step(
      title: const Text(''),
      content: Build4(destination: selectedDestination, duration: selectedDuration, budget: selectedBudget,),
      state: stepState(2),
      isActive: _activeStepIndex >= 3,
    )
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(children: [
          Opacity(
            opacity: 0.1,
              child: Image.network(
                  'https://img.freepik.com/free-photo/one-person-standing-cliff-achieving-success-generated-by-ai_188544-11834.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity)),
          //BackGround(),
          Stepper(
            type: StepperType.horizontal,
            controlsBuilder: (context, controls) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            },
            onStepTapped: (step) => setState(() => _activeStepIndex = step),
            currentStep: _activeStepIndex,
            steps: stepList(),
          ),
        ]),
        bottomNavigationBar: InkWell(
          onTap: () {
            setState(
              () {
                if (_activeStepIndex < 3) {
                  setState(
                    () {
                      _activeStepIndex = _activeStepIndex += 1;
                    },
                  );
                }
                // if (_activeStepIndex == 1) {
                //   // Update selectedDestination based on the first step
                //   selectedDestination = /* Get the selected destination */;
                // } else if (_activeStepIndex == 2) {
                //   // Update selectedDuration and selectedBudget based on the second step
                //   selectedDuration = /* Get the selected duration */;
                //   selectedBudget = /* Get the selected budget */;
                // }
              },
            );
          },
          child: Container(
            height: 50,
            //color: Colors.blueGrey.shade800,
            color: Colors.transparent,
            child: Center(
              child: Text(
                'Next',
                style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
