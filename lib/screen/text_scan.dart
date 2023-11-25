// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:scan_text/screen/function.dart';

class ScanText extends StatelessWidget {
  ScanText({super.key,required this.result});

  String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.deepOrange,)),
        title: Text('Text Scan',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white
            )),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                height: 350,
                width: 320,
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.only(left: 20,bottom: 20,right: 20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      result,
                      style: TextStyle(color: Colors.deepOrange),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/note.jpg'),
                       fit: BoxFit.contain,
                  )
                ),
      ),
             SizedBox(height: 30,),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child:Container(
                 width: double.infinity,
                 height: 80,
                 child: Row(
                 crossAxisAlignment:CrossAxisAlignment.center,
                 children: [
                   SizedBox(width: 50,),
                   Container(
                       child:IconButton(onPressed: (){
                         Fun.shareText('$result');
                         final snackBar = SnackBar(content: Text('Share Text'));
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }, icon: Icon(Icons.share,color: Colors.deepOrange))),
                   SizedBox(width: 15,),
                   Container(child:
                   IconButton(onPressed: (){
                     Fun.copyText('$result');
                     final snackBar = SnackBar(content: Text('Copy Text'));
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   }, icon: Icon(Icons.copy,color: Colors.deepOrange,)))

                 ],),
               )

             )
            ],
          )),
    );
  }
}

