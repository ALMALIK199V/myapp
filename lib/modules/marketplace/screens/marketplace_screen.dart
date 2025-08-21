import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techfix_pro/modules/marketplace/bloc/marketplace_bloc.dart';
import 'package:techfix_pro/modules/marketplace/widgets/product_card.dart';
import 'package:techfix_pro/modules/marketplace/widgets/category_filter.dart';
import 'package:techfix_pro/modules/marketplace/widgets/search_bar.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MarketplaceBloc()..add(LoadProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('متجر قطع الغيار'),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ],
        ),
        body: Column(
          children: [
            const SearchBarWidget(),
            const CategoryFilterWidget(),
            Expanded(
              child: BlocBuilder<MarketplaceBloc, MarketplaceState>(
                builder: (context, state) {
                  if (state is MarketplaceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MarketplaceLoaded) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: state.products[index]);
                      },
                    );
                  } else if (state is MarketplaceError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}