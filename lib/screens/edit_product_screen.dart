import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  
  var _editedProduct = Product(title: '', imageUrl: '', id: null, description: '', price: 0) ;

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm(){
    final isValid = _form.currentState.validate();
    if(!isValid)return;
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return 'Please provide a value.';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Title',),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(title: value,price: _editedProduct.price,id: null,description: _editedProduct.description,imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price',),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter a price';
                  }
                  if(double.tryParse(value) == null){
                    return 'Please enter a valid number.';
                  }
                  if(double.parse(value) <= 0){
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(title: _editedProduct.title,price: double.parse(value),id: null,description: _editedProduct.description,imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description',),
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                onSaved: (value){
                  _editedProduct = Product(title: _editedProduct.title,price: _editedProduct.price,id: null,description: value,imageUrl: _editedProduct.imageUrl);
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter a description.';
                  }
                  if(value.length < 10){
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8,right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty ? Text('Enter A URL') : FittedBox(child: Image.network(_imageUrlController.text,fit: BoxFit.cover,),),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_)=> _saveForm(),
                      onSaved: (value){
                        _editedProduct = Product(title: _editedProduct.title,price: _editedProduct.price,id: null,description: _editedProduct.description,imageUrl: value);
                      },
                      validator: (val){
                        if(val.isEmpty){
                          return 'PLease enter an image URL';
                        }
                        if(!val.startsWith('http') && !val.startsWith('https')){
                          return 'Please enter a valid URL.';
                        }
                        if(!val.endsWith('.png') && !val.endsWith('.jpg') && !val.endsWith('.jpeg')){
                          return 'Please enter a valid image URL';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
