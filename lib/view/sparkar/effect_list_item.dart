import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:uqido_sparkar/model/sparkar_effect.dart';

import 'effect_visibility_status.dart';

part 'effect_list_item.g.dart';
part 'effect_list_item.viewmodel.dart';

const Color disabledColor = const Color.fromRGBO(48, 46, 50, 1.0);

class EffectListItem extends StatelessWidget {
  final SparkAREffect effect;

  const EffectListItem({Key? key, required this.effect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EffectCardScaffold(
      child: ListTile(
        dense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Neumorphic(
            child: Image.network(
          effect.iconUrl,
          width: 48,
          height: 48,
        )),
        title: Text(effect.name),
        subtitle: EffectVisibilityStatus(effect.submissionStatus,
            effect.visibilityStatus, effect.isDeprecated),
        trailing: FittedBox(
            alignment: Alignment.centerRight,
            child: Row(children: [
              ClickableIcon(Icons.public_rounded, effect.publicLink,
                  enabled: mapStatusToBool(effect)),
              const SizedBox(
                width: 8,
              ),
              ClickableIcon(Icons.home, effect.testLink, primary: false)
            ])),
      ),
    );
  }
}

@swidget
Widget clickableIcon(BuildContext context, IconData icon, String url,
    {bool enabled = true, bool primary = true}) {
  var enabledColor = Theme.of(context).accentColor;

  return NeumorphicButton(
    child: NeumorphicIcon(icon,
        size: 32,
        style: NeumorphicStyle(color: enabled ? Colors.grey : Colors.black38)),
    onPressed: enabled ? () => print("pressed!") : null,
  );
}

@swidget
Widget effectCardScaffold({required Widget child}) {
  return Neumorphic(margin: EdgeInsets.symmetric(vertical: 8), child: child);
}
