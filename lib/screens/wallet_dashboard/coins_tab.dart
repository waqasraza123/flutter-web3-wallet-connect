import 'package:flutter/material.dart';
import '../../utils/api_data.dart';
import 'package:logger/logger.dart';

class CoinsTab extends StatelessWidget {
  const CoinsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final topTokens = ApiData.topTokens;
    Logger logger = Logger();
    logger.i(topTokens);

    return ListView.builder(
      itemCount: topTokens.length,
      itemBuilder: (context, index) {
        final token = topTokens[index];
        return ListTile(
          leading: token['imageUrl'] != null
              ? Image.network(token['imageUrl']!, width: 40, height: 40)
              : const Icon(Icons.image_not_supported),
          title: Row(
            children: [
              Expanded(
                  child: Text(token['name'],
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Text(
                '${token['change']}%',
                style: TextStyle(
                  color: token['change'] >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price: \$${token['price'].toStringAsFixed(2)}'),
              Text(
                  '${token['currentAmount']} / \$${token['currentBalance'].toStringAsFixed(2)}'),
            ],
          ),
        );
      },
    );
  }
}
