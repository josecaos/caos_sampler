~track1 = CaosSampler;
~track1.new;
~track1.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//
~track1.register("Bilocacion",3);//Name your instance + hoyw many simultaneous copies 1 to 3
~track1.trackName;//just to keep track of your instance;
~track1.play(true);//false = paused
//three default instances
~track1.setToPlay(1, [\out,50,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.33]);
~track1.setToPlay(2, [\out,0,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.33]);
~track1.setToPlay(3, [\out,0,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.33]);
//
~track1.stopAll;//no need of reload after this
//
~track1.viewTrack;//waveform GUI
//
s.scope(2,50);