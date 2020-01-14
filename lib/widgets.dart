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

Widget TabBarBody(context, _controller, _formKey) {
  return new Container(
    margin: new EdgeInsets.only(top: 10.0),
    height: 180.0,
    child: new TabBarView(
      controller: _controller,
      children: <Widget>[
        new Form(
            key: _formKey,
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
        new ListTile(
          leading: const Icon(Icons.location_on),
          title: new Text('Latitude: 48.09342\nLongitude: 11.23403'),
          trailing: new IconButton(
              icon: const Icon(Icons.my_location), onPressed: () {}),
        ),
      ],
    ),
  );
}

Widget BottomButton(context, _controller, _formKey) {
  return new FloatingActionButton(
    child: Icon(Icons.lock_outline),
    onPressed: () {
      if (_formKey.currentState.validate()) {
        final snackBar = SnackBar(content: Text('Result copied to clipboard!'));
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

whatsappDebby(){
  openUrl('https://wa.me/+31639759200');
}

openRatingPage(){
  openUrl('https://play.google.com/store/apps/details?id=com.kevin.serverstatus');
}

openUrl(url) async {
  if (await canLaunch(Uri.encodeFull(url))) {
    await launch(Uri.encodeFull(url));
  } else {
    throw 'Could not launch $url';
  }
}
