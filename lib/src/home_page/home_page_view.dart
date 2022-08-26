import 'package:flutter/material.dart';
import 'package:technos_app/src/diretorio_page/diretorio_page.dart';
import 'package:technos_app/src/home_page/home_page_controller.dart';
import 'package:technos_app/src/home_page/home_page_model.dart';
import 'package:technos_app/src/instrucao/instrucao_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _homePageController = HomePageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 130,
            color:  Colors.black,
            child: SizedBox(
              width: 100,
              height: 50,
              child: Image.asset(
                'assets/images/logo_technos.png', 
                fit: BoxFit.none
              ),
            ),
          ),

          const SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.10),
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, DiretorioPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Selecionar diretório', style: TextStyle(fontSize: 20.0),),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
              child: ListView(
                children: [
                  _topLabel('1. Digital'),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width < 550 ? 2 : 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                    ), 
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20.0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _homePageController.listaDeServicosConvencionais.length,
                    itemBuilder: (BuildContext context, int index){
                      return _botaoServico(_homePageController.listaDeServicosConvencionais[index]);
                    },
                  ),

                  const SizedBox(height: 80),
                  _topLabel('2. Convencional'),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                    ), 
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20.0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _homePageController.listaDeServicosConvencionais.length,
                    itemBuilder: (BuildContext context, int index){
                      return _botaoServico(_homePageController.listaDeServicosConvencionais[index]);
                    },
                  ),
                  const SizedBox(height: 15.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _botaoServico(Servico servico){
    return ElevatedButton(
      onPressed: () { 
        Navigator.pushNamed(context, InstrucaoPage.routeName, arguments: servico);
       },
       style: ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        servico.titulo, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }

  _topLabel(String text){
    return Container(
      width: double.infinity,
      height: 60,
      color: const Color.fromARGB(255, 79, 80, 81),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.white)))
    );
  }
}