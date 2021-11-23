//localization and internalization
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'container.dart';

abstract class I18NMessagesState {
  const I18NMessagesState();
}

class LoadingI18NMessagesState extends I18NMessagesState{
  const LoadingI18NMessagesState();
}

class InitI18NMessagesState extends I18NMessagesState{
  const InitI18NMessagesState();
}

class LoadedI18NMessagesState extends I18NMessagesState{
  final I18NMessages _messages;
  const LoadedI18NMessagesState({@required I18NMessages messages}) : _messages = messages;
}

class I18NMessages {
  final Map<String, String> _messages;
  I18NMessages(this._messages);
  String get(String key){
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

class ErrorI18NMessagesState extends I18NMessagesState{
    const ErrorI18NMessagesState();
}



class LocalizationContainer extends BlocContainer {
  final Widget child;
  LocalizationContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: CurrentLocaleCubit(), child: this.child,);
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

  ViewI18N(BuildContext context){
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

    String localize(Map<String,String> values) {
    assert(values != null);
    assert(values.containsKey(_language));
    return values[_language];
  }
}

class I18NLoadingView extends StatelessWidget {
  const I18NLoadingView({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state){

        if(state is InitI18NMessagesState || state is LoadingI18NMessagesState){
          return ProgressView();
        }
        if(state is LoadedI18NMessagesState){
          return Container(
              //implementar tela
          );
        }
        return ErrorView("Erro buscando mensagens da tela");
      },
    );
  }
}