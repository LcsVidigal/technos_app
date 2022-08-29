import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technos_app/src/home_page/home_page_model.dart';

class VisualizarPdf extends StatefulWidget{
  const VisualizarPdf({Key? key, required Servico servico}) : _servico = servico, super(key: key);

  static const routeName = '/VisualizarPdf';
  final Servico _servico;

  @override
  State<VisualizarPdf> createState() => _VisualizarPdfState();
}

class _VisualizarPdfState extends State<VisualizarPdf> {
  bool _fileExists = false;
  late File _pdf;
  int? _pages;

  void _loadPdfFile(String titulo, String categoria) async {
    Permission.manageExternalStorage.request();

    final prefs = await SharedPreferences.getInstance();
    final String? technosDirectory = prefs.getString('technos_directory');
    _pdf  = File('$technosDirectory/$categoria/$titulo.pdf');

    _fileExists =  await _pdf.exists();
    
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    
    _loadPdfFile(widget._servico.titulo, widget._servico.categoria);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )
                  ),
                  const Expanded(
                    child: Center(child: 
                      Text(
                        'Instrução de Trabalho', 
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black)))
                  ),
                  const SizedBox(
                    width: 48,
                  )
                ],
              ),
            ),
          ),

        
          Expanded(
            child: !_fileExists
              ? const Center(child: Text('Arquivo não encontrado', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)))
              : PDFView(
              filePath: _pdf.path,
              autoSpacing: false,
              pageFling: true,
              onRender: (pages) {
                setState(() {
                  _pages = pages;
                });
              },
            ),
          ),
        ]
      )
    );
  }
}

