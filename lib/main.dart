import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Plaid Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Plaid stuff here
  final String _plaidLinkToken = 'link-sandbox-aacf8349-a099-4683-8920-58df4d6fac8c';
  PlaidLink _plaidLink;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _handlePlaidSuccess(String publicToken, LinkSuccessMetadata metadata) {
    print('Public token: ${publicToken}');
    print('Metadata: ${metadata}');
  }

  void _handlePlaid() {
    print('Plaid pressed');
    LinkConfiguration configuration = LinkConfiguration(
      token: this._plaidLinkToken,
    );

    this._plaidLink = PlaidLink(
      configuration: configuration,
      onSuccess: this._handlePlaidSuccess,
    );

    this._plaidLink.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
                onPressed: () {
                  this._handlePlaid();
                },
                child: Text(
                  'Go, Plaid!!',
                  style: Theme.of(context).textTheme.bodyText1,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
