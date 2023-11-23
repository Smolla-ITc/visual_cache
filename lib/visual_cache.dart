library visual_cache;

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:visual_cache/core/visual_constants.dart';
import 'package:visual_cache/core/visual_core.dart';

class VisualCache extends StatelessWidget {
  final Map<String, String> namedSubdirectories;
  final List<Color> colorSubdirectories;
  final bool showLegends;

  const VisualCache({
    super.key,
    required this.namedSubdirectories,
    required this.colorSubdirectories,
    required this.showLegends,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: VisualCacheCore().getCacheSizeDetails(
          subdirectories: namedSubdirectories.keys.toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Convert the data to a format suitable for the pie chart
          final dataMap = <String, double>{};
          double totalSizeInBytes = 0;

          snapshot.data!.forEach((key, value) {
            // Use the custom name if provided, else use the key itself
            String displayName = namedSubdirectories[key] ?? key;
            dataMap[displayName] =
                value / (1024 * 1024).toDouble(); // Size in MB
            totalSizeInBytes += value.toDouble();
          });

          return PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            colorList: colorSubdirectories,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            ///Total size
            centerText: formatSize(totalSizeInBytes),

            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: showLegends,
              legendTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              decimalPlaces: 1,
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
