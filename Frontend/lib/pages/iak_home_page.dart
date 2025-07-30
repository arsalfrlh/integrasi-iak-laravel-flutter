import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob/pages/pricelist_iak_page.dart';
import 'package:ppob/pages/pricelist_page.dart';
import 'package:ppob/services/api_service.dart';

class IakHomePage extends StatefulWidget {
  const IakHomePage({super.key});

  @override
  State<IakHomePage> createState() => _IakHomePageState();
}

class _IakHomePageState extends State<IakHomePage> {
  final ApiService apiService = ApiService();
  final typeController = TextEditingController();
  final operatorController = TextEditingController();

  void _pricelist(BuildContext context) async {
    if (typeController.text.isNotEmpty && operatorController.text.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PricelistIakPage(type: typeController.text, operator: operatorController.text)));
    }
  }

  void _cekBalance(BuildContext context)async{
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(),));

    final response = await apiService.getBalanceIAK();
    Navigator.of(context, rootNavigator: true).pop();

    if(response['data']['message'] == 'SUCCESS'){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "Sukses",
        desc: "Berhasil menampilkan saldo anda ${response['data']['balance']}",
        btnOkOnPress: (){},
      ).show();
    }else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: "Error",
        desc: response['message'].toString(),
        btnOkOnPress: (){},
        btnOkColor: Colors.red,
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7643),
        title: const Text(
          "Pilih Type dan Oprator",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () => _cekBalance(context), icon: Icon(Icons.money))
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  ForgotPasswordForm(
                    type: typeController,
                    operator: operatorController,
                    pricelist: () => _pricelist(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({required this.type, required this.operator, required this.pricelist});
  final TextEditingController type, operator;
  final VoidCallback pricelist;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final Map<String, dynamic> typeOptions = {
    "pulsa": "Pulsa",
    "data": "Paket Data",
    "etoll": "E Money",
    "voucher": "Voucher",
    "game": "Top Up",
    "pln": "PLN",
  };

  final Map<String, dynamic> pulsaOptions = {
    "axis": "Axis",
    "indosat": "Indosat",
    "smart": "Smartfren",
    "telkomsel": "Telkomses",
    "three": "Three",
    "xixi_games": "Xixi Game",
    "xl": "XL",
    "by.U": "By.U",
  };

  final Map<String, dynamic> dataOptions = {
    "axis_paket_internet": "Paket Axis",
    "telkomsel": "Telkomsel",
    "indosat_paket_internet": "Paket Indosat",
    "smartfren_paket_internet": "Paket Smartfren",
    "tri_paket_internet": "Paket Tri",
    "telkomsel_paket_internet": "Paket Telkomsel",
    "xl_paket_internet": "Paket XL",
  };

  final Map<String, dynamic> voucherOptions = {
    "alfamart": "Alfamaret",
    "carrefour": "Carrefour",
    "indomaret": "Indomaret",
    "map": "Map",
    "tokopedia": "Tokopedia",
    "traveloka": "Travelokas",
    "udemy": "Undemy",
  };

  final Map<String, dynamic> eMoneyOptions = {
    "dana": "DANA",
    "mandiri_e-toll": "Mandiri e-Toll",
    "indomaret_card_e-money": "Indomaret Card e-Money",
    "gopay_e-money": "GoPay e-Money",
    "linkaja": "LinkAja",
    "ovo": "OVO",
    "shopee_pay": "ShopeePay",
    "tix_id": "TIX ID",
  };

  final Map<String, dynamic> gameAndEntertainmentOptions = {
    "arena_of_valor": "Arena of Valor",
    "battlenet_sea": "Battle.net SEA",
    "bleach_mobile_3d": "Bleach Mobile 3D",
    "call_of_duty_mobile": "Call of Duty Mobile",
    "dragon_nest_m_-_sea": "Dragon Nest M - SEA",
    "era_of_celestials": "Era of Celestials",
    "free_fire": "Free Fire",
    "garena": "Garena",
    "gemscool": "Gemscool",
    "genshin_impact": "Genshin Impact",
    "google_play_us_region": "Google Play (US Region)",
    "google_play_indonesia": "Google Play (Indonesia)",
    "itunes_us_region": "iTunes (US Region)",
    "lyto": "LYTO",
    "joox": "JOOX",
    "megaxus": "Megaxus",
    "mobile_legend": "Mobile Legends",
    "razer_pin": "Razer Pin",
    "playstation": "PlayStation",
    "steam_sea": "Steam SEA",
    "wave_game": "Wave Game",
    "league_of_legends_wild_rift": "League of Legends: Wild Rift",
    "lifeafter": "LifeAfter",
    "light_of_thel:_glory_of_cepheus": "Light of Thel: Glory of Cepheus",
    "lords_mobile": "Lords Mobile",
    "marvel_super_war": "Marvel Super War",
    "minecraft": "Minecraft",
    "netflix": "Netflix",
    "nintendo_eshop": "Nintendo eShop",
    "point_blank": "Point Blank",
    "pubg_mobile": "PUBG Mobile",
    "pubg_pc": "PUBG PC",
    "ragnarok_m": "Ragnarok M",
    "skyegrid": "Skyegrid",
    "speed_drifters": "Speed Drifters",
    "vidio": "Vidio",
    "viu": "Viu",
    "wifi_id": "WiFi ID",
  };

  final Map<String, dynamic> plnOptions = {
    "pln": "Token Listrik PLN",
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: widget.type.text.isNotEmpty
            ? widget.type.text
            : null,
            items: typeOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.type.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Type"),
          ),
          SizedBox(height: 24,),
          if(widget.type.text == 'pulsa')
          DropdownButtonFormField<String>(
            value: widget.operator.text.isNotEmpty
            ? widget.operator.text
            : null,
            items: pulsaOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.operator.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Operator"),
          ),
          if(widget.type.text == 'etoll')
          DropdownButtonFormField<String>(
            value: widget.operator.text.isNotEmpty
            ? widget.operator.text
            : null,
            items: eMoneyOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.operator.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Operator"),
          ),
          if(widget.type.text == 'data')
          DropdownButtonFormField<String>(
            value: widget.operator.text.isNotEmpty
            ? widget.operator.text
            : null,
            items: dataOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.operator.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Operator"),
          ),
          if(widget.type.text == 'pln')
          DropdownButtonFormField<String>(
            value: widget.operator.text.isNotEmpty
            ? widget.operator.text
            : null,
            items: plnOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.operator.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Operator"),
          ),
          if(widget.type.text == 'game')
          DropdownButtonFormField<String>(
            value: widget.operator.text.isNotEmpty
            ? widget.operator.text
            : null,
            items: gameAndEntertainmentOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.operator.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Operator"),
          ),
          if(widget.type.text == 'voucher')
          DropdownButtonFormField<String>(
            value: widget.operator.text.isNotEmpty
            ? widget.operator.text
            : null,
            items: voucherOptions.entries.map((entry){
                return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                );
            }).toList(),
            onChanged: (String? newValue){
                setState(() {
                  widget.operator.text = newValue!;
                });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            hint: const Text("Pilih Operator"),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ElevatedButton(
            onPressed: widget.pricelist,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFFF7643),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}

// Icons
const mailIcon =
    '''<svg width="15" height="18" viewBox="0 0 15 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M9.24419 11.5472C9.24419 12.4845 8.46279 13.2453 7.5 13.2453C6.53721 13.2453 5.75581 12.4845 5.75581 11.5472C5.75581 10.6098 6.53721 9.84906 7.5 9.84906C8.46279 9.84906 9.24419 10.6098 9.24419 11.5472ZM13.9535 14.0943C13.9535 15.6863 12.6235 16.9811 10.9884 16.9811H4.01163C2.37645 16.9811 1.04651 15.6863 1.04651 14.0943V9C1.04651 7.40802 2.37645 6.11321 4.01163 6.11321H10.9884C12.6235 6.11321 13.9535 7.40802 13.9535 9V14.0943ZM4.53488 3.90566C4.53488 2.31368 5.86483 1.01887 7.5 1.01887C8.28488 1.01887 9.03139 1.31943 9.59477 1.86028C10.1564 2.41387 10.4651 3.14066 10.4651 3.90566V5.09434H4.53488V3.90566ZM11.5116 5.12745V3.90566C11.5116 2.87151 11.0956 1.89085 10.3352 1.14028C9.5686 0.405 8.56221 0 7.5 0C5.2875 0 3.48837 1.7516 3.48837 3.90566V5.12745C1.52267 5.37792 0 7.01915 0 9V14.0943C0 16.2484 1.79913 18 4.01163 18H10.9884C13.2 18 15 16.2484 15 14.0943V9C15 7.01915 13.4773 5.37792 11.5116 5.12745Z" fill="#757575"/>
</svg>''';
