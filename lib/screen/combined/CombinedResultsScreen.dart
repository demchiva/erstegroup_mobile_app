// Flutter imports:
import 'package:erstegroup_api_consumer/util/modal/ModalUtils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:erstegroup_api_consumer/model/combined/CombinedResult.dart';
import 'package:erstegroup_api_consumer/model/combined/wrapper/CombinedResultWrapper.dart';
import 'package:erstegroup_api_consumer/provider/combined/CombinedResultsProvider.dart';

/// The screen shows combined results and gives interact to user.
class CombinedResultsScreen extends StatefulWidget {
  const CombinedResultsScreen({Key? key}) : super(key: key);

  @override
  _CombinedResultsScreenState createState() => _CombinedResultsScreenState();
}

class _CombinedResultsScreenState extends State<CombinedResultsScreen> {
  static const String _APP_BAR_NAME = 'Combined Result List';
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    CombinedResultProvider.me.loadCombinedResults();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_APP_BAR_NAME),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ModalUtils.me.showSimpleTextField(_controller, context);
            CombinedResultProvider.me
                .loadCombineResultsWithAmount(
              _controller.value.text,
            )
                .catchError((e) async {
              _controller.text = '';
              await ModalUtils.me.showSimpleAlertAsync(e.toString(), context);
            });
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<CombinedResultProvider>(
      builder: (_, final CombinedResultProvider provider, __) =>
          provider.wrapper == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _buildList(provider.wrapper!.combinedResultsWrappers),
    );
  }

  Widget _buildList(List<CombinedResultWrapper> combinedResultsWrappers) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(13),
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.only(top: 5),
          expansionCallback: (int index, bool shouldShowContent) {
            setState(() {
              combinedResultsWrappers[index].shouldShowContent =
                  !shouldShowContent;
            });
          },
          children: combinedResultsWrappers
              .map((final CombinedResultWrapper wrapper) => ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        _buildHeader(wrapper.combinedResult),
                    body: _buildBodyList(wrapper),
                    isExpanded: wrapper.shouldShowContent,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildHeader(final CombinedResult combinedResult) => ListTile(
        title: Text(
          combinedResult.accountNumber,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );

  Widget _buildBodyList(final CombinedResultWrapper combinedResultWrapper) {
    final List<Widget> actionsList = [];
    for (int i = 0;
        i < combinedResultWrapper.combinedResult.combinedProducts.length;
        i++) {
      actionsList.add(
        SizedBox(
          width: 325,
          child: Row(
            children: [
              SizedBox(
                width: 325,
                child: ListTile(
                  title: Text(
                    combinedResultWrapper
                        .combinedResult.combinedProducts[i].description,
                  ),
                  subtitle: Text(
                    combinedResultWrapper
                        .combinedResult.combinedProducts[i].place,
                  ),
                  leading: Text(
                    combinedResultWrapper
                        .combinedResult.combinedProducts[i].amount
                        .ceil()
                        .toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: combinedResultWrapper.shouldShowContent
          ? Container(
              margin: EdgeInsets.only(top: 12),
              child: Column(children: [
                ...actionsList,
              ]),
            )
          : Container(),
    );
  }
}
