import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/screens/wrapper.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp(
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
