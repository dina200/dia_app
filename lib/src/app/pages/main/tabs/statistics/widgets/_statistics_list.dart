part of '../statistics_tab.dart';

class _StatisticsList extends StatefulWidget {
  @override
  _StatisticsListState createState() => _StatisticsListState();
}

class _StatisticsListState extends State<_StatisticsList> {

  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mockStatisticList.length + 1,
      separatorBuilder: (context, i) => SizedBox(height: 1.0),
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if(index == mockStatisticList.length) {
      return SizedBox(height: 72.0);
    }
    final item = mockStatisticList[index];
    return Material(
      color: item.color,
      child: ListTile(
        subtitle: Text(item.getDateTime(_locale)),
        title: Text(item.getBloodSugar(_locale)),
        trailing: Text(item.getDiagnosis(_locale)),
      ),
    );
  }
}



