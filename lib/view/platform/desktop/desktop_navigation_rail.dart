import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:uqido_sparkar/blocs/sparkar_bloc.actions.dart';
import 'package:uqido_sparkar/blocs/sparkar_bloc.dart';

part 'desktop_navigation_rail.g.dart';

class DesktopNavigationRail extends StatefulWidget {
  final List<NavigationRailDestination> destinations;
  final int selected;
  final bool isTablet;

  DesktopNavigationRail(this.destinations, this.selected, this.isTablet);

  @override
  _DesktopNavigationRailState createState() => _DesktopNavigationRailState();
}

class _DesktopNavigationRailState extends State<DesktopNavigationRail> {
  late bool extended;

  @override
  void initState() {
    super.initState();
    extended = !widget.isTablet;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        destinations: widget.destinations,
        backgroundColor: Color(0xFF3E3E3E),
        elevation: 0,
        minWidth: 92,
        extended: widget.isTablet ? false : extended,
        minExtendedWidth: 350,
        leading: widget.isTablet
            ? null
            : DesktopHeader(extended, () {
                setState(() {
                  if (!widget.isTablet) {
                    extended = !extended;
                  }
                });
              }),
        labelType: NavigationRailLabelType.none,
        onDestinationSelected: (index) =>
            context.read<SparkARBloc>().add(SparkARAction.selectUser(index)),
        selectedIndex: widget.selected);
  }
}

@swidget
Widget desktopHeader(bool extended, Function() onToggle) {
  return SizedBox(
      height: 56,
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkResponse(
            borderRadius: BorderRadius.circular(5),
            child: TextButton.icon(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(16))),
              icon: Icon(extended ? Icons.arrow_left : Icons.arrow_right),
              label: Text(extended ? "Chiudi" : "Apri"),
              onPressed: onToggle,
            )),
      ));
}
