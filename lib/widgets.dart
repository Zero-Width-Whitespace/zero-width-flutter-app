import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

final _encodeHiddenController = TextEditingController();

final _decodeTextController = TextEditingController();
final _decodeResultController = TextEditingController();

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
          text: 'Encode',
        ),
        new Tab(
          icon: const Icon(Icons.lock_open),
          text: 'Decode',
        ),
      ],
    ),
  );
}

Widget TabBarBody(context, _controller, _formKeyEncrypt, _formKeyDecrypt) {
  return new Container(
    height: 200.0,
    child: new TabBarView(
      controller: _controller,
      children: <Widget>[
        new Container(
            padding: EdgeInsets.only(top: 15.0),
            child: new Form(
                key: _formKeyEncrypt,
                autovalidate: false,
                child: new ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    new TextFormField(
                      maxLines: 4,
                      minLines: 2,
                      controller: _encodeHiddenController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.lock_outline),
                        hintText: 'Enter a message to encode',
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
                ))),
        new Container(
            padding: EdgeInsets.only(top: 15.0),
            child: new Form(
                key: _formKeyDecrypt,
                autovalidate: false,
                child: new ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    new TextFormField(
                      controller: _decodeTextController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.enhanced_encryption),
                        hintText: 'Enter a text to decode',
                        labelText: 'Encoded string',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    new TextFormField(
                      readOnly: true,
                      maxLines: 4,
                      minLines: 2,
                      controller: _decodeResultController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.no_encryption),
                        hintText: 'Result',
                        labelText: 'Result',
                      ),
                    ),
                  ],
                ))),
      ],
    ),
  );
}

Widget FloatingButton(context, _controller, _formKeyEncrypt, _formKeyDecrypt) {
  if (_controller.index == 0) {
    return new FloatingActionButton(
      child: Icon(Icons.lock_outline),
      onPressed: () {
        HandleEncryptDecrypt(
            context, _controller, _formKeyEncrypt, _formKeyDecrypt);
      },
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
    );
  } else {
    return new FloatingActionButton(
      child: Icon(Icons.lock_open),
      onPressed: () {
        HandleEncryptDecrypt(
            context, _controller, _formKeyEncrypt, _formKeyDecrypt);
      },
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
    );
  }
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

encrypt(input) async {
  final client = HttpClient();
  final request = await client
      .postUrl(Uri.parse("https://zero-width-api-web.azurewebsites.net/Encode?stringToEncode="+input));
  request.headers
      .set(HttpHeaders.contentTypeHeader, "text/plain; charset=utf-8");

  final response = await request.close();

  response.transform(utf8.decoder).listen((contents) {
    print(contents);
    Clipboard.setData(new ClipboardData(text: contents));
  });
}

decrypt(input) async {
  if(input == null){
    print("Empty input");
  }

  final client = HttpClient();
  final request = await client
      .postUrl(Uri.parse("https://zero-width-api-web.azurewebsites.net/Decode?stringToDecode="+input));
  request.headers
      .set(HttpHeaders.contentTypeHeader, "text/plain; charset=utf-8");

  final response = await request.close();
  response.transform(utf8.decoder).listen((contents) {
    // handle data
    print("Done");
    print(contents.toString());
  });
}

HandleEncryptDecrypt(context, _controller, _formKeyEncrypt, _formKeyDecrypt) {
  if (_controller.index == 0) {
    if (_formKeyEncrypt.currentState.validate()) {
      encrypt(_encodeHiddenController.value.toString());
      final snackBar = SnackBar(content: Text('Result copied to clipboard.'), duration: Duration(seconds: 1));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  } else {
    if (_formKeyDecrypt.currentState.validate()) {
      decrypt(_decodeTextController.text.toString());
      final snackBar = SnackBar(content: Text('Decoded value.'), duration: Duration(seconds: 1));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
