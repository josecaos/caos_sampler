~track1 = CaosSampler;

~track1.new;

~track1.loadTrack("josecaos-bug5-mixed_v2-peaks-3db-48khz-16bits.wav");

~track1.register("Uno test",3);

// checar metodo trackName
~track1.tracks;

~track1.play;

// control

~track1.out(1);

~t = 4;

(
~track1.setToPlay(1,[\out,0,\loop,0,\rate,~t,\trigger,0,\startPos,0,\amp,1]);
~track1.setToPlay(2,[\out,0,\loop,0,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
~track1.setToPlay(3,[\out,0,\loop,0,\rate,~t,\trigger,0,\startPos,0,\amp,0]);
)

//

~track1.out(1,0);
~track1.amp(1,1);
~track1.speed(~t)
~track1.toggleReverse;





