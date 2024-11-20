import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _sapIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _programController = TextEditingController();
  String _responseMessage = "";

  Future<void> sendData(String sapId, String name, String program) async {
    final url = Uri.parse("http://localhost:3000/sendData");

    try {
      final response = await http.post(url, headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sapId': sapId,
          'name': name,
          'program': program,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _responseMessage = responseData['message'];
        });
        print('Response from server: ${responseData['message']}');
        print('Received data: ${responseData['receivedData']}');
      } else {
        setState(() {
          _responseMessage = 'Failed to send data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('POST API (Assignment04)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sapIdController,
              decoration: InputDecoration(labelText: 'Enter SAP ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter Name'),
            ),
            TextField(
              controller: _programController,
              decoration: InputDecoration(labelText: 'Enter Program'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendData(
                  _sapIdController.text,
                  _nameController.text,
                  _programController.text,
                );
              },
              child: Text('Send Data'),
            ),
            SizedBox(height: 20),
            Text(
              _responseMessage,
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
