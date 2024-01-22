import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFDDC3F5, <int, Color>{
          50: Color(0xFFDDC3F5),
          100: Color(0xFFDDC3F5),
          200: Color(0xFFDDC3F5),
          300: Color(0xFFDDC3F5),
          400: Color(0xFFDDC3F5),
          500: Color(0xFFDDC3F5),
          600: Color(0xFFDDC3F5),
          700: Color(0xFFDDC3F5),
          800: Color(0xFFDDC3F5),
          900: Color(0xFFDDC3F5),
        }),
        fontFamily: 'OpenSans',
      ),
      home: QuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  List<String> answers = [];
  bool showResults = false;
  int scorePomodoro = 0;

  void answerQuestion(String answer) {
    setState(() {
      answers.add(answer);

      if (questionIndex < questions.length - 1) {
        questionIndex++;
      } else {
        showResults = true;
        saveUserPreferences();
      }

      // Randomizar a ordem das respostas antes de exibi-las
      if (!showResults) {
        questions[questionIndex]['answers'].shuffle();
      }
    });
  }

  final List<Map<String, dynamic>> questions = [
    {
      'questionText': 'Como você geralmente organiza seus períodos de estudo?',
      'answers': [
        'Divido meu tempo em ciclos concentrados com pausas regulares. (Método Pomodoro)',
        'Crio esquemas visuais para compreender melhor o conteúdo. (Mapa Mental)',
        'Intercalei o estudo entre diferentes matérias para evitar monotonia. (Estudo Intercalado)',
        'Faço testes práticos e reviso com base em resultados. (Testes Práticos)',
      ],
    },
    {
      'questionText':
          'Qual é a sua abordagem ao revisar e consolidar informações?',
      'answers': [
        'Opto por períodos focados, seguidos por pausas curtas. (Método Pomodoro)',
        'Prefiro criar representações visuais para facilitar a compreensão. (Mapa Mental)',
        'Vario entre disciplinas para manter a mente engajada. (Estudo Intercalado)',
        'Realizo práticas como resolver exercícios e simulados. (Testes Práticos)',
      ],
    },
    {
      'questionText': 'Como você lida com a assimilação de novos conceitos?',
      'answers': [
        'Utilizo intervalos de foco intenso intercalados com descanso. (Método Pomodoro)',
        'Construo conexões visuais e mentais com mapas conceituais. (Mapa Mental)',
        'Alternância entre diferentes disciplinas para manter o interesse. (Estudo Intercalado)',
        'Reforço o aprendizado por meio de testes práticos. (Testes Práticos)',
      ],
    },
    {
      'questionText':
          'Qual estratégia você acha mais eficaz para avaliar seu conhecimento?',
      'answers': [
        'Avalio meu progresso com períodos cronometrados. (Método Pomodoro)',
        'Utilizo mapas mentais como uma ferramenta de revisão visual. (Mapa Mental)',
        'Vario entre disciplinas para uma abordagem mais completa. (Estudo Intercalado)',
        'Faço testes práticos e simulados para avaliar minha compreensão. (Testes Práticos)',
      ],
    }
  ];

  Future<void> saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('userAnswers', answers);
  }

  String calculateRecommendedMethodology() {
    Map<String, String> methodologyKeywords = {
      'Divido meu tempo em ciclos concentrados com pausas regulares. (Método Pomodoro)':
          'Pomodoro',
      'Crio esquemas visuais para compreender melhor o conteúdo. (Mapa Mental)':
          'Mapa Mental',
      'Intercalei o estudo entre diferentes matérias para evitar monotonia. (Estudo Intercalado)':
          'Estudo Intercalado',
      'Faço testes práticos e reviso com base em resultados. (Testes Práticos)':
          'Testes Práticos',
      'Opto por períodos focados, seguidos por pausas curtas. (Método Pomodoro)':
          'Pomodoro',
      'Prefiro criar representações visuais para facilitar a compreensão. (Mapa Mental)':
          'Mapa Mental',
      'Vario entre disciplinas para manter a mente engajada. (Estudo Intercalado)':
          'Estudo Intercalado',
      'Realizo práticas como resolver exercícios e simulados. (Testes Práticos)':
          'Testes Práticos',
      'Utilizo intervalos de foco intenso intercalados com descanso. (Método Pomodoro)':
          'Pomodoro',
      'Construo conexões visuais e mentais com mapas conceituais. (Mapa Mental)':
          'Mapa Mental',
      'Alternância entre diferentes disciplinas para manter o interesse. (Estudo Intercalado)':
          'Estudo Intercalado',
      'Reforço o aprendizado por meio de testes práticos. (Testes Práticos)':
          'Testes Práticos',
      'Avalio meu progresso com períodos cronometrados. (Método Pomodoro)':
          'Pomodoro',
      'Utilizo mapas mentais como uma ferramenta de revisão visual. (Mapa Mental)':
          'Mapa Mental',
      'Vario entre disciplinas para uma abordagem mais completa. (Estudo Intercalado)':
          'Estudo Intercalado',
      'Faço testes práticos e simulados para avaliar minha compreensão. (Testes Práticos)':
          'Testes Práticos',
    };

    Map<String, int> scores = {
      'Pomodoro': 0,
      'Mapa Mental': 0,
      'Estudo Intercalado': 0,
      'Testes Práticos': 0,
    };

    for (String answer in answers) {
      for (String keyword in methodologyKeywords.keys) {
        if (answer.contains(keyword)) {
          String methodology = methodologyKeywords[keyword]!;
          scores.update(methodology, (value) => value + 1);
        }
      }
    }

    int maxScore =
        scores.values.reduce((max, score) => max > score ? max : score);

    List<String> recommendedMethodologies =
        scores.keys.where((key) => scores[key] == maxScore).toList();

    print('Scores: $scores');
    print('Max Score: $maxScore');
    print('Recommended Methodologies: $recommendedMethodologies');

    return recommendedMethodologies.length == 1
        ? recommendedMethodologies.first
        : 'Indeciso';
  }

  String getMethodologyDescription(String methodology) {
    switch (methodology) {
      case 'Pomodoro':
        return 'A técnica Pomodoro é um método de gerenciamento de tempo que utiliza intervalos de trabalho focado, chamados "Pomodoros", seguidos por breves pausas. Essa abordagem visa melhorar a eficiência e manter alta a concentração ao dividir o trabalho em segmentos cronometrados.';
      case 'Mapa Mental':
        return 'O Mapa Mental é uma técnica que envolve a criação de diagramas visuais para organizar informações e auxiliar na compreensão de conceitos. Essa abordagem é útil para visualizar conexões entre ideias e facilitar a memorização.';
      case 'Estudo Intercalado':
        return 'O Estudo Intercalado é uma estratégia de aprendizado que envolve alternar entre diferentes matérias durante as sessões de estudo. Essa abordagem ajuda a evitar a monotonia, melhorando a retenção e o entendimento do conteúdo.';
      case 'Testes Práticos':
        return 'Os Testes Práticos são uma prática que envolve a realização de exercícios e avaliações práticas para reforçar o aprendizado. Essa abordagem é eficaz para verificar a compreensão do conteúdo e identificar áreas que precisam de revisão.';
      default:
        return 'Descrição não disponível';
    }
  }

  String getMethodologyTips(String methodology) {
    switch (methodology) {
      case 'Pomodoro':
        return '\n1. Configure um temporizador para períodos de trabalho de 25 minutos (um Pomodoro).\n2. Concentre-se intensamente na tarefa durante o Pomodoro, evitando distrações.\n3. Após cada Pomodoro, faça uma pausa curta de 5 minutos.\n4. Após completar quatro Pomodoros, faça uma pausa mais longa, de 15-30 minutos.\n5. Ajuste a duração dos Pomodoros e pausas conforme sua preferência e necessidades.';
      case 'Mapa Mental':
        return '\n1. Comece pelo centro do mapa mental, colocando o conceito principal.\n2. Use cores, imagens e palavras-chave para representar informações.\n3. Conecte ideias relacionadas com linhas ou ramificações.\n4. Mantenha o mapa mental claro e conciso para facilitar a compreensão.';
      case 'Estudo Intercalado':
        return '\n1. Divida seu tempo de estudo em blocos para diferentes matérias.\n2. Alterne entre os blocos de estudo, evitando longos períodos em uma única disciplina.\n3. Reserve intervalos curtos para descanso entre os blocos de estudo.\n4. Revise as informações periodicamente para reforçar a retenção.';
      case 'Testes Práticos':
        return '\n1. Realize exercícios práticos relacionados ao conteúdo estudado.\n2. Utilize simulados e testes para avaliar sua compreensão.\n3. Identifique áreas de dificuldade e concentre-se nelas durante a revisão.\n4. Analise os resultados dos testes para direcionar seus esforços de estudo.';
      default:
        return 'Dicas não disponíveis';
    }
  }

  void restartCallback() {
    setState(() {
      questionIndex = 0;
      answers = [];
      showResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recomenda Metodologias'),
        backgroundColor: Color(0xFFDDC3F5),
      ),
      body: showResults
          ? ResultsWidget(
              recommendedMethodology: calculateRecommendedMethodology(),
              methodologyDescription:
                  getMethodologyDescription(calculateRecommendedMethodology()),
              methodologyTips:
                  getMethodologyTips(calculateRecommendedMethodology()),
              restartCallback: restartCallback,
            )
          : QuestionWidget(
              questionText: questions[questionIndex]['questionText'],
              answers: questions[questionIndex]['answers'],
              answerCallback: answerQuestion,
            ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final String questionText;
  final List<String> answers;
  final Function answerCallback;

  QuestionWidget({
    required this.questionText,
    required this.answers,
    required this.answerCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, // Mudei a cor de fundo da pergunta
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            questionText,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'OpenSans',
              color: Colors.black, // Mudei a cor do texto para preto
            ),
            textAlign: TextAlign.justify, // Adicionei a justificação
          ),
        ),
        ...answers.map(
          (answer) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () => answerCallback(answer),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      answer,
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              Colors.black), // Mudei a cor do texto para preto
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ResultsWidget extends StatelessWidget {
  final String recommendedMethodology;
  final String methodologyDescription;
  final String methodologyTips;
  final VoidCallback restartCallback;

  ResultsWidget({
    required this.recommendedMethodology,
    required this.methodologyDescription,
    required this.methodologyTips,
    required this.restartCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Metodologia recomendada para você: $recommendedMethodology',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                    color: Colors.black, // Mudei a cor do texto para preto
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Descrição:',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    color: Colors.black, // Mudei a cor do texto para preto
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    methodologyDescription,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: Colors.black, // Mudei a cor do texto para preto
                    ),
                    textAlign: TextAlign.justify, // Adicionei a justificação
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Dicas práticas:',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    color: Colors.black, // Mudei a cor do texto para preto
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    methodologyTips,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: Colors.black, // Mudei a cor do texto para preto
                    ),
                    textAlign: TextAlign.justify, // Adicionei a justificação
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: restartCallback,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFDDC3F5), // Mudei a cor do botão
                    onPrimary: Colors.black, // Mudei a cor do texto para preto
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Reiniciar Teste'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
