import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/resume.pdf'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Resume'),
        ),
        body: Center(
          child: PdfView(
            controller: pdfController,
            // ),
          ),
        )
        // ),
        );
  }
}
