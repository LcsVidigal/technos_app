import 'package:technos_app/src/home_page/home_page_model.dart';

class HomePageController {
  List<Servico> listaDeServicosConvencionais = [
    Servico(letra: 'A', categoria: 'Convencional', titulo: 'Preparação da Tige'),
    Servico(letra: 'B', categoria: 'Convencional', titulo: 'Gravação do Fundo'),
    Servico(letra: 'C', categoria: 'Convencional', titulo: 'Limpeza da Caixa'),
    Servico(letra: 'D', categoria: 'Convencional', titulo: 'Colocação da Tige no Maquinismo'),
    Servico(letra: 'E', categoria: 'Convencional', titulo: 'Montagem do Mostrador + Maquinismo'),
    Servico(letra: 'F', categoria: 'Convencional', titulo: 'Colocação de Ponteiro'),
    Servico(letra: 'G', categoria: 'Convencional', titulo: 'Encaixamento'),
    Servico(letra: 'H', categoria: 'Convencional', titulo: 'Montagem da Tige'),
    Servico(letra: 'I', categoria: 'Convencional', titulo: 'Revisão 1'),
    Servico(letra: 'K', categoria: 'Convencional', titulo: 'Fechamento do Fundo'),
    Servico(letra: 'L', categoria: 'Convencional', titulo: 'WPC (Teste Prova d\'água)'),
    Servico(letra: 'M', categoria: 'Convencional', titulo: 'Revisão 2'),
  ];

  List<Servico> listaDeServicosDigitais = [
    Servico(letra: 'B', categoria: 'Digital', titulo: 'Gravação do Fundo'),
    Servico(letra: 'C', categoria: 'Digital', titulo: 'Limpeza da Caixa'),
    Servico(letra: 'D', categoria: 'Digital', titulo: 'Preparação do Módulo'),
    Servico(letra: 'E', categoria: 'Digital', titulo: 'Montagem do Mostrador + Módulo'),
    Servico(letra: 'G', categoria: 'Digital', titulo: 'Encaixamento'),
    Servico(letra: 'I', categoria: 'Digital', titulo: 'Revisão 1'),
    Servico(letra: 'J', categoria: 'Digital', titulo: 'Colocação do O\'ring'),
    Servico(letra: 'K', categoria: 'Digital', titulo: 'Fechamento do Fundo'),
    Servico(letra: 'L', categoria: 'Digital', titulo: 'WPC (Teste Prova d\'água)'),
    Servico(letra: 'M', categoria: 'Digital', titulo: 'Revisão 2'),
  ];


}