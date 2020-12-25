import 'package:get/get.dart';
import 'package:getxtodo/auth/auth.controller.dart';
import 'package:getxtodo/models/todo.dart';
import 'package:getxtodo/todo/todo.service.dart';

class TodoController extends GetxController {
  static TodoController to = Get.find();
  RxList todos = [].obs;
  RxBool isLoadingTodos = false.obs;
  RxBool isAddingTodo = false.obs;
  RxBool isLoadingDetails = false.obs;
  Todo activeTodo;
  TodoService _todoService;
  TodoController() {
    _todoService = TodoService();
  }

  onInit() {
    todos.bindStream(loadTodos());
  }

  Stream loadTodos() {
    AuthController authController = AuthController.to;
    return _todoService.findAll(authController.user.value.uid);
  }

  Future<Todo> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeTodo = await _todoService.findOne(id);
      print(activeTodo);
      isLoadingDetails.value = false;
      return activeTodo;
    } catch (e) {}
  }

  addTodo(String title) async {
    try {
      AuthController authController = AuthController.to;
      isAddingTodo.value = true;
      var todo =
          await _todoService.addOne(authController.user.value.uid, title);
      todos.add(todo);
      Get.snackbar("Success", todo.title, snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  updateTodo(Todo todo) async {
    try {
      isAddingTodo.value = true;
      await _todoService.updateOne(todo);
      int index = todos.value.indexWhere((element) => element.id == todo.id);

      todos[index] = todo;
      print(todos);
      Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  deleteTodo(String id) async {
    try {
      await _todoService.deleteOne(id);
      int index = todos.value.indexWhere((element) => element.id == id);
      todos.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
