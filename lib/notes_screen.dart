import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uas_ambw_c14210265/add_note.dart';
import 'package:uas_ambw_c14210265/edit_note.dart';
import 'package:uas_ambw_c14210265/setting_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notes = Hive.box('notes');
  }

  getNotes(context) {
    final data = _notes.keys.map((key) {
      var item = _notes.get(key);
      return {
        'id': key,
        'title': item['title'],
        'body': item['body'],
        'created_at': item['created_at'],
        'updated_at': item['updated_at'],
      };
    }).toList();

    return data;
    // print(data);
    // VxToast.show(context, msg: data.toString());
  }

  saveNotes({title, body, created_at, updated_ad}) {
    _notes.add({
      'title': title,
      'body': body,
      'created_at': created_at,
      'updated_at': updated_ad,
    });

    VxToast.show(context, msg: "Note Created");
  }

  var _notes;

  @override
  Widget build(BuildContext context) {
    var data = getNotes(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const SettingScreen());
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          onPressed: () {
            Get.to(() => AddNote());
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: List.generate(
          (data.length / 2).round(),
          (row) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (col) {
              var index = row * 2 + col;
              // print(data.length);

              if (index < data.length) {
                var note = data[index];
                print(note);
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      //     border: Border.all(
                      //   color: Colors.black,
                      // ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2.15,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          note['body'],
                          maxLines: 2,
                        ),
                        note['updated_at']
                            .toString()
                            .text
                            .color(Colors.grey[400])
                            .make(),
                      ],
                    ),
                  ),
                ).onTap(() {
                  Get.to(() => EditNote(
                        data: note,
                      ));
                });
              } else {
                return Container();
              }
            }),
          ),
        )),
      ),
    );
  }
}
