import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:visual_cache/visual_cache.dart';

class VisualCacheWidget extends StatelessWidget {
  final List<String>? subdirectories;

  const VisualCacheWidget({super.key, this.subdirectories});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: VisualCache().getCacheSizeDetails(subdirectories: subdirectories),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Convert the data to a format suitable for the pie chart
          final dataMap = <String, double>{

          };
          snapshot.data!.forEach((key, value) {
            dataMap[key] = value / (1024 * 1024).toDouble(); // Size in MB
          });

          double totalSizeInMB = dataMap.values.fold(0, (sum, item) => sum + item);

          return PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: '${totalSizeInMB.toStringAsFixed(2)} MB',
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
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
