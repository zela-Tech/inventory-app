import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/item_model.dart';
import '../services/firestore_service.dart';

class ItemFormScreen extends StatefulWidget {
  final Item? item;
  final FirestoreService service;

  const ItemFormScreen({super.key, this.item, required this.service});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _categoryCtrl;
  late final TextEditingController _quantityCtrl;
  late final TextEditingController _priceCtrl;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.item?.name ?? '');
    _categoryCtrl = TextEditingController(text: widget.item?.category ?? '');
    _quantityCtrl =TextEditingController(text: widget.item?.quantity.toString() ?? '');
    _priceCtrl =TextEditingController(text: widget.item?.price.toString() ?? '');
  }
  @override
  void dispose() {
    _nameCtrl.dispose();
    _categoryCtrl.dispose();
    _quantityCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          child: ListView(
            children: [
              TextFormField(
                controller:_nameCtrl,
                decoration: const InputDecoration(labelText: 'Item name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:_categoryCtrl,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:_quantityCtrl,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:_priceCtrl,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child:const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}