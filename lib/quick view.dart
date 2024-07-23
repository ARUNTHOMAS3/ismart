import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuickviewScreen(),
    );
  }
}

class QuickviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuickViewPage(),
    );
  }
}

class QuickViewPage extends StatefulWidget {
  @override
  _QuickViewPageState createState() => _QuickViewPageState();
}

class _QuickViewPageState extends State<QuickViewPage> {
  final List<Map<String, String>> items = [
    {'title': 'Man-day', 'icon': 'image/man-day.png'},
    {'title': 'Production', 'icon': 'image/production.png'},
    {'title': 'COP', 'icon': 'image/cop.png'},
    {'title': 'Major Purchase', 'icon': 'image/majorpurchase.png'},
    {'title': 'Major Consumption', 'icon': 'image/majorconsumption.png'},
    {'title': 'Sales', 'icon': 'image/sales.png'},
    {'title': 'Absents', 'icon': 'image/absents.png'},
    {
      'title': 'Outstanding Liabilities',
      'icon': 'image/outstandingliabilities.png'
    },
    {'title': '3M', 'icon': 'image/3M.png'},
    {'title': 'Budget Vs Actual', 'icon': 'image/budgetvsactual.png'},
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
      backgroundColor: Color.fromRGBO(35, 34, 31, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous screen
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            'Quick View',
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
              'image/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: 100),
                Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      SizedBox(height: 20),
                      ...filteredItems
                          .map((item) =>
                              buildMenuItem(context, item['title']!, item['icon']!))
                          .toList(),
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
        // Handle item click here
        print('Clicked on $title');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.15,
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
