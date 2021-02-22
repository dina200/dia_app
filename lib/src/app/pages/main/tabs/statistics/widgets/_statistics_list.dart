part of '../statistics_tab.dart';

class _StatisticsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MainPagePresenter>();
    final statistic = watch.bloodSugarStatistic ?? [];

    return ListView.separated(
      itemCount: statistic.length + 1,
      separatorBuilder: (context, i) => SizedBox(height: 1.0),
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final locale = DiaLocalizations.of(context);
    final read = context.read<MainPagePresenter>();
    final statistic = read.bloodSugarStatistic ?? [];

    if(index == statistic.length) {
      return SizedBox(height: 72.0);
    }

    final item = statistic[index];
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
