
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technos_app/src/constants.dart';

class DiretorioPage extends StatefulWidget {
  const DiretorioPage({Key? key}) : super(key: key);

  static const routeName = '/DiretorioPage';

  @override
  State<DiretorioPage> createState() => _DiretorioPageState();
}

class _DiretorioPageState extends State<DiretorioPage> {
  bool _isLoading = true;
  String? _directory;

  void _getDirectory() async {
    final prefs = await SharedPreferences.getInstance();
    _directory = prefs.getString('technos_directory');
    setState(() {
      _isLoading = false;
    });
  }


  @override
  void initState() {
    _getDirectory();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: Colors.black,
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
                      color: Colors.white,
                    )
                  ),
                  const Expanded(
                    child: Center(child: 
                      Text(
                        'Selecionar diretório', 
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)))
                  ),
                  const SizedBox(
                    width: 48,
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _isLoading
              ? const Center(child: CircularProgressIndicator())
            :
            Column(
              children: [
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: 'Diretório atual: ',
                    style: const TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      if(_directory == null)
                        const TextSpan(text: 'Nenhum diretório selecionado', style: TextStyle(color: Colors.red)),
                      if(_directory != null)
                        TextSpan(text: _directory, style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
              
          if(selectedDirectory != null){
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('technos_directory', selectedDirectory);
          }

          _getDirectory();
        },
        label: const Text('Alterar diretório', style: TextStyle(fontSize: 21.0),),
        icon: const Icon(Icons.folder_open),
        backgroundColor: primaryColor
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat

    );
  }
}