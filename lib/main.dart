import 'package:flutter/material.dart';
import 'models/exercicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Treino',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}



// Define a tela principal como um StatefulWidget (porque seu conteúdo pode mudar)
// Isso significa que vamos ter variáveis que podem ser atualizadas, como a lista de exercícios
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState(); // Associa esse widget a um objeto de estado (_HomePageState)
}

// Esta classe representa o "estado" da HomePage — é onde controlamos os dados que mudam e redesenhamos a tela
// Ela herda de State<HomePage>, que é a classe base para armazenar e manipular estado de um StatefulWidget
class _HomePageState extends State<HomePage> {
  // Lista de exercícios que será exibida na tela e manipulada pelo usuário
  // É uma lista dinâmica de objetos do tipo Exercicio
  final List<Exercicio> exercicios = [];

  // Esses são os controladores dos campos de texto
  // Eles permitem acessar o texto que o usuário digitou
  final nomeController = TextEditingController(); //nome do exericio
  final seriesController = TextEditingController(); // Número de séries
  final repeticoesController = TextEditingController(); // Repetições por série
  final cargaController = TextEditingController(); // Carga usada (kg)

// Função chamada quando o usuário clica no botão "Adicionar Exercício"
// Ela coleta os dados digitados, valida e adiciona à lista
 void adicionarExercicio() {
  // Lê o texto do campo nome
    final nome = nomeController.text;

    // Converte o texto digitado em número inteiro (ou retorna 0 se for inválido)
    final series = int.tryParse(seriesController.text) ?? 0;

    // Converte o texto em número inteiro (ou 0)
    final repeticoes = int.tryParse(repeticoesController.text) ?? 0;

    // Converte o texto em número com decimal (ou 0.0)
    final carga = double.tryParse(cargaController.text) ?? 0.0;

    // Validação: se qualquer campo estiver vazio ou inválido, a função retorna e não adiciona
    // Operador OU
    if (nome.isEmpty || series <= 0 || repeticoes <= 0 || carga <= 0) return;

        // setState avisa o Flutter que o estado mudou e a tela precisa ser redesenhada
    setState(() {
      // Adiciona um novo objeto Exercicio à lista
      exercicios.add(
        Exercicio(
          nome: nome,
          series: series,
          repeticoes: repeticoes,
          carga: carga,
        ),
      );
    });

     // Limpa todos os campos depois de adicionar o exercício
    nomeController.clear();
    seriesController.clear();
    repeticoesController.clear();
    cargaController.clear();
  }

  // Função que constrói (desenha) a interface visual da tela
   @override
  Widget build(BuildContext context) {
    return Scaffold( // Widget básico que fornece estrutura visual: app bar, corpo, etc.
      appBar: AppBar( // Barra superior do app
        title: Text('Registrar Treino'), // Título que aparece na barra
      ),
      body: Padding( // Adiciona espaçamento interno nas laterais da tela
        padding: EdgeInsets.all(16),
        child: Column( // Organiza os widgets em coluna (verticalmente)
          children: [
            // Campo de entrada de texto para o nome do exercício
            TextField(
              controller: nomeController, // Controlador para acessar o texto digitado
              decoration: InputDecoration(labelText: 'Nome do Exercício'), // Rótulo do campo
            ),
          // Campo para número de séries
            TextField(
              controller: seriesController,
              decoration: InputDecoration(labelText: 'Séries'),
              keyboardType: TextInputType.number, // Força o teclado numérico no celular
            ),

            // Campo para número de repetições
            TextField(
              controller: repeticoesController,
              decoration: InputDecoration(labelText: 'Repetições'),
              keyboardType: TextInputType.number,
            ),

            // Campo para carga usada no exercício
            TextField(
              controller: cargaController,
              decoration: InputDecoration(labelText: 'Carga (kg)'),
              keyboardType: TextInputType.number,
            ),

            // Espaço visual entre o campo e o botão
            SizedBox(height: 12),

            // Botão para adicionar o exercício
            ElevatedButton(
              onPressed: adicionarExercicio, // Quando clicado, chama a função
              child: Text('Adicionar Exercício'), // Texto dentro do botão
            ),

            // Espaço entre botão e a lista
            SizedBox(height: 16),

            // Lista que ocupa todo o espaço restante da tela
            Expanded(
              child: ListView.builder( // Cria uma lista dinâmica de widgets
                itemCount: exercicios.length, // Número de exercícios na lista
                itemBuilder: (context, index) {
                  final e = exercicios[index]; // Pega o exercício da posição atual

                  return ListTile( // Widget pronto para mostrar título e subtítulo
                    title: Text(e.nome), // Título = nome do exercício
                    subtitle: Text('${e.series}x${e.repeticoes} | ${e.carga}kg'), // Subtítulo com detalhes
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


