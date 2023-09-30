import 'package:astrolex/app/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/institution/counts_by_year.dart';

class TrendIndicator extends StatelessWidget {
  final List<CountByYear> countsByYear;

  const TrendIndicator({super.key, required this.countsByYear});

  @override
  Widget build(BuildContext context) {
    countsByYear.sort((a, b) => a.year!.compareTo(b.year!));
    String trend = _calculateTrend();
    CountByYear mostPopular = countsByYear.reduce((a, b) => a.worksCount! > b.worksCount! ? a : b);
    CountByYear leastPopular = countsByYear.reduce((a, b) => a.worksCount! < b.worksCount! ? a : b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trend: $trend', style: context.bodyLarge.primary.bold),
          const SizedBox(height: 8),
          Text('Most Active Year: ${mostPopular.year} with ${mostPopular.worksCount!} publications', style: context.bodyMedium.primary),
          Text('Least Active Year: ${leastPopular.year} with ${leastPopular.worksCount!} publications', style: context.bodyMedium.secondary),
        ],
      ),
    );
  }

  String _calculateTrend() {
    if (countsByYear.first.worksCount! > countsByYear.last.worksCount!) {
      return "Declining";
    } else if (countsByYear.first.worksCount! < countsByYear.last.worksCount!) {
      return "Rising";
    } else {
      return "Stable";
    }
  }
}
