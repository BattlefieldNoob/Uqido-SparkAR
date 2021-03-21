import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:uqido_sparkar/blocs/sparkar_bloc.actions.dart';
import 'package:uqido_sparkar/blocs/sparkar_bloc.dart';
import 'package:uqido_sparkar/view/common/search_app_bar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize {
    return Size.fromHeight(60.0);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
        primary: Theme.of(context).primaryColor,
        searchHint: "Cerca un effetto...",
        mainTextColor: Colors.white,
        onSubmit: (String value) {
          context.read<SparkARBloc>().add(SparkARAction.search(value));
        },
        //Will show when SEARCH MODE wasn't active
        mainAppBar: (stream, keyword) {
          return NeumorphicAppBar(
              title: NeumorphicText(
                'Uqido Spark AR',
                style: NeumorphicStyle(color: Colors.grey),
                textStyle: NeumorphicTextStyle(fontSize: 25),
              ),
              actions: [
                //NeumorphicButton(
                //  onPressed: () {
                //    final neumorphicTheme = NeumorphicTheme.of(context);
                //    if (neumorphicTheme!.isUsingDark) {
                //      neumorphicTheme.themeMode = ThemeMode.light;
                //    } else {
                //      neumorphicTheme.themeMode = ThemeMode.dark;
                //    }
                //  },
                //  style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                //  child: NeumorphicIcon(Icons.invert_colors,
                //      size: 32, style: NeumorphicStyle(color: Colors.grey)),
                //),
                NeumorphicButton(
                  onPressed: () {
                    stream.add(true);
                  },
                  style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                  child: NeumorphicIcon(Icons.search,
                      size: 32, style: NeumorphicStyle(color: Colors.grey)),
                )
              ]);
        });
  }
}
