class Pricelist {
  final String codeProduk;
  final String? namaProduk;
  final String? detailProduk;
  final int? harga;
  final String? kostumerID;

  Pricelist({required this.codeProduk, this.namaProduk, this.detailProduk, this.harga, this.kostumerID});
  factory Pricelist.fromJson(Map<String, dynamic> json){
    return Pricelist(
      codeProduk: json['product_code'],
      namaProduk: json['product_description'],
      detailProduk: json['product_details'],
      harga: json['product_price'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "code": codeProduk,
      "costumer_id": kostumerID,
    };
  }
}
