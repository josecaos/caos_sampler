s.boot;
s.scope(2,50);
//crea Instancia
~a = CaosSampler;
~a.new;
~a.loadTrack("notesdfsdfgtx",copies:1);
// Esperando para instancia
~a.out('all',0);
~a.play(true);
~a.loop(true);
CaosSampler.outTrack;
CaosSampler.play(false);
a.speed(0.4);
//Class
~c.play(true);
CaosSampler.playAll(true);
CaosSampler.ids;
CaosSampler.all;
CaosSampler.toggleReverse
CaosSampler.loop(false);
CaosSampler.stopAll;
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
