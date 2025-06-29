// Define o modelo de dados para um exercício
class Exercicio{
  final String nome;
  final int series;
  final int repeticoes;
  final double carga;


  // Construtor que recebe todos os dados obrigatórios
  Exercicio({
    required this.nome,
    required this.series,
    required this.repeticoes,
    required this.carga,
  });

  //METODO TO STRING
  /*O que você quer	Como escreve
  Apenas uma variável simples?	$variavel
  Variável + texto colado?	${variavel}texto
  Uma operação ou método?	${variavel + 1} ou ${nome.length} */
  @override
  String toString(){
    return '$nome - $series x $repeticoes | ${carga}kg';
  }
}