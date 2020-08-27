// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  // TODO: Make a collection of cards (102)
  // ********* Custom hidden API to generate cards to GridView's children field ************
  // column widget used to lay out the child widgets vertically
  // crossAxisAlignment: field specifies .start, which means align text to the leading edge
  // AspectRatio: widget decides what shape the image takes no matter what kind of image is supplied
  // Padding: brings the text in from the side a little
  // The two Text widgets are stacked vertically with 8 points of empty spaces between them (SizedBox). We make another column to house them inside the Padding.
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                // TODO: Adjust the box size (102)
                // Need this to fit image to card width wise. Default is 4 points of padding on top and bottom if not specified
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: Change innermost Column (103)
                  children: <Widget>[
                    // TODO: Handle overflowing labels (103)
                    Text(
                      product.name,
                      style: theme.textTheme.headline6,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  } //end method _buildGridCards()

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      // TODO: Add app bar (102)
      appBar: AppBar(
        // TODO: Add buttons and title (102)
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              semanticLabel:
                  'menu', // used to add accessiblity info in Flutter. Used for screen readers
            ),
            onPressed: () {
              print('Menu button');
            }),
        title: Text('Shrine'),
        // TODO: Add trailing buttons (102)
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      // TODO: Add a grid view (102)
      // Invoke the count() method on GridView since the num of items it displays is countable and not infinite
      // padding: field  provides space on all 4 sides of the GridView
      // childAspectRatio: field identifies the size of the items based on an aspect ratio (width over height). Default is same size cards
      // child's width: ([width of the entire grid] - [left padding] - [right padding]) / number of columns
      // childs's height: ([width of the entire grid] - 16 - 16) / 2 * 9 / 8
      body: GridView.count(
        crossAxisCount: 2, // how many cards across the screen
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        // TODO: Build a grid of cards (102)
        children: _buildGridCards(context),
      ),
      // TODO: Set resizeToAvoidBottomInset (101)
      //doing this ensures that the keyboard's appearance does not alter the size of the home page or its widgets.
      resizeToAvoidBottomInset: false,
    );
  }
}
