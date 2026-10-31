import 'package:flutter_test/flutter_test.dart';
import 'package:gramtoon_code/main.dart';

void main() {
  testWidgets('Home screen shows the three sections', (tester) async {
    await tester.pumpWidget(const GramtoonApp());

    expect(find.text('Popular books'), findsOneWidget);
    expect(find.text('New releases'), findsOneWidget);
    expect(find.text('Book of the day'), findsOneWidget);
  });
}
