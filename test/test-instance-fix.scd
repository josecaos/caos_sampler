s.boot;
s.scope(2,50);
//crea Instancia
a = CaosSampler.loadTrack("notest",copies:1);
b = CaosSampler.loadTrack("Testttt",copies:3);
// Esperando para instancia
CaosSampler.out(1,0);
a.speed(0.4);
//Class
CaosSampler.play(false);
CaosSampler.play(true);
CaosSampler.instances;
CaosSampler.ids[0];
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
