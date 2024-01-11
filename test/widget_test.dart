// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:dodo_mobile/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

// import 'dart:convert';

// import 'package:http/http.dart' as http;

// void main() async {
//   String accessToken =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjIsIm5hbWUiOiJhaG1hZCBzaG9maSIsImVtYWlsIjoiYWhtYWRzaG9maWhhc2lidWFuQGdtYWlsLmNvbSIsImlhdCI6MTY1Njk1MTM4N30.HhXJ9n4O9Qc_Gs-b9ceXXF9oB9Tzo4GIFdd02CJ77zQ";

//   try {
//     final url = "https://dodo-api-expressjs.herokuapp.com";
//     var response = await http.get(Uri.parse(url + "/child/get-user"),
//         headers: {'Authorization': 'Bearer $accessToken'});

//     if (response.statusCode == 200) {
//       print(json.decode(response.body)["data"]);
//     } else {
//       print("DATA TIDAK BERHASIL DI AMBIL");
//     }
//   } catch (err) {
//     print(err);
//   }
// }
