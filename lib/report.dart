import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:sample_project_2/dashboard.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? reportName;
  String? reportPeriod;
  final TextEditingController reportNameController = TextEditingController();

  final List<String> periods = ['Daily', 'Fortnightly', 'Monthly'];

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
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            'Reports',
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
              'image/background.png', // Use your background image path
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
                    buildTextField(context, 'Report Name', reportNameController),
                    buildPeriodDropdown(context),
                    SizedBox(height: 20),
                    buildGenerateButtons(context),
                    SizedBox(height: 20),
                    buildExportButton(context),
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

  Widget buildPeriodDropdown(BuildContext context) {
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
                value: reportPeriod,
                hint: Text(
                  'Report Period',
                  style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
                ),
                dropdownColor: Color.fromRGBO(35, 34, 31, 1),
                style: TextStyle(color: Color.fromARGB(255, 248, 211, 146)),
                onChanged: (String? newValue) {
                  setState(() {
                    reportPeriod = newValue;
                  });
                },
                items: periods.map<DropdownMenuItem<String>>((String value) {
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

  Widget buildGenerateButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildGenerateButton(context, 'Generate Data', () {
          // Handle generate data
        }),
        buildGenerateButton(context, 'Generate Chart', () {
          // Handle generate chart
        }),
      ],
    );
  }

  Widget buildGenerateButton(BuildContext context, String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(35, 34, 31, 1).withOpacity(0.8),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 248, 211, 146),
        ),
      ),
    );
  }

  Widget buildExportButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await generateAndDownloadPDF();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0FA577).withOpacity(0.8),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'EXPORT',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> generateAndDownloadPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Report Data'),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/report.pdf');
    await file.writeAsBytes(await pdf.save());

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'report.pdf',
    );
  }
}
