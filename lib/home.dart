import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class HomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).primaryColor, // navigation bar color
      statusBarColor: Theme.of(context).primaryColor, // status bar color
    ));
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
            new Container(
              padding: EdgeInsets.only(bottom: 30.0),
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Zero-Width Whitespace Encoding',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            new Stack(children: [
              new Column(
                children: <Widget>[
                  new Container(
                    height: MediaQuery.of(context).size.height * .1,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              new Card(
                  margin: new EdgeInsets.all(10.0),
                  child: new Container(
                    height: 200,
                    child: new Form(
                        key: _formKey,
                        autovalidate: false,
                        child: new ListView(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          children: <Widget>[
                            new TextFormField(
                              decoration: const InputDecoration(
                                icon: const Icon(Icons.textsms),
                                hintText:
                                'Enter a text to hide the encrypted string in',
                                labelText: 'Text',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            new TextFormField(
                              decoration: const InputDecoration(
                                icon: const Icon(Icons.lock_outline),
                                hintText: 'Enter a text to hide',
                                labelText: 'Hidden message',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            new Container(
                                padding: const EdgeInsets.only(
                                    left: 40.0, top: 20.0),
                                child: new RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'Result copied to clipboard!'));
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Text('Encrypt'),
                                )),
                          ],
                        )),
                  )),
            ])
          ])),
    );
  }
}
