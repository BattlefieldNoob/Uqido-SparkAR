import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uqido_sparkar/blocs/sparkar_bloc.state.dart';
import 'package:uqido_sparkar/view/common/home_app_bar.dart';
import 'package:uqido_sparkar/view/sparkar/user_effects_detail.dart';

import 'desktop_navigation_rail.dart';

class DesktopHomePage extends StatelessWidget {
  final SparkARState state;
  final List<NavigationRailDestination> destinations;
  final bool isTablet;

  const DesktopHomePage(this.state, this.destinations, this.isTablet)
      : super(key: null);

  @override
  Widget build(BuildContext context) {
    final navigationRail = state.maybeMap(
        valid: (validState) {
          return validState.userList.length != 0
              ? DesktopNavigationRail(
                  destinations, validState.selected, isTablet)
              : Material(
                  color: Color.fromRGBO(48, 54, 60, .9),
                  elevation: 4,
                  child: SizedBox(
                    width: isTablet ? 92 : 350,
                  ),
                );
        },
        orElse: () => Material(
              color: Color.fromRGBO(48, 54, 60, .9),
              elevation: 4,
              child: SizedBox(
                width: isTablet ? 92 : 350,
              ),
            ));

    final scaffoldDetail = state.map(
        valid: (validState) {
          return validState.userList.length != 0 && validState.selected >= 0
              ? Expanded(
                  child: UserEffectDetail(
                      validState.userList[validState.selected]))
              : SizedBox();
        },
        loading: (loadingState) => SizedBox(),
        error: (errorState) => Expanded(child: Text("Error, please reload")),
        logout: (value) => SizedBox());

    return Scaffold(
        appBar: HomeAppBar(),
        body: Row(children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                color: Theme.of(context).navigationRailTheme.backgroundColor,
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(child: navigationRail),
                  ),
                ),
              );
            },
          ), //,
          scaffoldDetail
        ]));
  }
}
