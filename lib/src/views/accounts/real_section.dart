import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rrfx/src/components/alerts/scaffold_messanger_alert.dart';
import 'package:rrfx/src/components/bottomsheets/material_bottom_sheets.dart';
import 'package:rrfx/src/components/colors/default.dart';
import 'package:rrfx/src/controllers/trading.dart';
import 'package:rrfx/src/helpers/formatters/number_formatter.dart';
import 'package:rrfx/src/views/accounts/account_information.dart';
import 'package:rrfx/src/views/settings/documents.dart';
import 'package:rrfx/src/views/trade/deposit.dart';
import 'package:rrfx/src/views/trade/withdrawal.dart';
import 'components/card_info_account.dart';
import 'package:get/get.dart';
import 'create_real.dart';

RxList<Map<String, RxBool>> accountActive = <Map<String, RxBool>>[].obs;

class RealSection extends StatefulWidget {
  const RealSection({super.key});

  @override
  State<RealSection> createState() => _RealSectionState();
}

class _RealSectionState extends State<RealSection> {
  TradingController tradingController = Get.put(TradingController());

  @override
  void initState() {
    super.initState();
    if(accountActive.isEmpty){
      accountActive.value = [];
      if(tradingController.tradingAccountModels.value?.response.real != null){
        for(int i = 0; i < tradingController.tradingAccountModels.value!.response.real!.length; i++){
          accountActive.add({
            "active": false.obs,
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: CustomColor.secondaryColor,
      onRefresh: () async {},
      child: Obx(
        (){
          if(tradingController.isLoading.value){
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text("Getting Real Account...")),
            );
          }else if(tradingController.tradingAccountModels.value?.response.demo?.length != 0 && tradingController.tradingAccountModels.value?.response.real?.length == 0){
            return SizedBox(
              width: double.infinity,
              height: double.maxFinite,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardInfoAccount(isDemo: false)
                    ],
                  ),
                ),
              ),
            );
          }
          return Obx(
            () => ListView(
              children: List.generate((tradingController.tradingAccountModels.value?.response.real?.length ?? 0) + 1, (i){
                final realAccounts = tradingController.tradingAccountModels.value?.response.real ?? [];
                if(i == realAccounts.length){
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => const CreateReal());
                      },
                      icon: Icon(Icons.add_circle_outlined, color: Colors.white),
                      label: Text("Buat Akun Real Baru"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.secondaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  );
                }
                return Obx(
                  () => cardAccountReal(
                    onTap: (){
                      CustomMaterialBottomSheets.defaultBottomSheet(
                        context,
                        size: size,
                        title: "Hubungkan Akun ${tradingController.tradingAccountModels.value?.response.real?[i].login} untuk memulai trading?",
                        isScrolledController: false,
                        children: [
                          Obx(
                            () => ListTile(
                              leading: Icon(Bootstrap.plug, color: CustomColor.secondaryColor),
                              title: accountActive[i]['active']?.value == true ? Text("Disconnect") : Text("Connect"),
                              trailing: Obx(
                                () => Switch(
                                  activeColor: CustomColor.secondaryColor,
                                  value: accountActive[i]['active']!.value,
                                  onChanged: (value) {
                                    accountActive[i]['active']!.value = !accountActive[i]['active']!.value;
                                    if(value){
                                      tradingController.connectTradingAccount(accountId: tradingController.tradingAccountModels.value!.response.real![i].id!).then((result){
                                        print(result['status']);
                                        Get.back();
                                        if(!result['status'] && result['message'] == "Invalid Account, please update your account password"){
                                          CustomScaffoldMessanger.showAppSnackBar(context, message: result['message'], type: SnackBarType.success);
                                          showPasswordDialog(context, tradingController.tradingAccountModels.value!.response.real![i].id!);
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]
                      );
                    },
                    isConnected: accountActive[i]['active']!.value,
                    accountNumber: tradingController.tradingAccountModels.value?.response.real?[i].login,
                    type: tradingController.tradingAccountModels.value?.response.real?[i].namaTipeAkun,
                    balance: tradingController.tradingAccountModels.value?.response.real?[i].balance,
                    currencyType: tradingController.tradingAccountModels.value?.response.real?[i].currency,
                    leverage: "1:${tradingController.tradingAccountModels.value?.response.real?[i].leverage}"
                  ),
                );
              }),
            ),
          );
        }
      ),
    );
  }

  CupertinoButton cardAccountReal({String? accountNumber, String? leverage, String? balance, String? type, String? currencyType, bool isConnected = false, VoidCallback? onTap}){
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: (){
        Get.to(() => AccountInformation(loginID: accountNumber));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(color: CustomColor.secondaryBackground)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currencyType != null ? currencyType.toUpperCase() : "-", style: GoogleFonts.inter(fontSize: 13, color: CustomColor.secondaryColor)),
                // Image.asset('assets/icons/ic_launcher.png', width: 50)
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: isConnected ? Colors.green : Colors.grey.shade500)
                    ),
                    child: Row(
                      children: [
                        isConnected ? Icon(Icons.circle, size: 14.0, color: Colors.green) : Icon(Icons.circle, size: 14.0, color: Colors.grey.shade500),
                        const SizedBox(width: 5.0),
                        isConnected ? Text("Connected", style: GoogleFonts.inter(color: Colors.green)) : Text("Disconnected", style: GoogleFonts.inter(color: Colors.grey.shade500))
                      ],
                    ),
                  ),
                )
              ],
            ),
      
            // Number Account
            Icon(Icons.candlestick_chart, color: CustomColor.secondaryColor, size: 24),
            const SizedBox(height: 10),
            Text(accountNumber != null ? NumberFormatter.formatCardNumber(accountNumber) : "0", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.secondaryColor), maxLines: 1),
            const SizedBox(height: 5),
            Text(balance == null ? "\$0" : "\$${balance.split('.').first}", style: GoogleFonts.inter(fontSize: 15, color: CustomColor.secondaryColor)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(type != null ? type.toUpperCase() : "-", style: GoogleFonts.inter(fontSize: 13, color: CustomColor.secondaryColor)),
                Text(" / ", style: GoogleFonts.inter(fontSize: 13, color: Colors.black54)),
                Text(leverage != null ? leverage.split('.').first : "1:100", style: GoogleFonts.inter(fontSize: 13, color: CustomColor.secondaryColor)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(() => const Deposit());
                  },
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.arrow_down_circle, color: CustomColor.secondaryColor),
                      const SizedBox(width: 2),
                      Text("Deposit", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: CustomColor.secondaryColor))
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: (){
                    Get.to(() => const Withdrawal());
                  },
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.arrow_up_circle, color: CustomColor.secondaryColor),
                      const SizedBox(width: 2),
                      Text("Withdrawal", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: CustomColor.secondaryColor))
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: (){
                    Get.to(() => Documents(loginID: accountNumber));
                  },
                  child: Row(
                    children: [
                      Icon(MingCute.pdf_line, color: CustomColor.secondaryColor),
                      Text("Documents", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: CustomColor.secondaryColor))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

void showPasswordDialog(BuildContext context, String accountID){
  final TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Masukkan Password'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.secondaryColor
            ),
            onPressed: () async {
              String password = passwordController.text;
              print(password);
              tradingController.inputPassword(accountId: accountID, password: password).then((result){
                print(result['message']);
                if(result['status']){
                  CustomScaffoldMessanger.showAppSnackBar(context, message: result['message'], type: SnackBarType.success);
                }
              });
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: Text('Submit', style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

}
