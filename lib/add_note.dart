import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uas_ambw_c14210265/notes_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  void initState() {
    super.initState();
    _notes = Hive.box('notes');
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
    var titleController = TextEditingController();
    var bodyController = TextEditingController();
    var now = DateTime.now();
    var dateFormat = DateFormat('dd/MM/yy kk:mm').format(now);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'Add Note'.text.make(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (titleController.text != '') {
                saveNotes(
                    title: titleController.text,
                    body: bodyController.text,
                    created_at: dateFormat,
                    updated_ad: dateFormat);
                VxToast.show(context, msg: 'Noted Created');
                Get.offAll(() => const NotesScreen());
              } else {
                VxToast.show(context, msg: 'Title cannot be empty');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Title'.text.size(20).fontWeight(FontWeight.w600).black.make(),
              Padding(
                padding: const EdgeInsets.only( bottom: 16),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your title',
                  ),
                ),
              ),
              5.heightBox,
              'Body'.text.size(20).fontWeight(FontWeight.w600).black.make(),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 16),
                child: TextFormField(
                  controller: bodyController,
                  maxLines: 18,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    labelText: 'Enter your note',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
