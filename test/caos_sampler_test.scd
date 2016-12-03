//test
//
// create new instance
// CaosSampler.new;
//Samlerate same as input song file
// s.options.sampleRate = 48000;
s.boot;//CaosSampler checks if server is on
(//setup
~track1 = CaosSampler;
// ~track2 = CaosSampler;
);
(
~track1.new;
// ~track2.new;
);
//files must be inside the 'audios' folder in caos_sampler folder
// ~track1.loadTrack;//loads default
(
// ~track1.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//track name not in repository folder
~track1.loadTrack("josecaos-xib4lb4-11-P4nda.wav");//
);
//
// ~track1.play;//play instance group with default name
(
~track1.register("Bilocacion");//Name your instance + play instance with defaults
// ~track2.register("Two");
);
~track1.samplerName;//just to keep track of your instance;
//
// Synth(\play,[\rate,6]);

~track1.play(true);//false = paused
//change instance parameters
//three default instances
// ~track1.setToPlay(1, [\out,0,\loop,0,\rate,4,\trigger,0,\startPos,0]);
// ~track1.setToPlay(2, [\out,0,\loop,0,\rate,6,\trigger,0,\startPos,0]);
// ~track1.setToPlay(3, [\out,0,\loop,0,\rate,3,\trigger,0,\startPos,0]);
//
// Hack para set de Hoy en Pachuca
(
~hack1.set(\out,0,\loop,0,\rate,1,\trigger,1,\startPos,0);
~hack2.set(\out,0,\loop,1,\rate,2,\trigger,1,\startPos,0);
~hack3.set(\out,0,\loop,1,\rate,4,\trigger,1,\startPos,0);
);
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

//
Help.gui;
//nota
// Hacer un cotizador por horas para proyectos, con SC.
// ej. costos (por hora_($100)) * 20hrs a la semana = 2k