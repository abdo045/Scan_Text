
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_text/screen/text_scan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool textScanning = false;
  XFile? imageFile;
  String scannedText='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('QCR App',
          style: TextStyle(
          fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white
        )),
        centerTitle: true,
        //actions: [IconButton(onPressed: (){},
           // icon:Icon(Icons.light_mode_outlined,
             // size: 26,
              //color: Colors.white,))],
      ),
      body: Container(
        width: double.infinity,height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/images/back.jpg',fit: BoxFit.cover,),),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,height:double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      if(textScanning)
                        Center(child: const CircularProgressIndicator(),),
                      if(!textScanning && imageFile == null)
                        Image.asset('assets/images/pin.png',
                        width: 300,height: 350,
                        ),
                      if(imageFile != null)
                        Image.file(File(imageFile!.path)),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 50,),
                          InkWell(
                            onTap: (){
                              getImage(ImageSource.gallery);
                            },
                            child: Container(
                              width: 90,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  border: Border.all(color: Colors.deepOrange)
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.photo_camera_back,size: 26,color: Colors.white,),
                                  Text('Gallery',style: TextStyle(fontSize: 20,color: Colors.white),)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 60,),
                          InkWell(
                            onTap: (){
                              getImage(ImageSource.camera);
                            },
                            child: Container(
                              width: 90,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  border: Border.all(color: Colors.deepOrange)
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.camera_alt_outlined,size: 26,color: Colors.white,),
                                  Text('Camera',style: TextStyle(fontSize: 20,color: Colors.white),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      InkWell(
                        onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ScanText(result: scannedText);
                        }));},
                        child: Container(
                            width: 90,
                            height: 60,
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(10),
                              border: Border.all(color: Colors.deepOrange)
                          ),
                          child:Center(child: Text('Text Scan',style: TextStyle(fontSize: 18,color: Colors.white),))

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source)async{
    final pickedImage = await ImagePicker().pickImage(source: source);
   try{
     final pickedImage = await ImagePicker().pickImage(source: source);
        if(pickedImage!= null){
              textScanning = true;
              imageFile = pickedImage;
              setState(() {});
               getRecognition(pickedImage);
         }
      } catch(e){
         textScanning=false;
         imageFile =null;
         scannedText ='Erorr occued while scanning';
         setState(() {});
   }
  }

  void getRecognition(XFile image)async{
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetection = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetection.processImage(inputImage);
    await textDetection.close();
    scannedText = '';

    for(TextBlock bloc in recognizedText.blocks){
      for(TextLine line in bloc.lines){
        scannedText =scannedText + line.text + '\n';
      }
    }

    textScanning=false;
    setState(() {});
  }
}
















