import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

class FirestoreService {
  final CollectionReference _itemsRef =
      FirebaseFirestore.instance.collection('items');

  //create
  Future<void> addItem(Item item) async {
    await _itemsRef.add(item.toMap());
  }

  //read
  Stream<List<Item>> streamItems() {
    return _itemsRef.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Item.fromMap(doc.id,doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }
  // delete
  Future<void> deleteItem(String id) async {
    await _itemsRef.doc(id).delete();
  }

  //update
  Future<void> updateItem(Item item) async {
    await _itemsRef.doc(item.id).update(item.toMap());
  }

  
}