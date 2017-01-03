~track1 = CaosSampler;
~track1.new;
~track1.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//
~track1.register("Bilocacion",1);//Name your instance + how many simultaneous copies 1 to 3
~track1.trackName;//just to keep track of your instance;
~track1.play(true);//false = paused
//Change the instances you created, three default instances
~track1.setToPlay(1, [\out,0]);
~track1.setToPlay(1, [\out,0,\loop,1,\rate,2,\trigger,0,\startPos,0,\amp,0.95]);
~track1.setToPlay(2, [\out,0,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.33]);
~track1.setToPlay(3, [\out,0,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.33]);
//
// debug
//el problema no es el acceso a la instancia, sino los valores key
~track1.instances[0].set(\out,0,\rate,1,\trigger,1,\startpos,0);
d = [a: 5, b: 7, c: 1, d: 0];
a.asKeyValuePairs;
a = [\uno,1,\dos,2,\tres, 3];
a.asOSCArgArray;
a.asControlInput.join(',');
a.asOSCArgBundle;
a = a.collect({a[4].asSymbol});
e = (freq: 340, amp: 0.001, strangeness: 0.85);
a.use {[\uno, \dos].envirPairs;}
//////////////
~track1.stopAll;//no need of reload after this
//
~track1.viewTrack;//waveform GUI//still incomplete
//
s.scope(2,50);

play{LFPulse.ar(SinOsc.kr(4))}