import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final myProducts = List<String>.generate(1000, (i) => 'Product $i');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf3f6fb),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.person))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Statistics',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                    width: double.infinity,
                    height: 270,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 6),
                              blurRadius: 6)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartBar(
                          data: [
                            {
                              'id': 'Bar 1',
                              'data': [
                                {'domain': '2019', 'measure': 3},
                                {'domain': '2020', 'measure': 3},
                                {'domain': '2021', 'measure': 4},
                                {'domain': '2022', 'measure': 6},
                                {'domain': '2023', 'measure': 0.3},
                              ],
                            },
                            {
                              'id': 'Bar 2',
                              'data': [
                                {'domain': '2020', 'measure': 4},
                                {'domain': '2021', 'measure': 5},
                                {'domain': '2022', 'measure': 2},
                                {'domain': '2023', 'measure': 1},
                                {'domain': '2024', 'measure': 2.5},
                              ],
                            },
                          ],
                          yAxisTitle: 'Year',
                          xAxisTitle: 'Sale',
                          measureMin: 0,
                          measureMax: 8,
                          minimumPaddingBetweenLabel: 1,
                          domainLabelPaddingToAxisLine: 16,
                          axisLineTick: 2,
                          axisLinePointTick: 2,
                          axisLinePointWidth: 10,
                          axisLineColor: Colors.orange,
                          measureLabelPaddingToAxisLine: 16,
                          barColor: (barData, index, id) => id == 'Bar 1'
                              ? Colors.green.shade300
                              : Colors.orangeAccent,
                          barValue: (barData, index) =>
                              '${barData['measure']}%',
                          showBarValue: true,
                          barValuePosition: BarValuePosition.outside,
                          verticalDirection: false,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 16),
                child: Text("Historique",
                    style: TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.normal)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5, left: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: myProducts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        // In many cases, the key isn't mandatory
                        key: UniqueKey(),
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(myProducts[index])),
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}
