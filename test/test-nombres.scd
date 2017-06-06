// Test nombre de instancia

a = CaosSampler;
a.new;
a.testNombre();//debug
a.loadTrack();
a.register("hola",3);//me quede aqui testeando el metodo register despues de agregarle un booleano

//
b = CaosSampler;
b.new;
// b.testNombre("si??");
b.loadTrack();
b.register("si??");

//test encuentra en array
x = [];
x = x.add("test123");
x.find(["test"]);

x;
