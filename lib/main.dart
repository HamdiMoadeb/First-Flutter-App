// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('I Am Rich'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: Image(
            image: NetworkImage(
                'https://thevasilis.com/wp-content/uploads/2018/02/Im-Going-To-Make-You-Rich.jpg'),
          ),
        ),
      ),
    ));
