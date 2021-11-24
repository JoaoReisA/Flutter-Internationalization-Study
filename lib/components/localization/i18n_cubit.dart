import 'package:bytebank/components/localization/i18n_state.dart';
import 'package:bytebank/http/webclients/i18n_web_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'i18n_messages.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage("local_unsecure_version_1.json");
  final String viewKey;
  I18NMessagesCubit(this.viewKey) : super(InitI18NMessagesState());

  void reload(I18NWebClient client) async{
    emit(LoadingI18NMessagesState());
    await storage.ready;
    final items = storage.getItem("$viewKey");
    if (items != null) {
      emit(
        LoadedI18NMessagesState(
          messages: I18NMessages(items),
        ),
      );
      return;
    }
    client.findAll().then(saveAndRefresh);
  }

  saveAndRefresh(Map<String, dynamic> messages) {
    storage.setItem(viewKey, messages);
    emit(
      LoadedI18NMessagesState(
        messages: I18NMessages(messages),
      ),
    );
  }
}