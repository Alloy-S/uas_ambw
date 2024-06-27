import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uas_ambw_c14210265/notes_screen.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({super.key});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  @override
  void initState() {
    super.initState();
    _myBox = Hive.box('mybox');
    pinReady = _myBox.get('pin') != null ? true : false;
    textPin = pinReady ? "Entered Pin" : "Entered New Pin";
  }

  var pinReady;
  var _myBox;
  var textPin;
  String enteredPin = '';
  bool isPinVisible = false;

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 6) {
              if (enteredPin.length == 5) {
                enteredPin += number.toString();

                if (pinReady) {
                  // print('check pin');
                  if (_myBox.get('pin').toString() == enteredPin) {
                    // textPin = 'success';
                    // print('success');
                    Get.offAll(() => const NotesScreen());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Pin Salah',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ));
                    // print('pin salah');
                    enteredPin = '';
                  }
                } else {
                  _myBox.put('pin', enteredPin);
                  pinReady = true;
                  textPin = "Entered Pin";
                  enteredPin = '';
                }
              } else {
                enteredPin += number.toString();
              }
            }
          });
        },
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              textPin.toString(),
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          // pin code area
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  width: isPinVisible ? 40 : 16,
                  height: isPinVisible ? 40 : 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: index < enteredPin.length
                        ? isPinVisible
                            ? Colors.blue
                            : Colors.blue
                        : Colors.blue.withOpacity(0.1),
                  ),
                  child: isPinVisible && index < enteredPin.length
                      ? Center(
                          child: Text(
                            enteredPin[index],
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      : null,
                );
              })),
          // visibility button
          IconButton(
              onPressed: () {
                setState(() {
                  isPinVisible = !isPinVisible;
                });
              },
              icon:
                  Icon(isPinVisible ? Icons.visibility_off : Icons.visibility)),
          SizedBox(
            height: isPinVisible ? 50.0 : 8.0,
          ),

          Column(
            children: List.generate(3, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      List.generate(3, (index) => numButton(1 + 3 * i + index))
                          .toList(),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextButton(onPressed: null, child: SizedBox()),
                numButton(0),
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (enteredPin.isNotEmpty) {
                          enteredPin =
                              enteredPin.substring(0, enteredPin.length - 1);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.backspace,
                      color: Colors.black,
                      size: 24,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
