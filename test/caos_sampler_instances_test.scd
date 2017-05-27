(
~track1 = CaosSampler;
~track2 = CaosSampler;
);
(
~track1.new;
~track2.new;
);
(
~track1.loadTrack('josecaos-bug5-mixed_v2-peaks-3db-48khz-16bits.wav');
~track2.loadTrack;
);
(
~track1.register("Comp",3);
~track2.register("track2",3);
)
// falta debuggear el nombre y nodos an la version multitrack
// ~track1.trackName;
// ~track2.trackName;
(
~track1.play;
~track2.play;
);
~t = 1;//{[1,-1].choose};
~t = {[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1].choose};
// ~t = {Pseq([1.8,-1.8],inf).asStream};

(//primero
~track1.setToPlay(1,[\out,0,\loop,1,\rate,1,\trigger,1,\startPos,0,\amp,1]);
~track1.setToPlay(2,[\out,0,\loop,1,\rate,1,\trigger,1,\startPos,0,\amp,0]);
~track1.setToPlay(3,[\out,0,\loop,1,\rate,1,\trigger,1,\startPos,0,\amp,0]);
);

~track1.amp(1,1);
~track1.amp(2,1);
~track1.amp(3,1);
~track1.out(1,0);
~track1.out('all',0);
~track1.speedAll(1.43);
~track1.toggleReverse(1);
//
(//alternativa afecta todas las instancias
~track1.instances.collect({|item|
	var a;

	a = item.set(\out,0);
});
)

~track1.stopAll;

//
//

~track2.trackName;


~t2 = {[1.4,-1.4].choose};

~track2.speedAll(~t2.value);


(//primero
~track2.setToPlay(1,[\out,0,\loop,1,\rate,-1.4,\trigger,0,\startPos,0,\amp,1]);
~track2.setToPlay(2,[\out,0,\loop,1,\rate,-1.4,\trigger,0,\startPos,0,\amp,1]);
);

~track2.setToPlay(3,[\out,0,\loop,1,\rate,~t,\trigger,1,\startPos,0,\amp,1]);


~track2.amp(1,0);

~track2.out(1,0);
~track2.out('all',0);
(
~track2.instances.collect({|item|
	var a;

	a = item.set(\out,0);
});
)

~track2.stopAll;