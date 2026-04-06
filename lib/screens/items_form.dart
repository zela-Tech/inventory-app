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
  bool _isLoading = false;

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final item = Item(
      id: widget.item?.id ?? '',
      name: _nameCtrl.text.trim(),
      category: _categoryCtrl.text.trim(),
      quantity: int.parse(_quantityCtrl.text.trim()),
      price: double.parse(_priceCtrl.text.trim()),
    );

    try {
      if (widget.item == null) {
        await widget.service.addItem(item);
      } else {
        await widget.service.updateItem(item);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Item' : 'Add Item'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          child: ListView(
            children: [
              TextFormField(
                controller:_nameCtrl,
                decoration: const InputDecoration(labelText: 'Item name'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Name cannot be empty';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:_categoryCtrl,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Category cannot be empty';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:_quantityCtrl,
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Quantity cannot be empty';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller:_priceCtrl,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Price cannot be empty';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
              ? const Center(child: CircularProgressIndicator())
              : FilledButton(
                onPressed: _submit,
                child: Text(isEditing ?'Save changes' : 'Add item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}