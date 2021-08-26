import 'package:flutter/material.dart';
import 'example_data.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.cyanAccent.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTileHeader(context),
          _buildFoodTileList(context),
        ],
      ),
    );
  }

  Widget _buildFoodTileList(BuildContext context) {
    return Column(
      children: List.generate(
        category.foods.length,
        (index) {
          final food = category.foods[index];
          bool isLastIndex = index == category.foods.length - 1;
          return _buildFoodTile(
            food: food,
            context: context,
            isLastIndex: isLastIndex,
          );
        },
      ),
    );
  }

  Widget _buildSectionTileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _sectionTitle(context),
        const SizedBox(height: 8.0),
        category.subtitle != null ? _sectionSubtitle(context) : const SizedBox(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    return Row(
      children: [
        if (category.isHotSale) _buildSectionHoteSaleIcon(),
        Text(
          category.title,
          style: _textTheme(context).headline6,
        )
      ],
    );
  }

  Widget _sectionSubtitle(BuildContext context) {
    return Text(
      category.subtitle!,
      style: _textTheme(context).subtitle2,
    );
  }

  Widget _buildFoodTile({
    required BuildContext context,
    required bool isLastIndex,
    required Food food,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFoodDetail(food: food, context: context),
            _buildFoodImage(food.imageUrl),
          ],
        ),
        !isLastIndex ? const Divider(height: 16.0) : const SizedBox(height: 8.0)
      ],
    );
  }

  Widget _buildFoodImage(String url) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/transparent.png',
      image: url,
      width: 64,
    );
  }

  Widget _buildFoodDetail({
    required BuildContext context,
    required Food food,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(food.name, style: _textTheme(context).subtitle1),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              "特價" + food.price + " ",
              style: _textTheme(context).caption,
            ),
            Text(
              food.comparePrice,
              style: _textTheme(context).caption?.copyWith(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(width: 8.0),
            if (food.isHotSale) _buildFoodHotSaleIcon(),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHoteSaleIcon() {
    return Container(
      margin: const EdgeInsets.only(right: 4.0),
      child: Icon(
        Icons.whatshot,
        color: Colors.pink,
        size: 20.0,
      ),
    );
  }

  Widget _buildFoodHotSaleIcon() {
    return Container(
      child: Icon(Icons.whatshot, color: Colors.pink, size: 16.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  TextTheme _textTheme(context) => Theme.of(context).textTheme;
}
