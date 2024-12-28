import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Map<String, dynamic> productData;
  ProductLoaded({required this.productData});
}

class ProductError extends ProductState {
  final String errorMessage;
  ProductError({required this.errorMessage});
}

abstract class ProductEvent {}

class LoadProductEvent extends ProductEvent {
  final String productId;
  LoadProductEvent({required this.productId});
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final doc = await FirebaseFirestore.instance
            .collection('products')
            .doc(event.productId)
            .get();
        if (doc.exists) {
          emit(ProductLoaded(productData: doc.data() as Map<String, dynamic>));
        } else {
          emit(ProductError(errorMessage: "Product not found."));
        }
      } catch (e) {
        emit(ProductError(errorMessage: e.toString()));
      }
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAPu02_4UpXHK5guF-L3mWbMH1ph1haGls",
        authDomain: "flutter-final-35fb6.firebaseapp.com",
        projectId: "flutter-final-35fb6",
        storageBucket: "flutter-final-35fb6.appspot.com",
        messagingSenderId: "975090416360",
        appId: "1:975090416360:web:3c26973cdbeb10d5f9275d",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) =>
            ProductBloc()..add(LoadProductEvent(productId: 'Product1')),
        child: ProductDetailScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is ProductLoaded) {
            final productData = state.productData;
            return ProductDetailContent(productData: productData);
          }
          return const Center(child: Text("Loading product details..."));
        },
      ),
    );
  }
}

class ProductDetailContent extends StatefulWidget {
  final Map<String, dynamic> productData;

  const ProductDetailContent({super.key, required this.productData});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailContentState createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productData = widget.productData;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF5D8D2),
            Color(0xFFFBF3F0),
            Color(0xFFFEFCFD),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              Center(
                child: productData['image'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          productData['image'],
                          height: 310,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.broken_image, size: 250),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productData['productName'] ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE28E8E)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: const Icon(Icons.remove,
                                color: Color(0xFFE28E8E)),
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon:
                                const Icon(Icons.add, color: Color(0xFFE28E8E)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  productData['smallDescription'] ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: List.generate(5, (index) {
                    return const Icon(Icons.star,
                        color: Colors.amber, size: 18);
                  })
                    ..add(const SizedBox(width: 5))
                    ..add(Text(
                      '(${productData['numberOfReviews'] ?? 0} reviews)',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        productData['longDescription'] ?? 'No Description',
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFE28E8E),
                      ),
                      child: const Text("Read more"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.access_time,
                          color: Color(0xFFE28E8E)),
                    ),
                    SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Time",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          "40-45 min",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          productData['totalPrice'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE28E8E), Color(0xFFE7A4A6)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
