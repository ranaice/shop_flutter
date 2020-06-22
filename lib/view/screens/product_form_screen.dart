import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/product.dart';

class ProductFormScreen extends StatefulWidget {
  ProductFormScreen({Key key}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imgUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imgUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imgUrlFocus.removeListener(_updateImage);
    _imgUrlFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Título'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Informe um título válido!';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['title'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  validator: (value) {
                    var price = double.tryParse(value);
                    if (value.trim().isEmpty || price == null || price <= 0) {
                      return 'Informe preço válido!';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['price'] = double.parse(value),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: 3,
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) => _formData['description'] = value,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Informe um título válido!';
                    }

                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        focusNode: _imgUrlFocus,
                        decoration: InputDecoration(labelText: 'URL da Imagem'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value.trim().isEmpty || !_isValidImageUrl(value)) {
                            return 'Informe uma URL Válida!';
                          }

                          return null;
                        },
                        onSaved: (value) => _formData['imageUrl'] = value,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? Text('Informa a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final newProduct = Product(
        id: Random().nextDouble().toString(),
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        imageUrl: _formData['imageUrl'],
      );
    }
  }

  bool _isValidImageUrl(String url) {
    bool isValidProtocol = url.toLowerCase().startsWith('http://') || url.toLowerCase().startsWith('https://');
    bool isValidImageExt =
        url.toLowerCase().endsWith('.png') || url.toLowerCase().endsWith('.jpg') || url.toLowerCase().endsWith('.jpeg');

    return isValidProtocol && isValidImageExt;
  }

  void _updateImage() {
    if (_isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }
}
