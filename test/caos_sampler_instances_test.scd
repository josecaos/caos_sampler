(
~track1 = CaosSampler;
~track2 = CaosSampler;
);
(
~track1.new;
~track2.new;
);
(
~track1.loadTrack;
~track2.loadTrack;
);
(
~track1.register("track1",3);
~track2.register("track2",3);
)
// falta debuggear el nombre y nodos an la version multitrack
// ~track1.trackName;
// ~track2.trackName;
(
~track2.play;
~track1.play;
);
~t = {[1.4,-1.4].choose};
// ~t = {Pseq([1.8,-1.8],inf).asStream};
(
~track1.speedAll(~t.value);
~track2.speedAll(~t.value);
)

(//primero
~track1.setToPlay(1,[\out,0,\loop,1,\rate,-1.4,\trigger,0,\startPos,0,\amp,1]);
~track1.setToPlay(2,[\out,0,\loop,1,\rate,1.4,\trigger,0,\startPos,0,\amp,1]);
~track2.setToPlay(1,[\out,0,\loop,1,\rate,1.4,\trigger,0,\startPos,0,\amp,1]);
~track2.setToPlay(2,[\out,0,\loop,1,\rate,-1.4,\trigger,0,\startPos,0,\amp,1]);
);

~track1.setToPlay(3,[\out,0,\loop,1,\rate,~t,\trigger,1,\startPos,0,\amp,1]);


~track1.amp(1,1);
~track1.out(1,10);
~track1.out('all',0);
(
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