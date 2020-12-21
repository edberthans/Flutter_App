import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int level = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        // image: Image(image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),)
        title: Text('Chat Flutter'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent[700],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            level+=1;
          });
        },
        child: Icon(Icons.add_box),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/1.jpg'),
                radius: 40,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.cyanAccent[700],
            ),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.purple,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Hans',
              style: TextStyle(
                color: Colors.deepOrange,
                letterSpacing: 2,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Level',
              style: TextStyle(
                color: Colors.purple,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '$level',
              style: TextStyle(
                color: Colors.deepOrange,
                letterSpacing: 2,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width: 10,),
                Text(
                  'hans@gmail.com',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}