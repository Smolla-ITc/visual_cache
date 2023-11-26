library visual_cache;

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:visual_cache/core/visual_constants.dart';
import 'package:visual_cache/core/visual_core.dart';

/// A StatelessWidget that displays cache data using a Pie Chart.
/// It can display the data in real-time or fetch it once based on the isRealTime flag.
class VisualCache extends StatelessWidget {
  /// Map of subdirectory paths to their display names.
  final Map<String, String> namedSubdirectories;

  /// List of colors for each subdirectory in the pie chart.
  final List<Color> colorSubdirectories;

  /// Flag to indicate whether name directories should be shown in the chart.
  final bool showLegends;

  /// Flag to indicate whether the data should be fetched in real-time.
  final bool isRealTime;

  final TextStyle textStyle;

  const VisualCache({
    super.key,
    required this.namedSubdirectories,
    required this.colorSubdirectories,
    required this.showLegends,
    this.isRealTime = false, // Default value is false for one-time fetch.
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    /// Choose to build a real-time updating chart or a static one based on the isRealTime flag.
    return isRealTime ? buildStreamChartBuilder() : futureChartBuilder();
  }

  /// Builds a StreamBuilder for real-time updates.
  StreamBuilder<Map<String, int>> buildStreamChartBuilder() {
    /// StreamBuilder that subscribes to a stream of cache data.
    return StreamBuilder<Map<String, int>>(
      stream: VisualCacheCore().getCacheSizeStream(
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
            /// Use the custom name if provided, else use the key itself
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
            centerTextStyle: textStyle,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,

            /// Total size
            centerText: formatSize(totalSizeInBytes),
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: showLegends,
              legendTextStyle: textStyle,
            ),
            chartValuesOptions: ChartValuesOptions(
              chartValueStyle: textStyle,
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

  /// Builds a FutureBuilder for a one-time fetch.
  FutureBuilder<Map<String, int>> futureChartBuilder() {
    /// FutureBuilder that fetches cache size details once.
    return FutureBuilder<Map<String, int>>(
      /// Future providing one-time cache size details.
      future: VisualCacheCore().getCacheSizeDetails(
          subdirectories: namedSubdirectories.keys.toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          /// Convert the data to a format suitable for the pie chart
          final dataMap = <String, double>{};
          double totalSizeInBytes = 0;
          snapshot.data!.forEach((key, value) {
            /// Use the custom name if provided, else use the key itself
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

            /// Total size
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
