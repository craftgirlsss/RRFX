class HistoryWithdrawDepositModel {
  HistoryWithdrawDepositModel({
    this.response,
  });
  List<Response>? response;
  
  HistoryWithdrawDepositModel.fromJson(Map<String, dynamic> json){
    response = List.from(json['response']).map((e)=>Response.fromJson(e)).toList();
  }
}

class Response {
  Response({
    this.id,
    this.type,
    this.login,
    this.amount,
    this.amountReceived,
    this.status,
    this.datetime,
  });
  String? id;
  String? type;
  String? login;
  String? amount;
  String? amountReceived;
  String? status;
  String? datetime;
  
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    login = json['login'];
    amount = json['amount'];
    amountReceived = json['amount_received'];
    status = json['status'];
    datetime = json['datetime'];
  }
}