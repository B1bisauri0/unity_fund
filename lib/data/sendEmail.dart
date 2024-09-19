import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  final String apiUrl = 'http://127.0.0.1:8000/send-email/';

  EmailService();

  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'to': to,
        'subject': subject,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }
}
