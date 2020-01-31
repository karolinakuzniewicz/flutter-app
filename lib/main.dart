import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './favourites.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Names Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WordPair> wordPairs;
  List<WordPair> favouriteWordPairs;

  @override
  void initState() {
    super.initState();

    wordPairs = List.generate(50, (int index) => WordPair.random());
    favouriteWordPairs = [];
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => FavouriteScreen(favouriteWordPairs)));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, int index) => NameSuggestion(
          wordPairs[index],
          onChanged: (bool favourited) {
            if (favourited) {
              favouriteWordPairs.add(wordPairs[index]);
            } else {
              favouriteWordPairs.remove((wordPairs[index]));
            }
          }
        ),
        itemCount: 50,
      ),
    );
  }
}

class NameSuggestion extends StatefulWidget {
  final void Function(bool favourited) onChanged;
  final WordPair wordPair;

  String get name => wordPair.asPascalCase;

  NameSuggestion(this.wordPair, { this.onChanged });

  @override
  _NameSuggestionState createState() => _NameSuggestionState();
}

class _NameSuggestionState extends State<NameSuggestion> {
  bool _isFavourite = false; //przepisac wyzej do app

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      trailing: Icon(_isFavourite ? Icons.favorite : Icons.favorite_border,
        color: _isFavourite ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          _isFavourite = !_isFavourite;
          widget.onChanged(_isFavourite);
        });
      }
    );
  }
}

