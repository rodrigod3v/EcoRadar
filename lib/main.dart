import 'package:flutter/material.dart';

void main() {
  runApp(EcoradarApp());
}

class EcoradarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecoradar',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ecoradar'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              'https://i.imgur.com/aErDdzK.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'Erro ao carregar a logo. Verifique a URL.',
                  style: TextStyle(color: Colors.red),
                );
              },
            ),
          ),
          Text(
            'Conheça, Inspire, Preserve',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Expanded(child: NewsListPage()),
        ],
      ),
    );
  }
}

class NewsListPage extends StatelessWidget {
  final List<String> news = [
    'Plantas urbanas ajudam a reduzir a poluição do ar',
    'Iniciativas de reciclagem crescem nas cidades brasileiras',
    'Comunidades adotam energia solar como alternativa sustentável',
    'Estudo mostra impacto do desmatamento na biodiversidade',
    'A importância da preservação de áreas verdes em centros urbanos',
  ];

  @override
  Widget build(BuildContext context) {
    try {
      if (news.isEmpty)
        throw Exception("Nenhuma notícia disponível no momento.");

      return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.eco, color: Colors.green, size: 32),
              title: Text(
                news[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.arrow_forward, color: Colors.green),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsDetailPage(newsTitle: news[index]),
                  ),
                );
              },
            ),
          );
        },
      );
    } catch (e) {
      return Center(
        child: Text(
          'Erro ao carregar as notícias: ${e.toString()}',
          style: TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}

class NewsDetailPage extends StatelessWidget {
  final String newsTitle;

  NewsDetailPage({required this.newsTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Notícia')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) {
            try {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsTitle,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Aqui você pode incluir o conteúdo completo da notícia. Por enquanto, estamos exibindo apenas o título.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            } catch (e) {
              return Center(
                child: Text(
                  'Erro ao carregar os detalhes da notícia: ${e.toString()}',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
