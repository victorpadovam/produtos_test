import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produtos_test/app/di/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:produtos_test/core/app_localizations.dart';
import 'package:produtos_test/features/login/presentation/pages/login_page.dart';

// Testa componentes isolado
void main() {
  setUpAll(() async {
    await configureDependencies();
  });

  testWidgets(
    'renderizar login page',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: LoginPage(),
        ),
      );

      final context = tester.element(
        find.byType(LoginPage),
      );

      expect(
        find.text(context.l10n.email),
        findsOneWidget,
      );

      expect(
        find.text(context.l10n.password),
        findsOneWidget,
      );

      expect(
        find.text(context.l10n.login),
        findsOneWidget,
      );
    },
  );
}
