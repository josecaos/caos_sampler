//test
// create new instance
// CaosSampler.new;
//Samplerate same as input song file
/*
Note:
if CaosBox true, must be playing before all these
*/
s.boot;//CaosSampler checks if server is on
s.scope(2,0);
(//setup
~track1 = CaosSampler;
~track2 = CaosSampler;
~track3 = CaosSampler;
~track4 = CaosSampler;
~track5 = CaosSampler;
~track6 = CaosSampler;
// ~track2 = CaosSampler;
);
(
// ~track2.new;
~track1.new;
~track2.new;
~track3.new;
~track4.new;
~track5.new;
~track6.new;
);

// ~track2.value.
//files must be inside the 'audios' folder in caos_sampler folder
// ~track1.loadTrack;//loads default

~track1.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//
~track2.loadTrack("josecaos-xib4lb4-11-P4nda.wav");//
~track3.loadTrack("josecaos-xib4lb4-05-Su8.wav");//
~track4.loadTrack("josecaos-xib4lb4-13-Nuestro_amigo_Boox.wav");//
~track5.loadTrack("josecaos-xib4lb4-11-P4nda.wav");//
~track6.loadTrack("josecaos-xib4lb4-09-Glitchtlan.wav");//
~track1.loadTrack("josecaos-xib4lb4-10-Toh.wav");//
~track8.loadTrack("josecaos-xib4lb4-02-Di3.wav");//
~track9.loadTrack("josecaos-xib4lb4-09-Glitchtlan.wav");//
// ~track1.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//track name not in repository folder


// ~track1.play;//play instance group with default name
(
~track1.register("Bilocacion");//Name your instance + play instance with defaults
~track2.register("di3");//Name your instance + play instance with defaults
~track3.register("su8");//Name your instance + play instance with defaults
~track4.register("booxito");//Name your instance + play instance with defaults
~track5.register("finale");//Name your instance + play instance with defaults
~track6.register("gran finale");//Name your instance + play instance with defaults
// ~track2.register("Two");
);
//
~track1.samplerName;//just to keep track of your instance;
// Synth(\play,[\rate,6]);

~track1.play(true);//false = paused
~track6.play(true);
~track2.play(true);
~track4.play(true);
~track5.play(true);
~track6.play(true);
//
// Hack para set de Hoy en Pachuca
/*(
~hack1.set(\out,#[50,53],\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.7);
~hack2.set(\out,#[64,65],\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.7);
~hack3.set(\out,#[60,61],\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.4);
);*/
s.scope;
s.queryAllNodes;
//change instance parameters
//three default instances
~track1.setToPlay(1, \out,0,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.7);
~track1.setToPlay(2, [\out,#[60,61],\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.7]);
~track1.setToPlay(3, [\out,#[64,65],\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,0.7]);
//
//
~track1.stopAll;//no need of reload after this
//
//untested
~track1.viewTrack;//waveform GUI
// c.viewTrack(\position, 2050);//change cursor position, meanwhile manually
//
CaosSamplerRec.overDub;
//
// Help.gui;
//
~track.numFrames;
~track.bufnum;
~track.duration;
value{BufSamples(~track)}

// debug
play{Out.ar(1,SinOsc.ar(60*LFPulse.ar(4,0.01,0.01,60,120),0,0.5))};


//
s.scope(2,0);
s.makeGui;

//
s.queryAllNodes;`
//


Help.gui;
//nota
// Hacer un cotizador por horas para proyectos, con SC.
// ej. costos (por hora_($100)) * 20hrs a la semana = 2k