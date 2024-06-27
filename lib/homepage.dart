import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  // write data
  void writeData() {
    _myBox.put('pin', '123456');
  }

  // read data
  void readData() {
    print(_myBox.get('pin'));
  }

  // delete data
  void deleteData() {
    _myBox.delete('pin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                writeData();
              },
              child: Text('Write'),
              color: Colors.green[300],
            ),
            MaterialButton(
              onPressed: () {
                readData();
              },
              child: Text('Read'),
              color: Colors.green[300],
            ),
            MaterialButton(
              onPressed: () {
                deleteData();
              },
              child: Text('Delete'),
              color: Colors.green[300],
            ),
          ],
        ),
      ),
    );
  }
}
