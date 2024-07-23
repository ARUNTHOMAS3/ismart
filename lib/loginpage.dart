import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sample_project_2/dashboard.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _obscureText = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _businessLocationController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  bool _userNameError = false;
  bool _passwordError = false;
  bool _locationError = false;
  bool _companyError = false;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _userNameController.dispose();
    _businessLocationController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _userNameError = _userNameController.text.isEmpty;
      _passwordError = _passwordController.text.isEmpty;
      _locationError = _businessLocationController.text.isEmpty;
      _companyError = _companyNameController.text.isEmpty;
    });

    if (!_userNameError &&
        !_passwordError &&
        !_locationError &&
        !_companyError) {
      String userName = _userNameController.text.trim();
      String password = _passwordController.text.trim();
      String businessLocation = _businessLocationController.text.trim();
      String companyName = _companyNameController.text.trim();

      print("Username: $userName");
      print("Password: $password");
      print("Business Location: $businessLocation");
      print("Company Name: $companyName");
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => dashboard()),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF394020), Color(0xFF394020)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Container(
                        height: constraints.maxHeight * 0.30,
                        child: Lottie.asset('image/welcome.json'),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      _buildTextField(
                          'User Name', Icons.person, constraints, _userNameController, _userNameError),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildPasswordField(constraints),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildTextField(
                          'Business Location', Icons.location_on, constraints, _businessLocationController, _locationError),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      _buildTextField(
                          'Company Name', Icons.business, constraints, _companyNameController, _companyError),
                      SizedBox(height: constraints.maxHeight * 0.04),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0FA577),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, BoxConstraints constraints, TextEditingController controller, bool isError) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFBCAC8F),
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.brown),
        ),
        errorText: isError ? 'Field cannot be empty' : null,
      ),
    );
  }

  Widget _buildPasswordField(BoxConstraints constraints) {
    return TextField(
      controller: _passwordController,
      obscureText: _obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFBCAC8F),
        prefixIcon: Icon(Icons.lock, color: Colors.black),
        suffixIcon: GestureDetector(
          onTap: _toggleObscureText,
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.brown),
        ),
        errorText: _passwordError ? 'Field cannot be empty' : null,
      ),
    );
  }
}