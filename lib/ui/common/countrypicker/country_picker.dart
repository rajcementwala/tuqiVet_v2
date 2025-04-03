import 'package:flutter/material.dart';

import '../../../core/utils/app_font_styles.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/container_box.dart';
import '../../../core/utils/enum.dart';
import '../../../ui/common/app_text_field.dart';

import 'countries_info.dart';

enum CountryPickerComponet {
  all,
  onlyCountryName,
  onlyCountryNameWithFlag,
}

class CountryPickerView extends StatefulWidget {
  const CountryPickerView({
    required this.onSelectCountry,
    required this.isEnable, this.selectedCountry,
    this.componet = CountryPickerComponet.all,
    super.key,
  });
  final CountryInfo? selectedCountry;
  final void Function(CountryInfo) onSelectCountry;
  final CountryPickerComponet componet;
  final bool isEnable;

  @override
  State<CountryPickerView> createState() => _CountryPickerViewState();
}

class _CountryPickerViewState extends State<CountryPickerView> {
  CountriesInfo countriesInfo = CountriesInfo();

  @override
  void initState() {
    super.initState();
  }

  Widget get child {
    if (widget.componet == CountryPickerComponet.onlyCountryNameWithFlag) {
      return Container();
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 30),
      child: Row(
        spacing: 10,
        children: [
          const SizedBox(width: 5,),
          Text(
            widget.selectedCountry?.flag ?? '',
            style: AppFontTextStyles.textMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.blackTextColor,
            ),
          ),
          Container(width: 2,height: 30,color: AppColors.primary.withAlpha(30),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.isEnable){
          FocusManager.instance.primaryFocus?.unfocus();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return _CountryList(
                countriesInfo: countriesInfo,
                onSelectCountry: widget.onSelectCountry,
                componet: widget.componet,
              );
            },
          );
        }
      },
      child: child,
    );
  }
}

class _CountryList extends StatefulWidget {
  const _CountryList({
    required this.countriesInfo,
    required this.onSelectCountry,
    required this.componet,
  });

  final CountriesInfo countriesInfo;
  final void Function(CountryInfo) onSelectCountry;
  final CountryPickerComponet componet;

  @override
  State<_CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<_CountryList> {
  final searchController = TextEditingController();
  List<CountryInfo> countries = [];
  List<CountryInfo> searchCountries = [];

  @override
  void initState() {
    super.initState();
    countries = widget.countriesInfo.countries;
    searchCountries = widget.countriesInfo.countries;
    searchController.addListener(
      () {
        final text = searchController.text.trim().toLowerCase();
        searchCountries = countries.where((element) {
          return (element.name.toLowerCase().startsWith(text) ||
              element.code.toLowerCase().startsWith(text));
        }).toList();
        if (text.isEmpty) {
          searchCountries = countries;
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
    if (widget.componet == CountryPickerComponet.onlyCountryName) {
      return const {
        0: FlexColumnWidth(),
      };
    } else if (widget.componet ==
        CountryPickerComponet.onlyCountryNameWithFlag) {
      return const {
        0: FixedColumnWidth(40.0),
        1: FlexColumnWidth(),
      };
    }
    return const {
      0: FlexColumnWidth(0.9),
      1: FlexColumnWidth(0.6),
      2: FlexColumnWidth(4),
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
                      color: AppColors.primary,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: searchCountries.length,
                itemBuilder: (_, index) {
                  final country = searchCountries[index];
                  return InkWell(
                    onTap: () {
                      widget.onSelectCountry.call(country);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.top,
                        columnWidths: columnWidths,
                        children: [
                          _rowData(country),
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

  TableRow _rowData(CountryInfo country) {
    if (widget.componet == CountryPickerComponet.onlyCountryName) {
      return TableRow(
        children: [
          Text(
            country.name,
            maxLines: 2,
            style: AppFontTextStyles.textNormal.copyWith(
              color: AppColors.blackTextColor,
            ),
          ),
        ],
      );
    } else if (widget.componet ==
        CountryPickerComponet.onlyCountryNameWithFlag) {
      return TableRow(
        children: [
          Text(
            country.flag,
            style: AppFontTextStyles.textNormal.copyWith(
              color: AppColors.blackTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            country.name,
            maxLines: 2,
            style: AppFontTextStyles.textNormal.copyWith(
              color: AppColors.blackTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
    return TableRow(
      children: [
        Text(
          country.phoneCode,
          style: AppFontTextStyles.textNormal.copyWith(
            color: AppColors.blackTextColor,
          ),
        ),
        Text(
          country.flag,
          style: AppFontTextStyles.textNormal.copyWith(
            color: AppColors.blackTextColor,
          ),
        ),
        Text(
          country.name,
          maxLines: 2,
          style: AppFontTextStyles.textNormal.copyWith(
            color: AppColors.blackTextColor,
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
        placeHolder: 'Search country...',
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
