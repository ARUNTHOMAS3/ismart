import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SupportRequestPage extends StatefulWidget {
  @override
  _SupportRequestPageState createState() => _SupportRequestPageState();
}

class _SupportRequestPageState extends State<SupportRequestPage> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool _submitClicked = false;

  @override
  void dispose() {
    _companyController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _submitClicked = true;
      });

      // Simulate email sending delay
      Future.delayed(Duration(seconds: 5), () {
        Fluttertoast.showToast(
          msg: "Your service request has been successfully submitted. Our support team will contact you soon.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFF394020),
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Clear the form
        _companyController.clear();
        _usernameController.clear();
        _emailController.clear();
        _phoneController.clear();

        setState(() {
          _isSubmitting = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Support Request'),
      ),
      body: Container(
        color: Color(0xFF394020), // Dark green background color
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250, // Increased width
                  height: 250, // Increased height
                  child: Lottie.asset(
                    'image/help1.json', // Replace with your Lottie animation asset
                    fit: BoxFit.cover,
                    repeat: false, // Animation will not loop
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(_companyController, 'Company Name'),
                SizedBox(height: 10),
                _buildTextField(_usernameController, 'User Name'),
                SizedBox(height: 10),
                _buildTextField(
                  _emailController,
                  'Registered email ID',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                _buildTextField(
                  _phoneController,
                  'Register Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitRequest,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF5EC3A7)), // Button color
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: _submitClicked ? Colors.green : Colors.transparent,
                        width: 2.0,
                      ),
                    )),
                  ),
                  child: _isSubmitting
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true, // Enable background color
        fillColor: Color(0xFFD4B18F), // Set background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0), // Oval shape
          borderSide: BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0), // Oval shape
          borderSide: BorderSide(
            color: Color(0xFF5EC3A7), // Focused border color
            width: 2.0,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      keyboardType: keyboardType,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
    );
  }
}
