part of '../statistics_tab.dart';

class _StatisticsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mockStatisticList.length + 1,
      separatorBuilder: (context, i) => SizedBox(height: 1.0),
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final locale = DiaLocalizations.of(context);

    if(index == mockStatisticList.length) {
      return SizedBox(height: 72.0);
    }
    final item = mockStatisticList[index];
    return Material(
      color: item.color,
      child: ListTile(
        subtitle: Text(item.getDateTime(locale)),
        title: Text(item.getBloodSugar(locale)),
        trailing: Text(item.getDiagnosis(locale)),
      ),
    );
  }
}
