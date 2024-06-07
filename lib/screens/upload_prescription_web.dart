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
import 'package:image_picker/image_picker.dart';

import '../models/prescription.dart';
import '../utils/appBar.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/loading.dart';

class UploadPrescriptionScreenWeb extends StatefulWidget {
  const UploadPrescriptionScreenWeb({super.key});

  @override
  State<UploadPrescriptionScreenWeb> createState() => UploadPrescriptionState();
}

class UploadPrescriptionState extends State<UploadPrescriptionScreenWeb> {
  UploadPrescriptionC uploadPrescription = Get.put(UploadPrescriptionC());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            if (kIsWeb) Header(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: kWeb
                            ? kWebPadding
                            : const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            Center(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kGreen),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)))),
                                ),
                                onPressed: () {
                                  uploadPrescription.pickImageAndUpload(
                                      source: ImageSource.gallery);
                                },
                                child: SizedBox(
                                  height: 40,
                                  width: kWidth(30),
                                  child: Center(
                                    child: Text(
                                      "Upload Prescription",
                                      style: kTextStyle.copyWith(color: kWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Uploaded Prescriptions",
                          style: TextStyle(
                              color: kText,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                        Obx(
                          () => uploadPrescription.isLoading.value
                              ? const KLoading()
                              : uploadPrescription.prescriptions.isEmpty
                                  ? const Center(
                                      child: Text("Prescription not found"),
                                    )
                                  : ListView.builder(
                                      itemCount: uploadPrescription
                                          .prescriptions.length,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Prescription prescription =
                                            uploadPrescription
                                                .prescriptions[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: kContainer(
                                            child: ListTile(
                                                title: Text(
                                                  prescription.status ==
                                                          'pending'
                                                      ? "Your prescription analysis is pending."
                                                      : "Your prescription has been created successfully.",
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      "Prescription ID: ${prescription.id}",
                                                    ),
                                                    prescription.status ==
                                                            'pending'
                                                        ? const SizedBox()
                                                        : Text(
                                                            "Cart Total: ₹ ${prescription.total}",
                                                          ),
                                                    const SizedBox(height: 10),
                                                    prescription.status ==
                                                            'pending'
                                                        ? const SizedBox()
                                                        : TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                          kGreen),
                                                              shape:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              uploadPrescription
                                                                  .addPrescriptionToCart(
                                                                      prescription
                                                                          .id);
                                                            },
                                                            child: SizedBox(
                                                              height: 40,
                                                              width: 200,
                                                              child: Center(
                                                                child: uploadPrescription
                                                                            .isLoadingButton
                                                                            .value &&
                                                                        uploadPrescription.isLoadingButtonId.value ==
                                                                            prescription.id
                                                                    ? const KLoadingCircular(
                                                                        color:
                                                                            kWhite,
                                                                      )
                                                                    : const Text(
                                                                        "Add all items to cart",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              kWhite,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
