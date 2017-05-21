~track1 = CaosSampler;
~track1.new;

~track1.loadTrack;

~track1.register("test",3)
~track1.trackName;

~track1.play;

~track1.out('all',0);

~track1.speedAll([1,-1].choose);
