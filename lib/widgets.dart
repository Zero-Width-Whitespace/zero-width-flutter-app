import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
            padding: EdgeInsets.only(top: 50.0),
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
                      minLines: 1,
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

encrypt(input, context) async {
  String url = "https://zero-width-api-web.azurewebsites.net/Encode";
  try {
    http.post(url, body: {"stringToEncode": input}).then((response) {
      //--handle response
      if (response.statusCode == 200) {
        Clipboard.setData(new ClipboardData(text: response.body));

        print(response.body);
        final snackBar = SnackBar(
            content: Text('Result copied to clipboard.'),
            duration: Duration(seconds: 1));
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        throw new Exception();
      }
    });
  } catch (e) {
    final snackBar = SnackBar(
        content: Text('Something went wrong.'), duration: Duration(seconds: 1));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

decrypt(input, context) async {
  try {
    if (input == null) {
      print("Empty input");
    }
    String url = "https://zero-width-api-web.azurewebsites.net/Decode";
    http.post(url, body: {"stringToDecode": input}).then((response) {
      if (response.statusCode == 200) {
        _decodeResultController.text = response.body;

        print(response.body);
        final snackBar = SnackBar(
            content: Text('Decoded value.'), duration: Duration(seconds: 1));
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        throw new Exception();
      }
    });
  } catch (e) {
    final snackBar = SnackBar(
        content: Text('Something went wrong.'), duration: Duration(seconds: 1));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

HandleEncryptDecrypt(context, _controller, _formKeyEncrypt, _formKeyDecrypt) {
  if (_controller.index == 0) {
    if (_formKeyEncrypt.currentState.validate()) {
      encrypt(_encodeHiddenController.text.toString(), context);
    }
  } else {
    if (_formKeyDecrypt.currentState.validate()) {
      decrypt(_decodeTextController.text.toString(), context);
    }
  }
}
