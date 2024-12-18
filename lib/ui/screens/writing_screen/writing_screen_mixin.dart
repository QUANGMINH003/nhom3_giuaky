import 'package:fl_chart/fl_chart.dart';import 'package:flutter/material.dart';import 'package:go_router/go_router.dart';import 'package:nfc_manager/nfc_manager.dart';import 'package:nfc_writer/util/bildiriler.dart';import 'writing_screen.dart';/// WritingScreen mixin sınıfımixin WritingScreenMixin on State<WritingScreen> {  ValueNotifier<NdefMessage> result = ValueNotifier(NdefMessage([]));  int touchedIndex = -1;  void addRecord(NdefRecord record) {    final message = result.value;    message.records.add(record);    result.value = message;    result.notifyListeners();  }  void removeRecord(int index) {    final message = result.value;    message.records.removeAt(index);    result.value = message;    result.notifyListeners();  }  void writeTag(){    bildiriProgres(context);    NfcManager.instance.startSession(      onDiscovered: (NfcTag tag) async {        var ndef = Ndef.from(tag);        if (ndef == null || !ndef.isWritable) {          context.pop();          bildiriError(context, 'Writing Error', 'This tag is not writable');          Future.delayed(Duration(seconds: 2) , ()=>NfcManager.instance.stopSession(errorMessage: result.value.toString()));          return;        }        try {          await ndef.write(result.value);          Future.delayed(Duration(seconds: 2) , ()=>NfcManager.instance.stopSession());          context.pop();          bildiriSucces(context, 'Successful', 'Write operation successful');        } catch (e) {          Future.delayed(Duration(seconds: 2) , ()=>NfcManager.instance.stopSession(errorMessage: result.value.toString()));          context.pop();          bildiriError(context, 'Writing Error', result.value.toString());          return;        }      }    );  }  List<PieChartSectionData> showingSections() {   List<NdefRecord> records = result.value.records;    return List.generate(records.length, (i) {      final isTouched = i == touchedIndex;      final double fontSize = isTouched ? 25 : 16;      final double radius = isTouched ? 60 : 50;      final double widgetSize = isTouched ? 55 : 40;      final size = records[i].payload.lengthInBytes;      return PieChartSectionData(        color: getColorFromSize(size),  value: size.toDouble(),        title: size.toString() + ' byte',        radius: radius,        titleStyle: TextStyle(            fontSize: fontSize,            fontWeight: FontWeight.bold,            color: Colors.black),        titlePositionPercentageOffset: 0.55,      );    });  }  Color getColorFromSize(int size)=> Color.fromARGB(255, int.parse(numberToColor(size).substring(1, 3), radix: 16), int.parse(numberToColor(size).substring(3, 5), radix: 16), int.parse(numberToColor(size).substring(5, 7), radix: 16));  String numberToColor(int number) {    // Sayıyı al ve RGB değerlerini hesapla (0-255 arası değerler)    int r = (number * 37) % 256; // 37, farklı sonuçlar elde etmek için seçilen bir sabit    int g = (number * 59) % 256; // 59, farklı sonuçlar elde etmek için seçilen bir sabit    int b = (number * 83) % 256; // 83, farklı sonuçlar elde etmek için seçilen bir sabit    // RGB değerlerini hexadecimal renge çevir    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';  }  void ndefWriteLock() {    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {      var ndef = Ndef.from(tag);      if (ndef == null) {        NfcManager.instance.stopSession(errorMessage: result.value.toString());        return;      }      try {        await ndef.writeLock();        NfcManager.instance.stopSession();      } catch (e) {        NfcManager.instance.stopSession(errorMessage: result.value.toString());        return;      }    });  }  void addRecordDialog(int type){    if(type == -1) return;    final payloadController = TextEditingController();    String prefix = '';    if(type == 3){      prefix = 'http://';    }else if(type == 4){      prefix = 'https://';    }else if(type == 5){      prefix = 'tel:';    }else if(type == 6){      prefix = 'mailto:';    }    showDialog(      context: context,      builder: (context) {        return AlertDialog(          title: const Text('Add Record'),          content: SingleChildScrollView(            child: Column(              children: <Widget>[                TextField(                  controller: payloadController,                  decoration: InputDecoration(                    labelText: 'Data',                    prefix: Text(prefix)                  ),                ),              ],            ),          ),          actions: <Widget>[            TextButton(              onPressed: () {                Navigator.of(context).pop();              },              child: const Text('Cancel'),            ),            TextButton(              onPressed: () {                if(type == 0){                  addRecord(NdefRecord.createText(payloadController.text));                }else if(type == 1){                  addRecord(NdefRecord.createUri(Uri.parse(prefix + payloadController.text)));                }else if(type == 2){                }else if(type == 3){                  addRecord(NdefRecord.createUri(Uri.parse(prefix + payloadController.text)));                }else if(type == 4){                  addRecord(NdefRecord.createUri(Uri.parse(prefix + payloadController.text)));                }else if(type == 5){                  addRecord(NdefRecord.createUri(Uri.parse(prefix + payloadController.text)));                }else if(type == 6){                  addRecord(NdefRecord.createUri(Uri.parse(prefix + payloadController.text)));                }                Navigator.of(context).pop();              },              child: const Text('Add'),            ),          ],        );      },    );  }}