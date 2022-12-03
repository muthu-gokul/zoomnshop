import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoomnshop/utils/colorUtil.dart';

import '../app_theme.dart';


class LogoPicker extends StatelessWidget {
  String imageUrl;
  File? imageFile;
  Function(File) onCropped;
  String description;
  String btnTitle;
  bool isEnable;
  LogoPicker({required this.imageUrl,this.imageFile,required this.onCropped,this.description="Upload Your Company Logo",
    this.btnTitle="Choose File",this.isEnable=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoAvatar(imageUrl: imageUrl, imageFile: imageFile,radius: 100,),
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.center,
          child: Text(description,
            style: TextStyle(fontFamily: 'RR',fontSize: 14,color: AppTheme.gridTextColor),
          ),
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap:isEnable?  (){
            getImage(onCropped);
          }:null,
          child:  Align(
            alignment: Alignment.center,
            child: Container(
              width: 150,
              height:45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: ColorUtil.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorUtil.primaryColor.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(1, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                  child: Text(btnTitle,style: TextStyle(color:Colors.white,fontSize:16,fontFamily: 'RM'),
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LogoAvatar extends StatelessWidget {
  String imageUrl;
  File? imageFile;
  double radius;
  double height;
  LogoAvatar({Key? key,required this.imageUrl,required this.imageFile,this.radius=100,this.height=100}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: radius,
      decoration: BoxDecoration(
        color: AppTheme.avatarBorderColor,
        //shape: BoxShape.circle
      ),
      alignment: Alignment.center,
      child: Container(
        height: height-3,
        width: radius-3,
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
            color: Colors.white
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        child: imageFile!=null?Image.file(imageFile!,):
        Image.network(imageUrl,
            errorBuilder: (a,b,c){
              return SvgPicture.asset("assets/icon/upload.svg",height: height-3,width: radius-3,fit: BoxFit.cover,color: ColorUtil.primaryColor,);
            },
            fit: BoxFit.contain,
            height: height-3, width: radius-3
        ),
      ),
    );
  }
}

Future getImage( Function(File) onCropped) async
{
  XFile? temp=await (ImagePicker().pickImage(source: ImageSource.gallery));
  if(temp==null)return;
  File tempImage = File(temp.path);
  _cropImage(tempImage,onCropped);
}

_cropImage(File picked,Function(File) onCropped) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: picked.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,

    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.red,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          showCropGrid: false,
        hideBottomControls: true
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
    cropStyle: CropStyle.circle,
    maxWidth: 400
  );
  if (croppedFile != null) {
    onCropped(File(croppedFile.path));
  }
  // CroppedFile? cropped = await ImageCropper().cropImage(
  //   uiSettings: AndroidUiSettings(
  //       statusBarColor: Colors.red,
  //       toolbarColor: Colors.red,
  //       toolbarTitle: "Crop Image",
  //       toolbarWidgetColor: Colors.white,
  //       showCropGrid: false,
  //       hideBottomControls: true
  //   ),
  //   sourcePath: picked.path,
  //   aspectRatioPresets: [
  //     CropAspectRatioPreset.square
  //   ],
  //   maxWidth: 400,
  //   cropStyle: CropStyle.circle,
  // );
  // if (cropped != null) {
  //   onCropped(cropped);
  // }
}