import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';
import 'widgets.dart';

class HomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKeyEncrypt = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDecrypt = new GlobalKey<FormState>();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Center(
            child: null,
          ),
          elevation: 0.0,
        ),
        backgroundColor: Colors.grey[200],
        body: Builder(
            builder: (context) => new Column(children: [
                  HeaderWidget(context),
                  new Stack(children: [
                    new Column(
                      children: <Widget>[
                        new Container(
                          height: MediaQuery.of(context).size.height * .07,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    new Card(
                        margin: new EdgeInsets.all(10.0),
                        child: new ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            TabBarHeader(context, _controller),
                            TabBarBody(context, _controller, _formKeyEncrypt,
                                _formKeyDecrypt),
                          ],
                        )),
                  ]),
                  BottomWidget(context)
                ])),
        floatingActionButton: BottomButton(
            context, _controller, _formKeyEncrypt, _formKeyDecrypt));
  }
}
