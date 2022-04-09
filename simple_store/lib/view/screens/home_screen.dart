import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_store/logic/category/category_bloc.dart';
import 'package:simple_store/service/auth.dart';
import 'package:simple_store/view/routes.dart';
import 'package:simple_store/view/screens/home_pages/home_page.dart';
import 'package:simple_store/view/screens/home_pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  Duration animationDuration = Duration(milliseconds: 200);

  List<Widget> pages = [
    HomePage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Auth().getAllProducts();
    return Scaffold(

      drawer: CustomDrawer(),


      appBar: AppBar(
        elevation: 0,
        title: Text('Store'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, cartScreen);
              }, icon: Icon(Icons.shopping_cart_outlined)),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        animationCurve: Curves.easeInOutSine,
        backgroundColor: Theme.of(context).primaryColor,
        height: 50,
        items: [
          Icon(Icons.home),
          Icon(Icons.person)
        ],
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc,CategoryState>(
      builder: (context,state) {
        if (state is CategoryLoaded) {
          return Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 60,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      child: Text('Categories',style: TextStyle(fontSize: 18),)),
                  ListView(
                    shrinkWrap: true,
                    children: List.generate(state.categories.length, (index) =>
                        InkWell(
                          onTap: (){
                            if (state.selectedCategory == state.categories[index].id){
                              BlocProvider.of<CategoryBloc>(context).add(CategorySelected(null));
                            }
                            else{
                              BlocProvider.of<CategoryBloc>(context).add(CategorySelected(state.categories[index].id));
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: state.selectedCategory != null && state.selectedCategory == state.categories[index].id ?
                            Colors.blue : null,
                            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                            child: Text(state.categories[index].title),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        }
        else if (state is CategoryLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          return Center(
            child: Text("ERROR",style: TextStyle(color: Colors.red),),
          );
        }
      }
      );
  }
}
