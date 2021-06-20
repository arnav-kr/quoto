import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List jsonBackup = [];

Future<List> loadQuotes() async {
  var jsonText = await rootBundle.loadString('assets/quotes.json');
  var data = json.decode(jsonText);
  jsonBackup = data;
  return data;
}

//
// Future getQuote() async {
// This example uses the Google Books API to search for books about http.
// https://developers.google.com/books/docs/overview
// var url = Uri.https('type.fit', '/api/quotes');
//
// Await the http get response, then decode the json-formatted response.
// var response = await http.get(url);
// if (response.statusCode == 200) {
// var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
// var dataquote = jsonResponse[0];
// var quote = dataquote['text'];
// var author = dataquote['author'];
// var data = [quote, author];
// return data;
// } else {
// return ['Couldn\'t get Quotes ☹.', ''];
// }
// }
//
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.f

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            child: Icon(
              Icons.format_quote,
              size: 40,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Quote(),
      ),
    );
  }
}

class _QuoteState extends State<Quote> {
  List<dynamic> _quotes = [];
  dynamic _quote;
  _randomItem(list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  _getQuote() async {
    loadQuotes().then((val) => setState(() {
          _quotes = val;
          _quote = _randomItem(_quotes);
        }));
  }

  // _QuoteState() {
  //   _getQuote();
  // }

  @override
  void initState() {
    super.initState();
    _getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(32.0),
      child: Center(
        child:
            new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              (_quote['text']),
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontFamily: "Heveltica"),
              textAlign: TextAlign.left,
            ),
            Text(
              ("~ " + (_quote['author'])),
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.pink,
                  fontFamily: "Heveltica",
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ]),
          Container(
            margin: EdgeInsets.only(top: 64.0),
            child: IconButton(
              onPressed: () {
                print("refreshed!");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Quotes Refreshed Successfully!"),
                  ),
                );
                setState(() {
                  _quote = _randomItem(_quotes);
                });
              },
              icon: SvgPicture.asset(
                'assets/dice.svg',
                semanticsLabel: 'Random Quote',
                width: 64,
                height: 64,
              ),
              iconSize: 64,
              tooltip: "Random Quote",
            ),
          )
        ]),
      ),
    );
  }
}

class Quote extends StatefulWidget {
  @override
  _QuoteState createState() => _QuoteState();
}

void refresh() {}
