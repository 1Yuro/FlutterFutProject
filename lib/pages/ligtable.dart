import 'package:flutter/material.dart';
import 'package:zipzip/models/lig.dart';
import 'package:zipzip/services/ApiServices.dart';
import "dart:convert";

class ScoreTable extends StatefulWidget {
  @override
  _ScoreTableState createState() => _ScoreTableState();
}

late List<Lig> tablo;

class _ScoreTableState extends State<ScoreTable> {
  final index = 0;
  @override void initState(){
    tablo=[];
    ApiServices.getLigTablosu().then((response) {
      var listeJson = json.decode(response) as List;
      tablo = listeJson.map((model){
        return Lig.fromObject(model);
      }).toList();
      //Takimlari puana göre sırala eğer puanlar eşitse averaja göre sırala.
      tablo.sort((a, b) {
        if (a.takimpuan == b.takimpuan) {
          return b.takimaveraj.compareTo(a.takimaveraj);
        } else {
          return b.takimpuan.compareTo(a.takimpuan);
        }
      });
    }).whenComplete(() {
      setState(() {
        
      });
    });
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.white );
    //burada ilk tablonun verilerini aldım anahtar kısmını eklemedim. Bu yüzden tablonun uzunluğunu 1 artırıp if ile yeni bir row ekleyip onu düzenlemek zorunda kaldım.
  return ListView.builder(
    itemCount: tablo.length + 1, 
    itemBuilder: (context, index) {
      if (index == 0) {
        return Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(87, 0, 0, 0),
              width: 0.5,
            ),
            color: Colors.green[900],
          ),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text('Sıra#', style: textStyle),
              SizedBox(width: 20),
              Text('Takım', style: textStyle),
              Spacer(),
              Text('O', style: textStyle),
              SizedBox(width: 22),
              Text('G', style: textStyle),
              SizedBox(width: 22),
              Text('B', style: textStyle),
              SizedBox(width: 22),
              Text('M', style: textStyle),
              SizedBox(width: 22),
              Text('AG', style: textStyle),
              SizedBox(width: 22),
              Text('YG', style: textStyle),
              SizedBox(width: 22),
              Text('AV', style: textStyle),
              SizedBox(width: 22),
              Text('P', style: textStyle),
              SizedBox(width: 15),
            ],
          ),
        );
      } else {
        // Takım bilgileriyle ilgili satırlar
        Lig takim = tablo[index - 1];
        return Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(87, 0, 0, 0),
              width: 0.5,
            ),
            color: Colors.green,
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 30,
                height: 40,
                color: index == 1
                    ? Color.fromARGB(255, 177, 220, 255)
                    : index <= 4
                        ? Color.fromARGB(255, 137, 125, 250)
                        : index >= 16
                            ? Color.fromARGB(183, 255, 17, 0)
                            : Colors.grey[600],
                child: Text(
                  (index).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(takim.takimadi, style: textStyle),
              Spacer(),
              Container(
                width: 15,
                child: Text(takim.takimoynanan.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimgalibiyet.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimberaberlik.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimmalubiyet.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimatilangol.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimyenengol.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimaveraj.toString(), style: textStyle),
              ),
              SizedBox(width: 15),
              Container(
                width: 15,
                child: Text(takim.takimpuan.toString(), style: textStyle),
              ),
              Container(
                width: 5,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[600],
                ),
                padding: EdgeInsets.fromLTRB(10, 5, 2, 5),
              ),
            ],
          ),
        );
      }
    },
  );
}
}