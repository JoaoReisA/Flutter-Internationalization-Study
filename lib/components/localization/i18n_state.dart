import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:meta/meta.dart';
@immutable
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
  final I18NMessages messages;
  const LoadedI18NMessagesState({@required  this.messages});
    
}

class ErrorI18NMessagesState extends I18NMessagesState {
  const ErrorI18NMessagesState();
}