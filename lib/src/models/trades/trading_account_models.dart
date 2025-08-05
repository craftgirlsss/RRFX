class TradingAccountModels {
  TradingAccountModels({
    required this.response,
  });

  late final Response response;

  TradingAccountModels.fromJson(Map<String, dynamic> json){
    response = Response.fromJson(json);
  }
}

class Response {
  Response({
    required this.real,
    required this.demo,
  });
  List<Real>? real;
  List<Demo>? demo;

  Response.fromJson(Map<String, dynamic> json){
    real = json['real'] == [] ? null : List.from(json['real']).map((e)=>Real.fromJson(e)).toList();
    demo = json['demo'] == [] ? null : List.from(json['demo']).map((e)=>Demo.fromJson(e)).toList();
  }
}

class Demo {
  Demo({
    this.id,
    this.login,
    this.type,
    this.namaTipeAkun,
    this.rate,
    this.marginFree,
    this.marginFreePercent,
    this.balance,
    this.leverage,
    this.pnl,
    this.currency,
    this.totalDeposit,
    this.totalWithdrawal,
    this.minDeposit,
    this.minTopup,
    this.minWithdrawal,
    this.maxWithdrawal,
  });
  String? id;
  String? login;
  String? type;
  String? namaTipeAkun;
  String? rate;
  int? marginFree;
  int? marginFreePercent;
  String? balance;
  String? leverage;
  String? pnl;
  String? currency;
  String? totalDeposit;
  String? totalWithdrawal;
  String? minDeposit;
  String? minTopup;
  String? minWithdrawal;
  String? maxWithdrawal;

  Demo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    login = json['login'];
    type = json['type'];
    namaTipeAkun = json['nama_tipe_akun'];
    rate = json['rate'];
    marginFree = json['margin_free'];
    marginFreePercent = json['margin_free_percent'];
    balance = json['balance'];
    leverage = json['leverage'];
    pnl = json['pnl'];
    currency = json['currency'];
    totalDeposit = json['total_deposit'];
    totalWithdrawal = json['total_withdrawal'];
    minDeposit = json['min_deposit'];
    minTopup = json['min_topup'];
    minWithdrawal = json['min_withdrawal'];
    maxWithdrawal = json['max_withdrawal'];
  }
}

class Real {
  Real({
    this.id,
    this.login,
    this.type,
    this.namaTipeAkun,
    this.rate,
    this.marginFree,
    this.marginFreePercent,
    this.balance,
    this.leverage,
    this.pnl,
    this.currency,
    this.totalDeposit,
    this.totalWithdrawal,
    this.minDeposit,
    this.minTopup,
    this.minWithdrawal,
    this.maxWithdrawal,
  });
  String? id;
  String? login;
  String? type;
  String? namaTipeAkun;
  String? rate;
  int? marginFree;
  int? marginFreePercent;
  String? balance;
  String? leverage;
  String? pnl;
  String? currency;
  String? totalDeposit;
  String? totalWithdrawal;
  String? minDeposit;
  String? minTopup;
  String? minWithdrawal;
  String? maxWithdrawal;

  Real.fromJson(Map<String, dynamic> json){
    id = json['id'];
    login = json['login'];
    type = json['type'];
    namaTipeAkun = json['nama_tipe_akun'];
    rate = json['rate'];
    marginFree = json['margin_free'];
    marginFreePercent = json['margin_free_percent'];
    balance = json['balance'];
    leverage = json['leverage'];
    pnl = json['pnl'];
    currency = json['currency'];
    totalDeposit = json['total_deposit'];
    totalWithdrawal = json['total_withdrawal'];
    minDeposit = json['min_deposit'];
    minTopup = json['min_topup'];
    minWithdrawal = json['min_withdrawal'];
    maxWithdrawal = json['max_withdrawal'];
  }
}