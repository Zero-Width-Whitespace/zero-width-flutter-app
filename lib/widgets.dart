import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

Widget HeaderWidget(context) {
  return new Container(
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
  );
}

Widget TabBarHeader(context, _controller) {
  return new Container(
    decoration: new BoxDecoration(color: Theme.of(context).primaryColorDark),
    child: new TabBar(
      controller: _controller,
      tabs: [
        new Tab(
          icon: const Icon(Icons.lock_outline),
          text: 'Encrypt',
        ),
        new Tab(
          icon: const Icon(Icons.lock_open),
          text: 'Decrypt',
        ),
      ],
    ),
  );
}

Widget TabBarBody(context, _controller, _formKeyEncrypt, _formKeyDecrypt) {
  return new Container(
    margin: new EdgeInsets.only(top: 15.0),
    height: 180.0,
    child: new TabBarView(
      controller: _controller,
      children: <Widget>[
        new Form(
            key: _formKeyEncrypt,
            autovalidate: false,
            child: new ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.textsms),
                    hintText: 'Enter a text to hide the encrypted string in',
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
              ],
            )),
        new Form(
            key: _formKeyDecrypt,
            autovalidate: false,
            child: new ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.enhanced_encryption),
                    hintText: 'Enter a text to decrypt',
                    labelText: 'Encrypted string',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                new TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.no_encryption),
                    hintText: 'Result',
                    labelText: 'Result',
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}

Widget BottomButton(context, _controller, _formKeyEncrypt, _formKeyDecrypt) {
  return new FloatingActionButton(
    child: Icon(Icons.lock_outline),
    onPressed: () {
      if (_formKeyEncrypt.currentState.validate()) {
        encrypt('test', 'test2');
        final snackBar = SnackBar(content: Text('Result copied to clipboard.'));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    },
    backgroundColor: Theme.of(context).primaryColor,
    foregroundColor: Colors.white,
  );
}

Widget BottomWidget(context) {
  return new Card(
      margin: new EdgeInsets.all(10.0),
      child: new Container(
          height: 80,
          child: Row(
            children: <Widget>[
              const Expanded(
                child: const FlatButton(
                    onPressed: whatsappDebby,
                    child: const Tab(
                      icon: const Icon(Icons.share),
                      text: 'Share App',
                    )),
              ),
              const Expanded(
                child: const FlatButton(
                    onPressed: openRatingPage,
                    child: const Tab(
                      icon: const Icon(Icons.star),
                      text: 'Rate Us',
                    )),
              ),
              const Expanded(
                child: const FlatButton(
                    onPressed: whatsappDebby,
                    child: const Tab(
                      icon: const Icon(Icons.accessible_forward),
                      text: 'Debby',
                    )),
              ),
            ],
          )));
}

whatsappDebby() {
  openUrl('https://wa.me/+31639759200');
}

openRatingPage() {
  openUrl(
      'https://play.google.com/store/apps/details?id=com.kevin.serverstatus');
}

openUrl(url) async {
  if (await canLaunch(Uri.encodeFull(url))) {
    await launch(Uri.encodeFull(url));
  } else {
    throw 'Could not launch $url';
  }
}

encrypt(input, hiddenmessage) async{
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
  request.write('{"title": "Foo","body": "Bar", "userId": 99}');

  final response = await request.close();

  response.transform(utf8.decoder).listen((contents) {
    print(contents);
  });
}