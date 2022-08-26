import 'package:flutter/material.dart';
import 'package:technos_app/src/constants.dart';
import 'package:technos_app/src/home_page/home_page_model.dart';
import 'package:technos_app/src/instrucao/visualizar_pdf_view.dart';
import 'package:technos_app/src/instrucao/play_video.dart';

class InstrucaoPage extends StatelessWidget {
  const InstrucaoPage({Key? key}) : super(key: key);

  static const routeName = '/InstrucaoPage';

  @override
  Widget build(BuildContext context) {
    Servico servico = ModalRoute.of(context)!.settings.arguments as Servico;
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          'Instrução', 
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)))
                    ),
                    const SizedBox(
                      width: 48,
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),
            Text(servico.titulo, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20.0),
            if(_size.width > 550)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _instrucao(
                    'Instrução de trabalho', 
                    Icons.picture_as_pdf,
                    VisualizarPdf.routeName,
                    context,
                    servico
                  ),

                  _instrucao(
                    'Vídeo', 
                    Icons.smart_display_outlined,
                    PlayVideo.routeName,
                    context,
                    servico
                  ),
                ],
              ),

            if(_size.width < 550)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _instrucao(
                    'Instrução de trabalho', 
                    Icons.picture_as_pdf,
                    VisualizarPdf.routeName,
                    context,
                    servico
                  ),
                  const SizedBox(height: 100,),
                  _instrucao(
                    'Vídeo', 
                    Icons.smart_display_outlined,
                    PlayVideo.routeName,
                    context,
                    servico
                  ),
                ],
              ),
            const SizedBox(height: 30)
          ]
        ),
      ),
    );
  }

  _instrucao(String titulo, IconData icone, String nextRoute, BuildContext context, Servico servico){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, nextRoute, arguments: servico);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: Icon(
              icone,
              size: 90.0,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: -15,
            child: Container(
              width: 300,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              ),
              child: Center(
                child: Text(titulo, style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}