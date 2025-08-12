import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrfx/src/components/alerts/default.dart';
import 'package:rrfx/src/components/appbars/default.dart';
import 'package:rrfx/src/components/colors/default.dart';
import 'package:rrfx/src/components/painters/loading_water.dart';
import 'package:rrfx/src/controllers/trading.dart';
import 'package:rrfx/src/views/accounts/demo_section.dart';
import 'package:rrfx/src/views/accounts/pending_account.dart';
import 'package:rrfx/src/views/accounts/real_section.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String selected = "Real";
  RxBool isLoading = false.obs;
  TradingController tradingController = Get.put(TradingController());

  @override
  void initState() {
    super.initState();
    tradingController.getTradingAccount().then((result){
      if(!result){
        CustomAlert.alertError(message: tradingController.responseMessage.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: CustomAppBar.defaultAppBar(
              autoImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("List Trading", style: GoogleFonts.inter(fontSize: 50, fontWeight: FontWeight.w700, color: CustomColor.secondaryColor, height: 0.5)),
                          Text("account", style: GoogleFonts.inter(fontSize: 50, fontWeight: FontWeight.w700, color: Colors.black)),
                          const SizedBox(height: 5.0),
                          Text("Daftar akun trading yang anda miliki. Anda dapat menggunakan untuk trading dengan platform MetaTrader 5 dan RRFX App.", style: TextStyle(color: CustomColor.textThemeLightSoftColor, fontSize: 15)),
                        ],
                      ),
                    ),
                    Obx(
                      () => tradingController.tradingAccountModels.value?.response.demo == null ? const SizedBox() : SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () {
                                    if(tradingController.tradingAccountModels.value?.response.demo?.length == 0){
                                      return SegmentedButton<String>(
                                        style: SegmentedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          textStyle: GoogleFonts.inter(color: Colors.white)
                                        ),
                                        segments: const <ButtonSegment<String>>[
                                          ButtonSegment(
                                            value: 'Demo',
                                            label: Text('Demo'),
                                          ),
                                        ],
                                        selected: <String>{selected},
                                        onSelectionChanged: (newSelection) {
                                          setState(() {
                                            selected = newSelection.first;
                                          });
                                        },
                                        multiSelectionEnabled: false,
                                        showSelectedIcon: false,
                                      );
                                    }
                                    return SegmentedButton<String>(
                                      style: SegmentedButton.styleFrom(
                                        side: BorderSide(color: CustomColor.secondaryColor),
                                        backgroundColor: Colors.transparent,
                                        textStyle: GoogleFonts.inter(color: Colors.white)
                                      ),
                                      segments: const <ButtonSegment<String>>[
                                        ButtonSegment(
                                          value: 'Real',
                                          label: Text('Real'),
                                        ),
                                        ButtonSegment(
                                          value: 'Demo',
                                          label: Text('Demo'),
                                        ),
                                        ButtonSegment(
                                          value: 'Pending',
                                          label: Text('Pending'),
                                        ),
                    
                                      ],
                                      selected: <String>{selected},
                                      onSelectionChanged: (newSelection) {
                                        setState(() {
                                          selected = newSelection.first;
                                        });
                                      },
                                      multiSelectionEnabled: false,
                                      showSelectedIcon: false,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Obx(() {
                if(tradingController.isLoading.value){
                  return SizedBox();
                }else if(selected == "Demo"){
                  return DemoSection();
                }else if(selected == "Real"){
                  return RealSection();
                }else if(selected == "Pending"){
                  return PendingAccount();
                }else{
                  return SizedBox(
                    child: Text("Tidak dikenali"),
                  );
                }
              }),
            ),
            // body: Obx(() => tradingController.isLoading.value ? const SizedBox() : selected == "Demo" ? DemoSection() : RealSection())
          ),
          Obx(() => tradingController.isLoading.value ? LoadingWater() : const SizedBox())
        ],
      ),
    );
  }
}


