import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Bankbook(),
    );
  }
}

class Bankbook extends StatefulWidget {
  @override
  _CashBookApprovalPageState createState() => _CashBookApprovalPageState();
}

class _CashBookApprovalPageState extends State<Bankbook> {
  String? approvalStatus;
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController voucherNumberController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final String voucherDate = '2023-06-26';
  final String voucherAmount = '1000.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(35, 34, 31, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            'Bank Book Approval',
            style: TextStyle(
              color: Color.fromARGB(255, 59, 48, 32),
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'image/background.png', // Use the provided background image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    buildTextField(context, 'Book Name', bookNameController),
                    buildTextField(context, 'Voucher Number', voucherNumberController),
                    buildReadOnlyField(context, 'Voucher Date', voucherDate),
                    buildReadOnlyField(context, 'Voucher Amount', voucherAmount),
                    buildApprovalDropdown(context),
                    buildRemarksField(context, 'Remarks', remarksController),
                    SizedBox(height: 20),
                    buildSubmitButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(BuildContext context, String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildReadOnlyField(BuildContext context, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: TextEditingController(text: value),
          style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
            border: InputBorder.none,
          ),
          readOnly: true,
          enabled: false,
        ),
      ),
    );
  }

  Widget buildApprovalDropdown(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: approvalStatus,
                hint: Text(
                  'Approve / Reject',
                  style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
                ),
                dropdownColor: Color.fromRGBO(35, 34, 31, 1),
                style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
                onChanged: (String? newValue) {
                  setState(() {
                    approvalStatus = newValue;
                  });
                },
                items: <String>['Approve', 'Reject']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRemarksField(BuildContext context, String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF0FA577).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Handle submit button press
          print('Approval Status: $approvalStatus');
          print('Book Name: ${bookNameController.text}');
          print('Voucher Number: ${voucherNumberController.text}');
          print('Remarks: ${remarksController.text}');
        },
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
