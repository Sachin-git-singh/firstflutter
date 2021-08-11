import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add this line.
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.blue,
        colorScheme: ColorScheme(
          primary: Colors.red,
          onPrimary: Colors.black,
          primaryVariant: Colors.orange,

          background: Colors.red,
          onBackground: Colors.black,

          secondary: Colors.red,
          onSecondary: Colors.white,
          secondaryVariant: Colors.deepOrange,

          error: Colors.black,
          onError: Colors.white,

          surface: Colors.white,
          onSurface: Colors.black,

          brightness: Brightness.light,
        ),

// this is the only code in ThemeData.light().copyWith()

      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {


  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold (                     // Add from here...
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
    itemBuilder: (BuildContext _context, int i) {
      if (i.isOdd) {
        return Divider();
      }
      final int index = i ~/ 2;
      if (index >= _suggestions.length) {
        // ...then generate 10 more and add them to the
        // suggestions list.
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);

    }
    );
  }
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(   // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
    onTap: () {      // NEW lines from here...
    setState(() {
    if (alreadySaved) {
    _saved.remove(pair);
    } else {
    _saved.add(pair);
    }
    });
    },


    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(context: context, tiles: tiles).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),

    );
  }

}


