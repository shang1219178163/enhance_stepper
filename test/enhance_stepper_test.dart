import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:enhance_stepper/enhance_stepper.dart';

void main() {

  testWidgets('Stepper horizontal title [HorizontalTitlePosition.bottom] and line [HorizontalLinePosition.top]', (WidgetTester tester) async {
    int index = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: EnhanceStepper(
            horizontalTitlePosition: HorizontalTitlePosition.bottom,
            horizontalLinePosition: HorizontalLinePosition.top,
            onStepTapped: (int i) {
              index = i;
            },
            steps: const <EnhanceStep>[
              EnhanceStep(
                title: Text('Step 1'),
                content: SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              EnhanceStep(
                title: Text('Step 2'),
                content: SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              EnhanceStep(
                title: Text('Step 3'),
                content: SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('Step 2'));
    expect(index, 1);
  });

  testWidgets('Stepper horizontal title [HorizontalTitlePosition.bottom] and line [HorizontalLinePosition.center]', (WidgetTester tester) async {
    int index = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: EnhanceStepper(
            horizontalTitlePosition: HorizontalTitlePosition.bottom,
            horizontalLinePosition: HorizontalLinePosition.center,
            onStepTapped: (int i) {
              index = i;
            },
            steps: const <EnhanceStep>[
              EnhanceStep(
                title: Text('Step 1'),
                content: SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              EnhanceStep(
                title: Text('Step 2'),
                content: SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              EnhanceStep(
                title: Text('Step 3'),
                content: SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('Step 2'));
    expect(index, 1);
  });
}