// Test nombre de instancia

a = CaosSampler;
a.new;
a.loadTrack();
a.register("Volando",1);
a.trackName();
//
b = CaosSampler;
b.new;
b.loadTrack();
b.register("otro");
b.trackName();
//test encuentra en array
x = Array.new;
x = x.add("test123");
x.find(["test"]);

x;
