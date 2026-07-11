import 'package:cryptobazzar_refactor_clean_arch/core/constants/app_colors.dart';
import 'package:cryptobazzar_refactor_clean_arch/domain/entities/crypto.dart';
import 'package:cryptobazzar_refactor_clean_arch/presentation/coin_list/bloc/bloc/coin_list_bloc.dart';
import 'package:cryptobazzar_refactor_clean_arch/presentation/coin_list/widget/crypto_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinListScreen extends StatelessWidget {
  const CoinListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoinListBloc()..add(CoinFetchListEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: blackColor,
          appBar: _appBarWidget(),
          body: SafeArea(
            child: Column(
              children: [
                _searchBarWidget(context),
                Expanded(
                  child: BlocConsumer<CoinListBloc, CoinListState>(
                    listener: (context, state) {
                      if (state is CoinListFailedState) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) => RefreshIndicator(
                      backgroundColor: greenColor,
                      color: blackColor,
                      onRefresh: () async {
                        context.read<CoinListBloc>().add(CoinFetchListEvent());
                      },
                      child: _buildByState(state: state),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      backgroundColor: blackColor,
      title: Text(
        'کیریپتو بازار',
        style: TextStyle(fontFamily: 'mr', color: Colors.white),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildByState({required CoinListState state}) {
    return switch (state) {
      CoinListInitialState() => SizedBox.shrink(),

      CoinLoadingState() => _loadingWidget(),

      CoinListSuccessState() => _CoinListView(ctyptos: state.cryptos),

      CoinListFailedState() => failedWidget(state),
    };
  }

  Text failedWidget(CoinListFailedState state) {
    return Text(
      state.message,
      style: TextStyle(color: greenColor, fontFamily: 'mr'),
    );
  }

  Widget _loadingWidget() {
    return Center(child: SpinKitWave(color: Colors.white, size: 30.0));
  }

  Padding _searchBarWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          onChanged: (value) {
            _filterList(value, context);
          },
          decoration: InputDecoration(
            hintText: 'اسم رمزارز معتبر را سرچ کنید... ',
            hintStyle: TextStyle(fontFamily: 'iranYekan', color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 26, 182, 135),
          ),
          cursorColor: Colors.white,

          style: TextStyle(color: Colors.white, fontFamily: 'iranYekan'),
        ),
      ),
    );
  }

  Future<void> _filterList(String enteredKeyword, BuildContext context) async {
    context.read<CoinListBloc>().add(
      CoinFilterListEvent(searchQuery: enteredKeyword),
    );
  }
}

class _CoinListView extends StatelessWidget {
  final List<Crypto> ctyptos;
  const _CoinListView({required this.ctyptos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ctyptos.length,
      itemBuilder: (context, index) => CryptoItem(crypto: ctyptos[index]),
    );
  }
}
