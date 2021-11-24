import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'i18n_cubit.dart';
import 'i18n_messages.dart';
import 'i18n_state.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator creator;

  const I18NLoadingView(this.creator, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI18NMessagesState ||
            state is LoadingI18NMessagesState) {
          return ProgressView();
        }
        if (state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return creator.call(messages);
        }
        return ErrorView("Erro buscando mensagens da tela");
      },
    );
  }
}

typedef Widget I18NWidgetCreator(I18NMessages messages);
