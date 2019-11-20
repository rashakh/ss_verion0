import 'package:dtfbl/src/screen/path_provider.dart';
import 'package:flutter/material.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
//import 'package:playground_flutter/configs/ioc.dart';
//import 'package:playground_flutter/models/baseball.model.dart';
//import 'package:playground_flutter/services/sqlite_basebal_team.service.dart';
//import 'package:playground_flutter/shared/widgets/crud_demo_list_item.widget.dart';
import 'package:pdf/pdf.dart';


class ExportPDF extends StatelessWidget {
     // ExportPDF(this.id)
      // var id;
  //final SqliteBaseballService _databaseService =
    //  Ioc.get<SqliteBaseballService>();

  //PdfGeneratorDemo({Key key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    
      appBar: AppBar(
        
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
     //   bottom: new TabBar(
       //       tabs: [
         //       Tab(icon: Icon(Icons.insert_chart)),
           //     Tab(icon: Icon(Icons.picture_as_pdf)),
             // ],
           // ),
           title: new Text(
         'التقارير',
         style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
           onPressed:()=> _generatePdfAndView(context)
          ),
          SizedBox(width: 10),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
           //   accountName: Text(id[0]['fname'].toString()),
             // accountEmail: Text(id[0]['email'].toString()),
            ),
            new ListTile(
              title: Text('الادوية'),
              onTap: () {
                Navigator.of(context).pushNamed('/MedAlert');
              },
            ),
            new ListTile(
              title: Text('الفحوصات الدورية'),
              onTap: () {
                Navigator.of(context).pushNamed('/PeriodicTest');
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () { Navigator.of(context).pushNamed('/ExportPDF');},
            ),
            new ListTile(
              title: Text('الاعدادات'),
              onTap: () {},
            ),
            new ListTile(
              title: Text('تسجيل الخروج'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/LoginPage');
              },
            )
          ],
        ),
      ),

    );
      
  }


  _generatePdfAndView(context) async {
   final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
  //    final pdf = Document();

    pdf.addPage(
  pdfLib.MultiPage(

 // Page(
    // pageFormat: PdfPageFormat.a4,
     
    //  build: ( context) =>[

       
    //  ]
    //     //return  Center(
    //     //  child: Text("Hello World"),
    //   //  ); // Center
    //   //));
       
       
       
      build: (context) => [
          
             pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
               <String>['Name', 'Coach', 'players'],
               //...data.map(
                 //  (item) => [item.name, item.coach, item.players.toString()])
             ]), 
            ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/baseball_teams.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
      ),
    );
  }



}



