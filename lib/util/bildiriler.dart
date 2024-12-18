import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void mesaj(String mes, {Color? color}) {
  Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: color ?? Colors.orange,
      timeInSecForIosWeb: 1);
}

void hataMesaji(String mes) {
  Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      timeInSecForIosWeb: 1);
}

Future<void> bildiri(BuildContext context, String mes) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Text(
        mes,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    ),
    barrierDismissible: true,
  );
}

Future<void> bildiriError(
    BuildContext context, String title, String body) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        body,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    ),
    barrierDismissible: true,
  );
}
Future<void> bildiriSucces(
    BuildContext context, String title, String body) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        body,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    ),
    barrierDismissible: true,
  );
}

Future<void> bildiriProgres(BuildContext context , {String? mes}) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) =>  CupertinoAlertDialog(
      content: Column(
        children: [
          Center(child: CircularProgressIndicator()),
          SizedBox(
            height: 10,
          ),
          Text(
            mes??"Transaction is being processed",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

Future<bool> bildiriCevap(BuildContext context, String mes,
    {bool? important}) async {
  return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Column(
            children: [
              important != null && important
                  ? const Icon(
                      Icons.question_mark_sharp,
                      color: Colors.red,
                    )
                  : const Center(),
              Text(
                mes,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Yes"))
          ],
        ),
        barrierDismissible: true,
      ) ??
      false;
}

Future<bool?> bildiri2Cevap(
    BuildContext context, String mes, String a, String b) async {
  return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Column(
            children: [
              Text(
                mes,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(a)),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(b))
          ],
        ),
        barrierDismissible: true,
      ) ;
}

Future<bool?> bildiriCevapNull(BuildContext context, String mes,
    {bool? important}) async {
  return await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Column(
        children: [
          important != null && important
              ? const Icon(
                  Icons.question_mark_sharp,
                  color: Colors.red,
                )
              : const Center(),
          Text(
            mes,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("No")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Yes"))
      ],
    ),
    barrierDismissible: true,
  );
}

var firmaNo = TextEditingController();
var belgeNo = TextEditingController();

Future<Map> firmaBilgisiAl(BuildContext context) async {
  return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: SizedBox(
            width: 300,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      controller: firmaNo,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Company Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 2,
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      controller: belgeNo,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: "Document Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context,
                      {"company number": firmaNo.text, "document number": belgeNo.text});
                  firmaNo.clear();
                  belgeNo.clear();
                },
                child: const Text("Give to Company"))
          ],
        ),
        barrierDismissible: true,
      ) ??
      {"company number": null, "document number": null};
}

Future<String?> bildiriStringCevap(BuildContext context, String mes) async {
  return await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: SizedBox(
        width: 300,
        height: 100,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                mes,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              flex: 2,
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: title,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: mes.toString(),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, title.text);
              title.clear();
            },
            child: const Text("Ok"))
      ],
    ),
    barrierDismissible: true,
  );
}

Future<List<String>> bildiriOyuncular(
    BuildContext context, String mes, int oyuncuSayisi) async {
  List<TextEditingController> oyuncuAdi = [];
  List<String> oyuncuAdiString = [];
  for (int i = 0; i < oyuncuSayisi; i++) {
    oyuncuAdi.add(TextEditingController());
  }
  return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: SizedBox(
            width: 300,
            height: (80 * oyuncuSayisi).toDouble(),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    mes,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                for (int i = 0; i < oyuncuSayisi; i++)
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: oyuncuAdi[i],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: "Set ${i + 1}",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  for (var element in oyuncuAdi) {
                    oyuncuAdiString.add(element.text.isNotEmpty
                        ? element.text.trim()
                        : "Actor ${oyuncuAdi.indexOf(element) + 1}");
                  }
                  Navigator.pop(context, oyuncuAdiString);
                  title.clear();
                },
                child: const Text("Set"))
          ],
        ),
        barrierDismissible: true,
      ) ??
      ["Team1", "Team2"];
}

Future<int> bildiriOyuncuSayisi(BuildContext context, String mes) async {
  return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: SizedBox(
            width: 300,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      mes,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: title,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: mes.toString(),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  try {
                    int a = int.parse(title.text);
                    Navigator.pop(context, a);
                    title.clear();
                  } catch (e) {
                    Navigator.pop(context, 2);
                    title.clear();
                  }
                },
                child: const Text("Set"))
          ],
        ),
        barrierDismissible: true,
      ) ??
      2;
}

var title = TextEditingController();
var body = TextEditingController();

Future<void> SendNotiUserWidget(
    {required BuildContext context, required String tTamamen}) async {
  Size size = MediaQuery.of(context).size;
  await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: SizedBox(
        width: size.width > 900 ? size.width / 3 : size.width / 1.5,
        height: 150,
        child: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: title,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: body,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: "Body",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Send"))
      ],
    ),
    barrierDismissible: true,
  );
}

var text = TextEditingController();

Future<String> getTextUser(
    {required BuildContext context, required String hintText}) async {
  Size size = MediaQuery.of(context).size;
  return await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: SizedBox(
        width: size.width > 900 ? size.width / 3 : size.width / 1.5,
        height: 75,
        child: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: text,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: hintText,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, text.text);
            },
            child: const Text("Ok"))
      ],
    ),
    barrierDismissible: true,
  );
}

void hataBildiri(BuildContext context, String mes) {
  showCupertinoDialog(
    context: context,
    builder: (context) => Theme(
      data: ThemeData.from(
          colorScheme: const ColorScheme(
        primary: Colors.red,
        secondary: Colors.amber,
        surface: Colors.purpleAccent,
        background: Colors.red,
        error: Colors.red,
        onPrimary: Colors.red,
        onSecondary: Colors.deepOrange,
        onSurface: Colors.red,
        onBackground: Colors.red,
        onError: Colors.redAccent,
        brightness: Brightness.light,
      )),
      child: CupertinoAlertDialog(
        content: Column(
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
            ),
            Text(
              mes,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"))
        ],
      ),
    ),
    barrierDismissible: true,
  );
}

void succBildiri(BuildContext context, String mes) {
  showCupertinoDialog(
    context: context,
    builder: (context) => Theme(
      data: ThemeData.from(
          colorScheme: const ColorScheme(
        primary: Colors.green,
        secondary: Colors.amber,
        surface: Colors.purpleAccent,
        background: Colors.green,
        error: Colors.green,
        onPrimary: Colors.green,
        onSecondary: Colors.green,
        onSurface: Colors.green,
        onBackground: Colors.green,
        onError: Colors.green,
        brightness: Brightness.light,
      )),
      child: CupertinoAlertDialog(
        content: Column(
          children: [
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
            Text(
              mes,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"))
        ],
      ),
    ),
    barrierDismissible: true,
  );
}
