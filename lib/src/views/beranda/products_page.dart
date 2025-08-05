import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrfx/src/components/colors/default.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Produk'),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: CustomColor.secondaryColor),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: CustomColor.backgroundIcon,
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
            tabs: [
              Tab(text: 'Forex'),
              Tab(text: 'Komoditas'),
              Tab(text: 'Indeks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProductList('Forex'),
            _buildProductList('Komoditas'),
            _buildProductList('Indeks'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(String category) {
    final items = [
      {'pair': 'EURUSD', 'bid': '1.15581', 'ask': '1.15582', 'flag': '🇪🇺🇺🇸'},
      {'pair': 'GBPUSD', 'bid': '1.32783', 'ask': '1.32785', 'flag': '🇬🇧🇺🇸'},
      {'pair': 'USDJPY', 'bid': '147.906', 'ask': '147.91', 'flag': '🇺🇸🇯🇵'},
    ]; // Dummy data

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Text(item['flag']!, style: TextStyle(fontSize: 24)),
            title: Text(item['pair']!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Bid: ${item['bid']} | Ask: ${item['ask']}'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              // Aksi saat item diklik
            },
          ),
        );
      },
    );
  }
}
