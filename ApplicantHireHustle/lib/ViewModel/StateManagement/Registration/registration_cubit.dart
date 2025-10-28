import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../Model/Registration/applicant.dart';
import '../../APIs/DioHelper.dart';



part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  GlobalKey<FormState> formKey = new GlobalKey();

  List fieldsData = [
    {
      'labelText': 'First Name',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Last Name',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Username',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Email',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Password',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Mobile Number',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'National Id',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Address Line',
      'controller': new TextEditingController(),
    },
    {
      'labelText': 'Age',
      'controller': new TextEditingController(),
    },
  ];

  bool obsecure = true;

  void triggerVisibility() {
    obsecure = !obsecure;
    emit(TriggerVisibility());
  }

  bool get obsecureValue => obsecure;


  File? imageFile;
  var imageXFile;
  late String imageLink;

  Future pickImage({
    fromGallery = false,
    fromCamera = false,
  }) async {
    try {
      imageXFile = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if(imageXFile == null) return;
      print(imageXFile.path);
      imageFile = File(imageXFile.path);
      emit(ImageChanged());
      uploadToStorage();
    } on Exception catch (exception) {
      print('Failed to pick image: $exception');
    }
  }

  void uploadToStorage() {
    FirebaseStorage.instance
        .ref()
        .child('images/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(imageFile!)
        .then((value) async {
          imageLink = await value.ref.getDownloadURL();
      print(imageLink);
    })
        .catchError((error) {});
  }

  // // Convert image to string to can store it in database.
  // String convertFileToBase64EncodedString(File file){
  //   List<int> imageBytes = file.readAsBytesSync();
  //   return base64Encode(imageBytes);
  // }
  //
  // // Convert string coming from database to its original image.
  // ImageProvider convertBase64EncodedStringToImage(String image){
  //   List<int> imageBytes = base64Decode(image);
  //   Uint8List uint8list = Uint8List.fromList(imageBytes);
  //   ImageProvider imageProvider = MemoryImage(uint8list);
  //   return imageProvider;
  // }

  late String filePath;
  String cvButtonLabel = 'Upload CV';
  late String cvLink;

  Future<void> uploadCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      filePath = result.files.single.path!;
      FirebaseStorage.instance
          .ref()
          .child('cvs/${Uri.file(filePath).pathSegments.last}')
          .putFile(new File(filePath))
          .then((value) async {
        cvLink = await value.ref.getDownloadURL();
        print(cvLink);
      })
          .catchError((error) {});
      cvButtonLabel = 'Uploaded!';
      emit(CvUploaded());
    }
  }

  // String encodeCVFileToBase64(String filePath) {
  //   File file = File(filePath);
  //   List<int> bytes = file.readAsBytesSync();
  //   return base64Encode(bytes);
  // }

  void validateRegistration() {
    if (formKey.currentState!.validate()) {
      Applicant applicant = new Applicant(
          imageLink,
          fieldsData[0]['controller'].text,
          fieldsData[1]['controller'].text,
          fieldsData[2]['controller'].text,
          fieldsData[3]['controller'].text,
          fieldsData[4]['controller'].text,
          fieldsData[5]['controller'].text,
          fieldsData[6]['controller'].text,
          fieldsData[7]['controller'].text,
          int.parse(fieldsData[8]['controller'].text),
          filePath == '' ? '' : cvLink,
      );
      String applicantJson = jsonEncode(applicant.toMap());
      register(applicantJson);
    }
  }

  void clearAllControllers(List data){
    imageFile = null;
    for(Map object in data){
      object['controller'].clear();
    }
    cvButtonLabel = 'Upload CV';
    filePath = '';
    cvLink = '';
  }

  void register(String jsonData) async{
    Response response = await DioHelper.postAPI(endpoint: 'applicant/register', data: jsonData);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.data);
      if (jsonResponse['status'] == 'success') {
        String successMessage = jsonResponse['data'];
        clearAllControllers(fieldsData);
        emit(RegistrationSuccess(successMessage));
      }
      else if (jsonResponse['status'] == 'failed'){
        String failureMessage = jsonResponse['message'];
        emit(RegistrationFailed(failureMessage));
      }
    }
    else{
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

}
