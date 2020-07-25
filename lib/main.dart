import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Navigation Basic',
      //start the app with the "/" named route.
      // initialRoute: '/',
      // routes: {
      //   '/':(context) => FirstScreen(), //initialRoute

      //   '/second': (context) => SecondRoute()
      // },

      //home: SimpleNavigation()

      onGenerateRoute: (set) {
        if (set.name == PassArgumentsScreen.routeName) {
          final ScreenArguments args = set.arguments;

          return MaterialPageRoute(builder: (context) {
            return PassArgumentsScreen(
              title: args.title,
              message: args.message,
            );
          });
        }
      },

      home: HomeScreen(),
      routes: {
        ExtractArgumnetsScreen.routeName: (context) => ExtractArgumnetsScreen()
      },
    ),
  );
}

class SimpleNavigation extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Navigation'),
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondRoute(),
              ),
            );
          },
          child: Text('Next'),
        )),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Second Route'),
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back'),
        )),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
          child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
        child: Text('Launch Screen'),
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Second Screen'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go Back'),
          ),
        ));
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Navigate to Screen that extract arguments'),
              onPressed: () {
                Navigator.pushNamed(context, ExtractArgumnetsScreen.routeName,
                    arguments: ScreenArguments(
                        "Extract Args", "Message from Extract Argument"));
              },
            ),
            RaisedButton(
              child: Text('Navigate to a named that accept arguments'),
              onPressed: () {
                Navigator.pushNamed(context, PassArgumentsScreen.routeName,
                    arguments: ScreenArguments("Accept arguments screen",
                        "Message from passArgument"));
              },
            )
          ],
        ),
      ),
    );
  }
}

class ExtractArgumnetsScreen extends StatelessWidget {
  static const routeName = '/extractArgument';

  @override
  Widget build(BuildContext context) {
    //Extract the arguments from the current ModalRoute
    //Settings and cast them as ScreeenArguments
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(child: Text(args.message)),
    );
  }
}

//accepts the necessary arguments via the constructor
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  //constructor
  const PassArgumentsScreen(
      {Key key, @required this.title, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
