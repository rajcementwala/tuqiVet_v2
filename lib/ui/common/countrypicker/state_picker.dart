import 'package:flutter/material.dart';

import '../../../core/utils/app_font_styles.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/container_box.dart';
import '../../../core/utils/enum.dart';
import '../../../ui/common/app_text_field.dart';

import 'countries_info.dart';

class StatePickerView extends StatefulWidget {
  const StatePickerView({
    required this.onSelectState,
    required this.states,
    super.key,
  });

  final List<StateInfo> states;
  final void Function(StateInfo) onSelectState;

  @override
  State<StatePickerView> createState() => _StatePickerViewState();
}

class _StatePickerViewState extends State<StatePickerView> {
  @override
  void initState() {
    super.initState();
  }

  /* Widget get child {
    return Container(
      constraints: const BoxConstraints(minWidth: 30),
      child: Text(
        widget.selectedCountry?.phoneCode ?? '',
        style: AppFontTextStyles.textPoppinsMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _StateList(
              states: widget.states,
              onSelectState: widget.onSelectState,
            );
          },
        );
      },
      child: Container(),
    );
  }
}

class _StateList extends StatefulWidget {
  const _StateList({
    required this.states,
    required this.onSelectState,
  });

  final List<StateInfo> states;
  final void Function(StateInfo) onSelectState;

  @override
  State<_StateList> createState() => __StateListState();
}

class __StateListState extends State<_StateList> {
  final searchController = TextEditingController();
  List<StateInfo> states = [];
  List<StateInfo> searchStates = [];

  @override
  void initState() {
    super.initState();
    states = widget.states;
    searchStates = widget.states;
    searchController.addListener(
      () {
        final text = searchController.text.trim().toLowerCase();
        searchStates = states.where((element) {
          return (element.name.toLowerCase().startsWith(text) ||
              element.code.toLowerCase().startsWith(text));
        }).toList();
        if (text.isEmpty) {
          searchStates = states;
        }
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Map<int, TableColumnWidth>? get columnWidths {
    return const {
      0: FlexColumnWidth(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Flexible(
                  child: _SearchBar(
                    searchTextEditingController: searchController,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: 40,
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: searchStates.length,
                itemBuilder: (_, index) {
                  final state = searchStates[index];
                  return InkWell(
                    onTap: () {
                      widget.onSelectState.call(state);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.top,
                        columnWidths: columnWidths,
                        children: [
                          _rowData(state),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return const SizedBox(height: 8);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _rowData(StateInfo state) {
    return TableRow(
      children: [
        Text(
          state.name,
          maxLines: 2,
          style: AppFontTextStyles.textNormal.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.searchTextEditingController,
  });
  final TextEditingController searchTextEditingController;

  @override
  Widget build(BuildContext context) {
    return ContainerBox(
      /* decoration: const BoxDecoration(
        color: AppColors.ffF3F3F3,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ), */
      child: AppTextField(
        textEditingController: searchTextEditingController,
        placeHolder: 'Search state...',
        type: TextFieldType.divider,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}
