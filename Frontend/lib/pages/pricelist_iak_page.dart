import 'package:flutter/material.dart';
import 'package:ppob/models/pricelist.dart';
import 'package:ppob/pages/beli_iak_page.dart';
import 'package:ppob/services/api_service.dart';

class PricelistIakPage extends StatefulWidget {
  const PricelistIakPage({required this.type, required this.operator});
  final String type, operator;

  @override
  State<PricelistIakPage> createState() => _PricelistIakPageState();
}

class _PricelistIakPageState extends State<PricelistIakPage> {
  final ApiService apiService = ApiService();
  List<Pricelist> priceList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPriceList();
  }

  Future<void> fetchPriceList()async{
    setState(() {
      isLoading = true;
    });
    priceList = await apiService.getAllPriceListIAK(widget.type, widget.operator);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7643),
        title: const Text("Daftar Produk"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // List of cart items
              ...List.generate(
                priceList.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: OrderedItemCard(
                    pricelist: priceList[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderedItemCard extends StatelessWidget {
  OrderedItemCard({
    required this.pricelist,
  });
  Pricelist pricelist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => BeliIakPage(pricelist: pricelist)));
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Produk: ${pricelist.namaProduk}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Deskripsi: ${pricelist.detailProduk}",
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Harga: ${pricelist.harga}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: const Color(0xFF22A45D)),
              )
            ],
          ),
        ],
      ),
    );
  }
}