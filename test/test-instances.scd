// Test + debug varias instancias a la vez
CaosSampler.ids;
CaosSampler.id;
CaosSamplerRec.instance;
CaosSamplerRec.overDub;
CaosSampler.instVarNames
CaosSampler.classVarNames
//
~track = CaosSampler;
~track2 = CaosSampler;
~track.new;
~track2.new;
//
~track.loadTrack("master.final/josecaos-01-xibalba-bilocacion-master-48khz-24bits.wav");//
~track2.loadTrack("IMPT-josecaos-master/josecaos-1500(edit)-master-48khz-24bits-josecaos.xyz.wav");//
~track.loadTrack("master.final/josecaos-11-xibalba-p4nda-master-48khz-24bits.wav");//
~track.loadTrack("master.final/josecaos-07-xibalba-eternas_lluvias-master-48khz-24bits.wav");//
~track.loadTrack("master.final/josecaos-15-xibalba-boox_(bonus_track)-master-48khz-24bits.wav");//
~track.loadTrack("master.final/josecaos-02-xibalba-wdyjdi3-master-48khz-24bits.wav");//
//debug
~track.nums;
~track.nums(4);
//
~track.register("sinte uno",1);//# de tracks
~track.bufread;
~track.ids;
~track2.register("sinte dos",1);//# de tracks
~track2.bufread;
~track2.ids;
~track.trackName;
~track2.trackName;

~track.play(false);
~track2.play(true);

//
(
~track.setToPlay(1, [\out,[0],\loop,1,\rate,1.75,\trigger,0,\startPos,0,\amp,1]);
~track2.setToPlay(1, [\out,1,\loop,1,\rate,-1.75,\trigger,0,\startPos,0,\amp,1]);


)
~track.setToPlay(2, [\out,60,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,0]);
~track.setToPlay(3, [\out,64,\loop,0,\rate,1,\trigger,0,\startPos,0,\amp,0.7]);
// ~track.setToPlay(1, [\out,50,\loop,1,\rate,-1.09,\trigger,0,\startPos,0,\amp,1]);//reversa
//
~track.viewTrack;

//debug soundFileView
// ~track.viewTrack("volando");
//////////////
~track.stopAll;
