import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/post.dart';
class LikesChart extends StatelessWidget {
  final List<Post> posts;

  LikesChart({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: getMaxLikes(), // Implement this function to get the maximum likes
          barGroups: getBarGroups(), // Implement this function to get the bar groups
          titlesData: FlTitlesData(
            //eftTitles: SideTitles(showTitles: true),
            //bottomTitles: SideTitles(showTitles: true, getTitles: getTitles),
          ),
        ),
      ),
    );
  }

  double getMaxLikes() {
    // Implement this function to calculate the maximum likes from the posts
    return posts.map((post) => post.likes.toDouble()).reduce((a, b) => a > b ? a : b);
  }

  List<BarChartGroupData> getBarGroups() {
    // Implement this function to convert posts data to bar chart group data
    return posts.asMap().entries.map((entry) {
      final int x = entry.key;
      final double y = entry.value.likes.toDouble();
      return BarChartGroupData(
        x: x,
        barRods: [BarChartRodData(toY: y, color: Colors.blue,)],
      );
    }).toList();
  }

  String getTitles(double value) {
    // Implement this function to convert numerical values to string titles for the bottom axis
    return value.toInt().toString();
  }
}
