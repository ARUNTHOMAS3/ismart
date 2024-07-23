import 'package:flutter/material.dart';

class UrlPage extends StatefulWidget {
  @override
  _UrlPageState createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final TextEditingController _urlController = TextEditingController();
  String _errorMessage = '';

  void _verifyUrl() {
    setState(() {
      if (_urlController.text.startsWith('www.')) {
        _errorMessage = 'URL is valid';
      } else {
        _errorMessage = 'URL must start with "www."';
      }
      Navigator.pushNamed(context, '/loginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF394020), // Background color
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'image/url.png', // Replace with your URL image asset
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        hintText: 'Enter a Valid URL',
                        filled: true,
                        fillColor: Color(0xFFD4B18F), // Text box color
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.0), // Adjust padding as needed
                          child: Image.asset(
                            'image/enter.png', // Replace with your enter image asset
                            width: 20,
                            height: 20,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _verifyUrl,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0FA577)),
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/supportRequest');
                },
                child: Image.asset(
                  'image/help1.png', // Replace with your need help image asset
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
