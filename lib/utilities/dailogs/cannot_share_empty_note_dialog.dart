import 'package:flutter/material.dart';

import 'package:notetaker/utilities/dailogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) async {
  return showGenericDailog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
