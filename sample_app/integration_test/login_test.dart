import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sample_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('matches maestro login flow', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Maestro Sample'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.bySemanticsIdentifier('username_text_form_field'),
      'demo',
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.bySemanticsIdentifier('password_text_form_field'),
      'password',
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Maestro TODO List'), findsOneWidget);

    await tester.tap(find.bySemanticsIdentifier('back_button').first);
    await tester.pumpAndSettle();
    expect(
      find.bySemanticsIdentifier('username_text_form_field'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsIdentifier('password_text_form_field'),
      findsOneWidget,
    );

    await tester.tap(find.bySemanticsIdentifier('back_button').first);
    await tester.pumpAndSettle();
    expect(find.text('Demo Pages'), findsOneWidget);
  });
}
