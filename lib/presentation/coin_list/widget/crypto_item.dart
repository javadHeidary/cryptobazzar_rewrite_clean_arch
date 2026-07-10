import 'package:cryptobazzar_refactor_clean_arch/core/constants/app_colors.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:flutter/material.dart';

class CryptoItem extends StatelessWidget {
  final Crypto crypto;

  const CryptoItem({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: greenColor),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: greyColor),
        overflow: TextOverflow.ellipsis,
      ),
      leading: SizedBox(
        width: 30.0,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: greyColor),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    crypto.priceUsd.toStringAsFixed(2),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    crypto.changePercent24hr.toStringAsFixed(2),
                    style: TextStyle(
                      color: _getColorChangeText(crypto.changePercent24hr),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8), // Add some spacing
            SizedBox(
              width: 30, // Reduced width to prevent overflow
              child: Center(
                child: _getIconChangePercent(crypto.changePercent24hr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getIconChangePercent(double percentChange) {
  return percentChange <= 0
      ? Icon(Icons.trending_down, size: 24, color: redColor)
      : Icon(Icons.trending_up, size: 24, color: greenColor);
}

Color _getColorChangeText(double percentChange) {
  return percentChange <= 0 ? redColor : greenColor;
}
