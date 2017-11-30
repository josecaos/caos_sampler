// Test nombre de instancia
b = CaosSampler.loadTrack("notestxx",copies:1);
a = CaosSampler.loadTrack("Testttt",copies:3);
//
a.trackname;
b.trackname;
//
a.play(true);
a.out(1,23);
a.speed(0.4);
//
b = CaosSampler;
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
