import 'package:flutter/material.dart';

class StepperBasic extends StatefulWidget {
  @override
  _StepperBasicState createState() => _StepperBasicState();
}

class _StepperBasicState extends State<StepperBasic> {
  List<Step> steps;
  int currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  List<Step> makeSteps() {
    steps = [
      Step(
        title: Text('First'),
        subtitle: Text('1st step'),
        content: Text('This is the first step'),
        isActive: true,
      ),
      Step(
        title: Text('Second'),
        subtitle: Text('2nd step'),
        content: Text('This is the second step'),
        isActive: true,
        state: StepState.complete,
      ),
      Step(
        title: Text('Third'),
        subtitle: Text('3rd step'),
        content: Text('This is the third step'),
        isActive: true,
        state: StepState.editing,
      ),
      Step(
        title: Text('Fourth'),
        subtitle: Text('4th step'),
        content: Text('This is the fourth step'),
        // isActive: true,
        state: StepState.disabled,
      ),
    ];

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Stepper'),
      ),
      body: Stepper(
        steps: makeSteps(),
        type: stepperType,
        currentStep: currentStep,
        onStepTapped: (int index) {
          print('$index is tapped');
          setState(() => currentStep = index);
        },
        onStepContinue: () {
          print('Continue button is clicked');
          setState(() {
            if (currentStep < steps.length - 1) {
              currentStep = currentStep + 1;
            } else {
              currentStep = 0;
            }
          });
        },
        onStepCancel: () {
          print('Cancel button is clicked');
          setState(() {
            if (currentStep > 0) {
              currentStep = currentStep - 1;
            } else {
              currentStep = 0;
            }
          });
        },
        controlsBuilder: (
          BuildContext context, {
          VoidCallback onStepContinue,
          VoidCallback onStepCancel,
        }) {
          return Row(
            children: <Widget>[
              RaisedButton(
                child: Text('NEXT'),
                color: Theme.of(context).primaryColor,
                onPressed: onStepContinue,
              ),
              SizedBox(width: 10),
              RaisedButton(
                child: Text('PREV'),
                onPressed: onStepCancel,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.transform),
        onPressed: () {
          setState(() {
            if (stepperType == StepperType.vertical) {
              stepperType = StepperType.horizontal;
            } else {
              stepperType = StepperType.vertical;
            }
          });
        },
      ),
    );
  }
}
