import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quoto/quote_factory.dart' as QuoteFactory;

// ignore: non_constant_identifier_names
List Quotes = QuoteFactory.quotes;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          backgroundColor: Color.fromRGBO(57, 177, 157, 1),
        ),
        body: Quote(),
      ),
    );
  }
}

class _QuoteState extends State<Quote> {
  dynamic _quote;
  _randomItem(list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  _getQuote() async {
    _quote = _randomItem(Quotes);
  }

  _QuoteState() {
    _getQuote();
  }

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
            child: ClipOval(
              child: Material(
                color: Color.fromRGBO(57, 177, 157, 1),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      print("New Quote Loaded!");
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Quote Loaded Successfully!"),
                        ),
                      );
                      setState(() {
                        _quote = _randomItem(Quotes);
                      });
                    },
                    child: Icon(
                      Icons.replay_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Quote extends StatefulWidget {
  @override
  _QuoteState createState() => _QuoteState();
}
