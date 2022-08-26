import 'package:flutter/material.dart';
import 'package:technos_app/src/diretorio_page/diretorio_page.dart';
import 'package:technos_app/src/home_page/home_page_model.dart';
import 'package:technos_app/src/home_page/home_page_view.dart';
import 'package:technos_app/src/instrucao/instrucao_view.dart';
import 'package:technos_app/src/instrucao/visualizar_pdf_view.dart';
import 'package:technos_app/src/instrucao/play_video.dart';

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: const Color(0XFFdc0c22),
        fontFamily: 'Arial',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Arial'),
        ),
      ),
      onGenerateRoute: (RouteSettings routeSettings){
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context){
            switch (routeSettings.name) {
              case HomePage.routeName:
                return const HomePage();
              case InstrucaoPage.routeName:
                return const InstrucaoPage();
              case VisualizarPdf.routeName:
                return VisualizarPdf(servico: routeSettings.arguments as Servico);
              case PlayVideo.routeName:
                return PlayVideo(servico: routeSettings.arguments as Servico);
              case DiretorioPage.routeName:
                return const DiretorioPage();
              default: 
                return const HomePage();
            }
          }
        );
      },
    );
  }

}
