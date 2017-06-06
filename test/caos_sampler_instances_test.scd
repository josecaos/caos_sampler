
~track1 = CaosSampler;
~track2 = CaosSampler;

~track1.new;
~track2.new;

~track1.loadTrack('josecaos-bug5-mixed_v2-peaks-3db-48khz-16bits.wav');
~track2.loadTrack();

~track1.register("leoop",1);
~track2.register("loopard",1);
// falta debuggear el nombre y nodos en la version multitrack>
//debugging nombre
~track1.trackName;
~track1.playname_("sinte 1");
~track2.trackName;
~track2.playname;
//
~track1.play;
~track2.play;

// tempo

~t = 1;
(//primero instancias juntas
~track1.setToPlay(1,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,1]);
~track1.setToPlay(2,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
~track1.setToPlay(3,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
);
(//primero instancias juntas
~track2.setToPlay(1,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,1]);
~track2.setToPlay(2,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
~track2.setToPlay(3,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
);

//despues instancias individual
//tempo evaluado
~track1.speed(~t=1.45);
//
~track1.amp(1,1);
~track1.amp(2,0.3);
~track1.amp(3,0.8);
~track1.out(1,0);
~track1.out('all',10);
~track2.out('all',0);
//
~track1.toggleReverse(~t);
~track2.toggleReverse(~t);
//
(//alternativa
~track2.instances.collect({|item|
	var a;

	a = item.set(\trigger,1).set(\startPos,0);
});
)

~track1.stopAll;
//