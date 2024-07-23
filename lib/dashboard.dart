import 'package:flutter/material.dart';
import 'quick view.dart';
import 'approval.dart';
import 'report.dart';


void main() {
  runApp(dashboard());
}

class dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(userName: 'GUEST'), // Replace with dynamic user name
    );
  }
}

class HomePage extends StatefulWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  Dashboard createState() => Dashboard();
}

class Dashboard extends State<HomePage> {
  final List<Map<String, String>> items = [
    {'title': 'Quick View', 'icon': 'image/quickview.png'},
    {'title': 'Approval', 'icon': 'image/approval.png'},
    {'title': 'Reports', 'icon': 'image/reports.png'},
    {'title': 'Tools', 'icon': 'image/tools.png'},
    {'title': 'Cash Book Balance', 'icon': 'image/cashbalance.png'},
    {'title': 'Bank Book Balance', 'icon': 'image/bankbalance.png'},
    {
      'title': 'Outstanding Liabilities',
      'icon': 'image/outstandingliabilities.png'
    },
    {
      'title': 'Outstanding Receivables',
      'icon': 'image/outstandingreceivables.png'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = items
        .where((item) =>
            item['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(35, 34, 31, 1), // Match the drawer color
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(180),
        ),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(35, 34, 31, 1).withOpacity(1),
            ),
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  accountName: Text(
                    widget.userName,
                    style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
                  ),
                  accountEmail: null,
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 111, 85, 34),
                    child: Text(
                      widget.userName.isNotEmpty ? widget.userName[0] : '?',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Color.fromARGB(255, 248, 211, 146),
                      ),
                    ),
                  ),
                ),
                Spacer(), // Pushes the ListTile to the bottom
                ListTile(
                  leading: Icon(Icons.logout,
                      color: Color.fromARGB(255, 111, 85, 34)),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
                  ),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 211, 146).withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.black),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'image/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                    height: 100), // Space for the status bar and search bar
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      SizedBox(
                          height:
                              30), // Space between search bar and first button
                      ...filteredItems.map((item) =>
                          buildMenuItem(context, item['title']!, item['icon']!))
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
        if (title == 'Quick View') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuickviewScreen()),
          );
        } else if (title == 'Approval') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApprovalPage()),
          );
        } else if (title == 'Reports') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportPage()),
          );
        } else {
          // Handle other menu item clicks
          print('Clicked on $title');
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        height:
            MediaQuery.of(context).size.height * 0.25, // 25% of screen height
        decoration: BoxDecoration(
          color: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 60, width: 60),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: Color.fromARGB(255, 248, 211, 146), fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}