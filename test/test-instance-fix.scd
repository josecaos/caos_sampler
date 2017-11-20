// Test nombre de instancia

a = CaosSampler;
a.new;
a.loadTrack();
a.register("Volando",1);
// a.trackname_("Nayarit");
a.trackName();
//
b = CaosSampler;
b.new;
b.loadTrack();
b.register("otro");
// b.trackname_("Carlos");
b.trackName();

b.play();
//test encuentra en array
x = Array.new;
x = x.add("test123");
x.find(["test"]);
//

q = CaosTest.new
q
