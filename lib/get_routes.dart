import 'package:get/get.dart';
import 'package:getxtodo/todo/views/add_to_do.dart';
import 'package:getxtodo/todo/views/edit_to_do.dart';
import 'package:getxtodo/todo/views/todolist.dart';
import 'package:getxtodo/views/events.dart';
import 'package:getxtodo/views/login.dart';
import 'package:getxtodo/views/register.dart';
import 'package:getxtodo/views/splash_screen.dart';
import 'package:getxtodo/views/theme_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/',
      page: () => TodoList(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/todos/:id/edit',
      page: () => EditTodo(),
    ),
    GetPage(
      name: '/add-todo',
      page: () => AddTodo(),
    ),
    GetPage(
      name: '/events',
      page: () => EventsPage(),
    ),
    GetPage(
      name: '/theme',
      page: () => ThemePage(),
    ),
  ];
}
