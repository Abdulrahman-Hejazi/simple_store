import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_store/data/constants.dart';
import 'package:simple_store/logic/cart/cart_bloc.dart';
import 'package:simple_store/logic/cart/cart_repo.dart';
import 'package:simple_store/logic/category/category_bloc.dart';
import 'package:simple_store/logic/category/category_repo.dart';
import 'package:simple_store/logic/product_bloc/product_bloc.dart';
import 'package:simple_store/logic/product_bloc/product_repo.dart';
import 'package:simple_store/logic/simple_observer.dart';
import 'package:simple_store/logic/user_bloc/user_bloc.dart';
import 'package:simple_store/logic/user_bloc/user_repo.dart';
import 'package:simple_store/service/auth.dart';
import 'package:simple_store/service/cache.dart';
import 'package:simple_store/view/routes.dart';
import 'package:simple_store/view/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataSaver.dataSaverIni();
  BlocOverrides.runZoned(
    () => runApp(App(
      userRepo: UserRepo(),
      productRepo: ProductRepo(),
      categoryRepo: CategoryRepo(),
      cartRepo: CartRepo(),
    )),
    blocObserver: SimpleBlocObserver(),
  );
}

class App extends StatelessWidget {
  App(
      {required this.productRepo,
      required this.userRepo,
      required this.categoryRepo,
      required this.cartRepo});

  final UserRepo userRepo;
  final ProductRepo productRepo;
  final CategoryRepo categoryRepo;
  final CartRepo cartRepo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(userRepo)..add(UserCheckToken()),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(categoryRepo)..add(CategoryStarted()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(productRepo)..add(ProductStarted()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(cartRepo: cartRepo)..add(CartStarted()),
        ),
      ],
      child: MaterialApp(
        theme: customThemeData,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: wrapper,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
