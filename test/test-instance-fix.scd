s.boot;
s.scope(2,50);
//crea Instancia
a = CaosSampler.loadTrack("notesdfsdfgtx",copies:1);
b = CaosSampler.loadTrack(fileName:"master.final/josecaos-12-xibalba-toh-master-48khz-24bits.wav",copies:3);
c = CaosSampler.loadTrack("notesdfsdfgtx",copies:1);
d = CaosSampler.loadTrack("zzdz",copies:2);
// Esperando para instancia
a.play;
CaosSampler.out(1,0);
CaosSampler.amp(1,0);
CaosSampler.play(false);
a.speed(0.4);
//Class
CaosSampler.playAll(false);
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
