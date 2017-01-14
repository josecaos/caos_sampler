//evalua una sola vez esta parte
~track = CaosSampler;
~track.new;
//
// tracks a usar
~track.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//
~track.loadTrack("josecaos-xib4lb4-02-Di3.wav");//
// arreglar error de nombre de instancia
~track.register("biloc",2);//Name your instance + how many simultaneous copies 1 to 3
~track.trackName;//just to keep track of your instance;
~track.play(true);//false = paused;//plays the number of registered tracks together
//Change the instances you created, max three default instances

(
~track.setToPlay(1, [\out,50,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,0.1]);
~track.setToPlay(2, [\out,60,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,0]);
~track.setToPlay(3, [\out,64,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,0]);
)
//
// debug
~track.bufread;

//debug soundFileView
// ~track.viewTrack("volando");
//////////////
~track.stopAll;//no need of reload after this
//
~track.viewTrack;//waveform GUI//still incomplete
//
s.scope(2,50);