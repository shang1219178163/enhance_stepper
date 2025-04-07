//
//  HomePage.dart
//  enhance_stepper
//
//  Created by shang on 2024/4/16 18:24.
//  Copyright © 2024/4/16 shang. All rights reserved.
//

import 'package:ddlog/ddlog.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int groupValue = 0;

  StepperType _type = StepperType.horizontal;

  List<Tuple2> tuples = [
    Tuple2(
      Icons.directions_bike,
      StepState.indexed,
    ),
    Tuple2(
      Icons.directions_bus,
      StepState.editing,
    ),
    Tuple2(
      Icons.directions_railway,
      StepState.complete,
    ),
    Tuple2(
      Icons.directions_boat,
      StepState.disabled,
    ),
    // Tuple2(Icons.directions_car, StepState.error, ),
  ];

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () {
              // DLog.d("change");
              _type = _type == StepperType.vertical ? StepperType.horizontal : StepperType.vertical;
              setState(() {});
            },
            child: Icon(
              Icons.change_circle_outlined,
              color: Colors.white,
            ),
          ),
        ],
        bottom: buildPreferredSize(),
      ),
      body: groupValue == 0 ? buildStepper() : buildStepperCustom(),
      // body: buildStepperCustom(context),
    );
  }

  PreferredSizeWidget buildPreferredSize() {
    return PreferredSize(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 24),
              Expanded(
                child: CupertinoSegmentedControl(
                  children: const <int, Widget>{
                    0: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Stepper',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    1: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'enhance_stepper',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  },
                  groupValue: groupValue,
                  onValueChanged: (value) {
                    // DLog.d(value.toString());
                    groupValue = int.parse("$value");
                    setState(() {});
                  },
                  borderColor: Colors.white,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.blue,
                ),
              ),
              SizedBox(width: 24),
            ],
          ),
        ),
        preferredSize: Size(double.infinity, 48));
  }

  void go(int index) {
    if (index == -1 && _index <= 0) {
      DLog.d("it's first Step!");
      return;
    }

    if (index == 1 && _index >= tuples.length - 1) {
      DLog.d("it's last Step!");
      return;
    }
    _index += index;
    setState(() {});
  }

  Widget buildStepper() {
    return Stepper(
        type: _type,
        currentStep: _index,
        physics: ClampingScrollPhysics(),
        steps: tuples
            .map((e) => Step(
                  state: StepState.values[tuples.indexOf(e)],
                  isActive: _index == tuples.indexOf(e),
                  title: Text("step ${tuples.indexOf(e)}"),
                  subtitle: Text(
                    "${e.item2.toString().split(".").last}",
                  ),
                  content: Text("Content for Step ${tuples.indexOf(e)}"),
                ))
            .toList(),
        onStepCancel: () {
          go(-1);
        },
        onStepContinue: () {
          go(1);
        },
        onStepTapped: (index) {
          DLog.d(index);
          _index = index;
          setState(() {});
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text("Next"),
              ),
              SizedBox(
                width: 8,
              ),
              TextButton(
                onPressed: details.onStepCancel,
                child: Text("Back"),
              ),
            ],
          );
        });
  }

  Widget buildStepperCustom() {
    return EnhanceStepper(
        // stepIconSize: 60,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: _index,
        physics: ClampingScrollPhysics(),
        steps: tuples
            .map((e) => EnhanceStep(
                  // icon: Icon(
                  //   e.item1,
                  //   // Icons.add,
                  //   color: Colors.blue,
                  //   size: 60,
                  // ),
                  state: StepState.values[tuples.indexOf(e)],
                  isActive: _index == tuples.indexOf(e),
                  title: Text("step ${tuples.indexOf(e)}"),
                  subtitle: Text(
                    "${e.item2.toString().split(".").last}",
                  ),
                  content: Text("Content for Step ${tuples.indexOf(e)}"),
                ))
            .toList(),
        onStepCancel: () {
          go(-1);
        },
        onStepContinue: () {
          go(1);
        },
        onStepTapped: (index) {
          DLog.d(index);
          _index = index;
          setState(() {});
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text("Next"),
              ),
              SizedBox(
                width: 8,
              ),
              TextButton(
                onPressed: details.onStepCancel,
                child: Text("Back"),
              ),
            ],
          );
        });
  }
}
