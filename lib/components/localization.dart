//localization and internalization
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclients/i18n_web_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'container.dart';

abstract class I18NMessagesState {
  const I18NMessagesState();
}

class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;
  const LoadedI18NMessagesState({@required I18NMessages messages})
      : _messages = messages;
}

class I18NMessages {
  final Map<String, dynamic> _messages;
  I18NMessages(this._messages);
  String get(String key) {
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

class ErrorI18NMessagesState extends I18NMessagesState {
  const ErrorI18NMessagesState();
}

class LocalizationContainer extends BlocContainer {
  final Widget child;
  LocalizationContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CurrentLocaleCubit(),
      child: this.child,
    );
    // return BlocProvider<CurrentLocaleCubit>(
    //   create: (context) => CurrentLocaleCubit(),
    //   child: this.child,
    // );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("pt-br");
}

class ViewI18N {
  String _language;

  ViewI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, dynamic> values) {
    assert(values != null);
    assert(values.containsKey(_language));
    return values[_language];
  }
}

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
          final messages = state._messages;
          return creator.call(messages);
        }
        return ErrorView("Erro buscando mensagens da tela");
      },
    );
  }
}

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  I18NMessagesCubit() : super(InitI18NMessagesState());

  void reload(I18NWebClient client) {
    emit(LoadingI18NMessagesState());

    client.findAll().then((messages) => emit(
          LoadedI18NMessagesState(
            messages: I18NMessages(messages),
          ),
        ));
  }
}

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator creator;
  final String viewKey;
  I18NLoadingContainer({@required this.viewKey, @required this.creator});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (context) {
        final cubit = I18NMessagesCubit();
        cubit.reload(I18NWebClient(this.viewKey));
        return cubit;
      },
      child: I18NLoadingView(this.creator),
    );
  }
}
