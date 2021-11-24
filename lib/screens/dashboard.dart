import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/localization.dart';
import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Guilherme"),
      child: I18NLoadingContainer(
        viewKey: "dashboard",
         creator: (I18NMessages messages) => DashboardView(DashboardViewLazyI18n(messages))),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18n i18n;

  DashboardView(this.i18n);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            child: Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _FeatureItem(
                    i18n.transfer,
                    Icons.monetization_on,
                    onClick: () => _showContactsList(context),
                  ),
                  _FeatureItem(
                    i18n.transactionFeed,
                    Icons.description,
                    onClick: () => _showTransactionsList(context),
                  ),
                  _FeatureItem(
                    i18n.changeName,
                    Icons.person_outline,
                    onClick: () => _showChangeName(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext blocContext) {
    push(blocContext, ContactsListContainer());
  }

  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(blocContext),
          child: NameContainer(),
        ),
      ),
    );
  }

  _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class DashboardViewLazyI18n {
  final I18NMessages messages;
  DashboardViewLazyI18n(this.messages);

  String get transfer => 
  messages.get("transfer");
  // localize({"pt-br": "Transferir", "en": "Transfer"});
  String get transactionFeed =>
  messages.get("transactionFeed");
  // localize({"pt-br": "Transações", "en": "Transaction feed"});
  String get changeName =>
  messages.get("changeName");
  // localize({"pt-br": "Trocar Nome", "en": "Change Name"});
}

class DashboardViewI18n extends ViewI18N {
  DashboardViewI18n(BuildContext context) : super(context);

  String get transfer => localize({"pt-br": "Transferir", "en": "Transfer"});
  String get transactionFeed =>
      localize({"pt-br": "Transações", "en": "Transaction feed"});
  String get changeName =>
      localize({"pt-br": "Trocar Nome", "en": "Change Name"});
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(
    this.name,
    this.icon, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
