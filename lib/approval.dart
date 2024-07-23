import 'package:flutter/material.dart';
import 'Invoiceapproval.dart';
import 'bankbook.dart';
import 'cashbook.dart';
import 'leaveapproval.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: dashboard(), // Set Dashboard as the initial screen
    );
  }
}


class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  final List<Map<String, String>> items = [
    {'title': 'Cash Book', 'icon': 'image/cashbook.png'},
    {'title': 'Bank Book', 'icon': 'image/bankbook.png'},
    {'title': 'Invoice', 'icon': 'image/invoice.png'},
    {'title': 'Leave', 'icon': 'image/leave.png'},
  ];

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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => dashboard()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0), // Align text more to the left
          child: Text(
            'Approval',
            style: TextStyle(
              color: Color.fromARGB(255, 59, 48, 32),
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: false, // Align title to the left
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'image/background.png', // Use the provided background image path
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: 100), // Adjust the height for spacing
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      SizedBox(height: 20), // Space between top and first button
                      ...items.map((item) => buildMenuItem(context, item['title']!, item['icon']!)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, String title, String iconPath) {
    return GestureDetector(
      onTap: () {
        // Navigate to different screens based on the item clicked
        switch (title) {
          case 'Cash Book':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CashBookApprovalPage()),
            );
            break;
          case 'Bank Book':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Bankbook()),
            );
            break;
          case 'Invoice':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Invoiceapproval()),
            );
            break;
          case 'Leave':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LeaveApprovalPage()),
            );
            break;
          default:
            print('Clicked on $title');
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.15, // 15% of screen height
        decoration: BoxDecoration(
          color: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 40, width: 40),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Color.fromARGB(255, 248, 211, 146),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
