import 'package:flutter/material.dart';

class StepperForm extends StatefulWidget {
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int currentStep = 0;
  String _name = '', _phone = '', _email = '', _password = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKeys =
      List<GlobalKey<FormState>>.generate(4, (index) => GlobalKey<FormState>());
  StepperType stepperType = StepperType.vertical;
  List<Step> steps;
  bool nameError = true, phoneError = true, emailError = true, pwdError = true;

  bool inputValid() {
    if (nameError || phoneError || emailError || pwdError) {
      return false;
    }
    return true;
  }

  void submit() {
    if (!inputValid()) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Your Input is Invalid')),
      );
      return;
    }
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Your Input'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: $_name'),
            Text('Phone: $_phone'),
            Text('Email: $_email'),
            Text('Password: $_password'),
          ],
        ),
      ),
    );
  }

  List<Step> makeSteps() {
    steps = [
      Step(
        title: stepperType == StepperType.vertical
            ? Text('Your Name')
            : Text(currentStep == 0 ? 'Your Name' : ''),
        isActive: true,
        content: Form(
          key: formKeys[0],
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  _name = value;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 2) {
                    nameError = true;
                    return 'Name error';
                  }
                  nameError = false;
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: stepperType == StepperType.vertical
            ? Text('Your Phone')
            : Text(currentStep == 1 ? 'Your Phone' : ''),
        isActive: true,
        content: Form(
          key: formKeys[1],
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  _phone = value;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 11) {
                    phoneError = true;
                    return 'Phone error';
                  }
                  phoneError = false;
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: stepperType == StepperType.vertical
            ? Text('Your Email')
            : Text(currentStep == 2 ? 'Your Email' : ''),
        isActive: true,
        content: Form(
          key: formKeys[2],
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  _email = value;
                },
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    emailError = true;
                    return 'Email error';
                  }
                  emailError = false;
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: stepperType == StepperType.vertical
            ? Text('Your Password')
            : Text(currentStep == 3 ? 'Your Password' : ''),
        isActive: true,
        content: Form(
          key: formKeys[3],
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    pwdError = true;
                    return 'Password error';
                  }
                  pwdError = false;
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Stepper Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Stepper(
                steps: makeSteps(),
                currentStep: currentStep,
                type: stepperType,
                onStepTapped: (int index) {
                  setState(() => currentStep = index);
                },
                onStepContinue: () {
                  if (!formKeys[currentStep].currentState.validate()) {
                    return;
                  }

                  formKeys[currentStep].currentState.save();

                  setState(() {
                    if (currentStep < steps.length - 1) {
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
              ),
            ),
            Divider(color: Colors.black45),
            RaisedButton(
              child: Text('REGISTER'),
              onPressed: submit,
              color: Colors.deepPurple,
              textColor: Colors.white,
            ),
          ],
        ),
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
