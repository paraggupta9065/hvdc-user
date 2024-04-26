import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hvdc_user/models/prescription.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/card.dart';
import 'package:hvdc_user/utils/loading.dart';

import '../controllers/upload_prescription.dart';
import '../utils/colors.dart';

class PrescriptionList extends StatefulWidget {
  const PrescriptionList({super.key});

  @override
  State<PrescriptionList> createState() => _PrescriptionListState();
}

class _PrescriptionListState extends State<PrescriptionList> {
  UploadPrescriptionC uploadPrescription = Get.put(UploadPrescriptionC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        "Upload Prescription",
      ),
      body: Obx(
        () => uploadPrescription.isLoading.value
            ? const KLoading()
            : ListView.builder(
                itemCount: uploadPrescription.prescriptions.length,
                itemBuilder: (BuildContext context, int index) {
                  Prescription prescription =
                      uploadPrescription.prescriptions[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: kContainer(
                      child: ListTile(
                          title: Text(
                            prescription.status == 'pending'
                                ? "Your prescription analysis is pending."
                                : "Your prescription has been created successfully.",
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                "Prescription ID: ${prescription.id}",
                              ),
                              prescription.status == 'pending'
                                  ? const SizedBox()
                                  : Text(
                                      "Cart Total: ₹ ${prescription.total}",
                                    ),
                              const SizedBox(height: 10),
                              Obx(
                                () => prescription.status == 'pending'
                                    ? const SizedBox()
                                    : TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(kGreen),
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12)))),
                                        ),
                                        onPressed: () {
                                          uploadPrescription
                                              .addPrescriptionToCart(
                                                  prescription.id);
                                        },
                                        child: SizedBox(
                                          height: 40,
                                          width: double.maxFinite,
                                          child: Center(
                                            child: uploadPrescription
                                                        .isLoadingButton
                                                        .value &&
                                                    uploadPrescription
                                                            .isLoadingButtonId
                                                            .value ==
                                                        prescription.id
                                                ? const KLoadingCircular(
                                                    color: kWhite,
                                                  )
                                                : const Text(
                                                    "Add all items to cart",
                                                    style: TextStyle(
                                                      color: kWhite,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
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
    );
  }
}
