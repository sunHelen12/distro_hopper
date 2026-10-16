import 'package:distro_hopper/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('O app abre sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const DistroHopper());

    expect(find.byType(DistroHopper), findsOneWidget);
  });
}