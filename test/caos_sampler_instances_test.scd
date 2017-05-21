~track1 = CaosSampler;
~track1.new;

~track1.loadTrack;

~track1.register("errrre",3)
~track1.trackName;

~track1.play;

~track1.out(1,10);
~track1.out('all',0);

~t = {[1.4,-1.4].choose};


~track1.speedAll(~t);
(
~track1.setToPlay(1,[\out,0,\loop,1,\rate,1.4,\trigger,1,\startPos,0,\amp,1]);
~track1.setToPlay(2,[\out,0,\loop,1,\rate,1.4,\trigger,1,\startPos,0,\amp,1]);
~track1.setToPlay(3,[\out,0,\loop,1,\rate,1.4,\trigger,1,\startPos,0,\amp,1]);
);
