import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/upload_prescription.dart';
import 'package:hvdc_user/screens/home/header.dart';
import 'package:hvdc_user/screens/home/mobile_home.dart';
import 'package:hvdc_user/utils/padding.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/routing.dart';
import 'package:hvdc_user/utils/style.dart';

import '../utils/appBar.dart';
import '../utils/colors.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  State<UploadPrescriptionScreen> createState() => UploadPrescriptionState();
}

class UploadPrescriptionState extends State<UploadPrescriptionScreen> {
  UploadPrescriptionC uploadPrescription = Get.put(UploadPrescriptionC());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: kIsWeb
              ? null
              : KAppBar("Upload Prescription", actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Obx(
                      () => Badge.count(
                        count: uploadPrescription.prescriptions.length,
                        isLabelVisible: !uploadPrescription.isLoading.value,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed("/prescription_list");
                          },
                          child: const Icon(
                            CupertinoIcons.square_list_fill,
                            color: kGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (kIsWeb) Header(),
                Padding(
                  padding: kWeb
                      ? kWebPadding
                      : const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/file.jpg",
                          height: kIsWeb ? kWidth(35) : kWidth(80),
                        ),
                      ),
                      Text(
                        "Please upload an image of your prescription",
                        style: kTextStyle.copyWith(fontSize: 30),
                      ),
                      const Text(
                          "Description:\n1. To proceed with your order, please upload a clear\n    and legible image of your prescription.\n2. Our team will review your prescription to ensure\n    accuracy and legality.\n3. Accepted file formats: JPEG, PNG, PDF\n4. Maximum file size: 5 MB"),
                      const SizedBox(height: 20),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kGreen),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        onPressed: () {
                          kWeb
                              ? uploadPrescription.pickImageGallary()
                              : selectImageType();
                        },
                        child: SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Center(
                            child: Text(
                              "Upload Prescription",
                              style: kTextStyle.copyWith(color: kWhite),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  selectImageType() {
    showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
            height: kHeight(20),
            width: kWidth(100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    uploadPrescription.pickImageGallary();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.camera,
                        size: 50,
                      ),
                      Text(
                        "Camera",
                        style: kTextStyle.copyWith(color: kText),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    uploadPrescription.pickImageGallary();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.images,
                        size: 50,
                      ),
                      Text(
                        "Gallary",
                        style: kTextStyle.copyWith(color: kText),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
