import 'package:dartz/dartz.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../domain/entities/category_feature.dart';
import '../manager/category_cubit.dart';
import '../manager/category_state.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> _path = [];
  String? _selectedBrandId;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CategoryCubit>();
    if (cubit.state is! CategoryLoaded && cubit.state is! CategoryLoading) {
      cubit.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (_, state) {
        if (state is CategoryLoading)
          return const Center(child: CircularProgressIndicator());
        if (state is CategoryError) return Center(child: Text(state.message));
        if (state is CategoryLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<CategoryCubit>().load(refresh: true);
            },
            child: _buildScaffold(state.feature),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildScaffold(FeaturePack f) {
    final atRoot = _path.isEmpty && _selectedBrandId == null;;
    final title = _selectedBrandId != null
        ? f.brands.firstWhere((b) => b.id == _selectedBrandId).name
        : atRoot
        ? 'Categories'
        : f.categories.firstWhere((c) => c.id == _path.last).title;

    return Scaffold(
      appBar: AppBar(
        leading: (!atRoot || _selectedBrandId != null)
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() {
            if (_selectedBrandId != null) {
              _selectedBrandId = null;
            } else if (_path.isNotEmpty) {
              _path.removeLast();
            }
          },
          ),
        )
            : null,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _selectedBrandId != null
            ? _brandProductGrid(f, _selectedBrandId!)
            : (atRoot ? _rootView(f) : _drillView(f, _path.last)),
      ),
    );
  }

  Widget _rootView(FeaturePack f) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Brands',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: f.brands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final b = f.brands[i];
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedBrandId = b.id;
                  _path.clear(); // Optional: clear category path if brand is tapped
                }),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 28,
                      backgroundImage: NetworkImage(
                        scale: 550,
                        '${Constants.baseURL}/${b.logo}',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(b.name, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Expanded(child: _categoryGrid(f.categories)),
      ],
    );
  }

  Widget _drillView(FeaturePack f, String parentId) {
    // sub-categories under this node?
    final subs = f.categories.where((c) {
      return f.products.any(
        (p) =>
            (p.categoryId == parentId && p.subCategoryId == c.id) ||
            (p.subCategoryId == parentId && p.childCategoryId == c.id),
      );
    }).toList();

    if (subs.isNotEmpty) {
      return _categoryGrid(subs);
    }

    // else show products under this node
    final prods = f.products.where((p) {
      return p.categoryId == parentId && p.subCategoryId == null;
    }).toList();

    return _productGrid(prods);
  }

  Widget _categoryGrid(List list) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final c = list[i];
        return GestureDetector(
          onTap: () => setState(() => _path.add(c.id)),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '${Constants.baseURL}/${c.icon}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(c.title, textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  Widget _productGrid(List prods) {
    return GridView.builder(
      itemCount: prods.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (_, i) {
        final p = prods[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                '${Constants.baseURL}/${p.thumbImage}',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(p.name, maxLines: 2),
            const SizedBox(height: 2),
            Text(
              '\$${p.offerPrice ?? p.price}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  Widget _brandProductGrid(FeaturePack f, String brandId) {
    // You may need to adjust the property name if it's not brandId in your ProductEntity
    final prods = f.products.where((p) => p.brandId == brandId).toList();
    if (prods.isEmpty) {
      return const Center(child: Text('No products found for this brand.'));
    }
    return _productGrid(prods); // Uses your existing product grid
  }
}
