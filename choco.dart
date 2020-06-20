import 'dart:async';

class Cake {}
class Order {
  String type;
  Order(this.type); 
}
void main() {
  final controller = new StreamController();

  final order = new Order('banana'); //customer

  final baker = new StreamTransformer.fromHandlers(
    handleData: (cakeType, sink) {
      if (cakeType == 'chocolate') {
        sink.add(new Cake());
      }
      else {
        sink.addError('I cant bake the that type!!');
      }
    }
  );
  controller.sink.add(order);  // order receiver
  controller.stream
      .map((order) => order.type)  //order inspector check whether type is choco or not
      .transform(baker) 
      .listen(
        (cake) => print("here is your $cake"),
        onError: (err) => print(err)  // onError is a named parameter.
      );
}