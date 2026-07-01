import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:sample_app/main.dart' as app;

void main() {
  patrolTest('matches maestro login flow', ($) async {
    app.main();
    await $.pumpAndSettle();

    await $('Maestro Sample').tap();
    // await $.pumpAndSettle();

    // await $(#username_text_form_field).enterText('demo');
    await $.tester.enterText(
      find.bySemanticsIdentifier('username_text_form_field'),
      'demo',
    );
    // await $.pumpAndSettle();

    // await $(#password_text_form_field).enterText('password');
    await $.tester.enterText(
      find.bySemanticsIdentifier('password_text_form_field'),
      'password',
    );
    // await $.pumpAndSettle();

    await $('Login').tap();
    await $.pumpAndSettle();

    await $('Maestro TODO List').waitUntilVisible();
    // expect($('Maestro TODO List'), findsOneWidget);

    // await $(#back_button).tap();
    await $.tester.tap(
      find.bySemanticsIdentifier('back_button_in_todo_list_screen'),
    );

    await $('Maestro Login').waitUntilVisible();
    // await $.pumpAndSettle();

    // await $.pumpAndSettle();
    expect(
      find.bySemanticsIdentifier('username_text_form_field'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsIdentifier('password_text_form_field'),
      findsOneWidget,
    );

    // await $(#back_button).tap();
    await $.tester.tap(find.bySemanticsIdentifier('back_button'));

    await $('Demo Pages').waitUntilVisible();
    expect($('Demo Pages'), findsOneWidget);
  });
}
