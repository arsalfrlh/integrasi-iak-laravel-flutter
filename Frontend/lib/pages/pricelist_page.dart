import 'package:flutter/material.dart';
import 'package:ppob/models/pricelist.dart';
import 'package:ppob/pages/beli_page.dart';
import 'package:ppob/services/api_service.dart';

class PricelistPage extends StatefulWidget {
  PricelistPage({required this.type, required this.operator});
  final String type, operator;

  @override
  State<PricelistPage> createState() => _PricelistPageState();
}

class _PricelistPageState extends State<PricelistPage> {
  final ApiService apiService = ApiService();
  List<Pricelist> priceList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPriceList();
  }

  Future<void> fetchPriceList() async {
    setState(() {
      isLoading = true;
    });
    priceList = await apiService.getAllPriceList(widget.type, widget.operator);
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BeliPage(pricelist: priceList[index]))).then((_) => fetchPriceList());
                    },
                    child: OrderedItemCard(
                      pricelist: priceList[index],
                    ),
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
  const OrderedItemCard({required this.pricelist});
  final Pricelist pricelist;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 8),
        const Divider(),
      ],
    );
  }
}
