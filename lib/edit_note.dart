import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uas_ambw_c14210265/notes_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class EditNote extends StatefulWidget {
  final dynamic data;
  const EditNote({super.key, this.data});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  void initState() {
    super.initState();
    _notes = Hive.box('notes');
    titleController.text = widget.data['title'];
    bodyController.text = widget.data['body'];
  }

  editNote({id, title, body, created_at, updated_ad}) {
    _notes.put(id, {
      'title': title,
      'body': body,
      'created_at': created_at,
      'updated_at': updated_ad,
    });
  }

  var _notes;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'Edit Note'.text.make(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(onPressed: () {
            _notes.delete(widget.data['id']);
            VxToast.show(context, msg: 'Note deleted');
            Get.offAll(() => const NotesScreen());
          }, icon: const Icon(Icons.delete)),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (titleController.text != '') {
                var now = DateTime.now();
                var dateFormat = DateFormat('dd/MM/yy kk:mm').format(now);
                print("panjang body ${bodyController.text.length}");
                editNote(
                    id: widget.data['id'],
                    title: titleController.text,
                    body: bodyController.text,
                    created_at: widget.data['created_at'],
                    updated_ad: dateFormat);
                VxToast.show(context, msg: 'Note Updated');
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
                padding: const EdgeInsets.only(bottom: 16),
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
                padding: const EdgeInsets.symmetric(vertical: 16),
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
