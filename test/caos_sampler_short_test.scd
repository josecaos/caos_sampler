//evalua una sola vez esta parte
~track = CaosSampler;
~track.new;
//
// tracks a usar
~track.loadTrack("master.final/josecaos-11-xibalba-p4nda-master-48khz-24bits.wav");//
~track.loadTrack("master.final/josecaos-09-xibalba-chaca-master-48khz-24bits.wav");//
~track.loadTrack("master.final/josecaos-07-xibalba-eternas_lluvias-master-48khz-24bits.wav");//
~track.loadTrack("josecaos-xib4lb4-05-Su8.wav");//
~track.loadTrack("josecaos-xib4lb4-06-Tabano.wav");//
~track.loadTrack("josecaos-xib4lb4-07-Chechen.wav");//
~track.loadTrack("josecaos-xib4lb4-08-Chaca.wav");//
~track.loadTrack("josecaos-xib4lb4-10-Toh.wav");//
~track.loadTrack("josecaos-xib4lb4-11-P4nda.wav");//
~track.loadTrack("josecaos-xib4lb4-12-Pozo.wav");//
~track.loadTrack("josecaos-xib4lb4-13-Nuestro_amigo_Boox.wav");//
// arreglar error de nombre de instancia
~track.register("Bocas",1);//Name your instance + how many simultaneous copies 1 to 3
~track.trackName;//just to keep track of your instance;
~track.play(true);//false = paused;//plays the number of registered tracks together
//Change the instances you created, max three default instances
(
~track.setToPlay(1, [\out,50,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,1]);
~track.setToPlay(2, [\out,52,\loop,0,\rate,1.15,\trigger,0,\startPos,0,\amp,0]);
)
(
~track.setToPlay(3, [\out,64,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,0]);
)
//
s.sendMsg("\playsample",  1015, 0, 1);
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