~track1 = CaosSampler;
~track2 = CaosSampler;

~track1.new;
~track2.new;

~track1.loadTrack("josecaos-bug5-mixed_v2-peaks-3db-48khz-16bits.wav");
~track2.loadTrack("josecaos-bug5-mixed_v2-peaks-3db-48khz-16bits.wav");

~track1.register("Uno test",1);
~track2.register("Dos test",1);

// checar metodo trackName
~track1.usedTracks;
~track1.trackname_("otro");
~track1.info;
~track2.info;

CaosSampler.tracks;
CaosSampler.usedTracks;

~track1.play;
~track2.play;

// control

~track1.out(1);

~t = 1.8;

(
~track1.setToPlay(1,[\out,0,\loop,1,\rate,~t,\trigger,0,\startPos,0,\amp,1]);
~track1.setToPlay(2,[\out,0,\loop,0,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
~track1.setToPlay(3,[\out,0,\loop,0,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
)

//
s.freqscope;
~track1.out(1,0);
~track1.amp(1,1);
~track1.speed(~t=1)
~track1.toggleReverse;





