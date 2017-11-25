// Test nombre de instancia
a = CaosSampler;
b = CaosSampler;
a.loadTrack("test");
a.register("Volando",1);
a.play(true);
a.out(1,23);
a.speed(0.4);
//
b.loadTrack;
b.register("otwro",1);
b.play(true);
b.out(1,12);
b.speed(0.75);
//
a.out(1,0);
a.play(true);
a.play(false);
b.out(1,0);
b.play(true);
b.play(false);


s.scope;
