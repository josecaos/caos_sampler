//test
s.options.sampleRate = 48000;
s.sampleRate;
// create new instance
// CaosSampler.new;
s.boot;//CaosSampler checks if server is on
(//setup
~track1 = CaosSampler;
~track2 = CaosSampler;
)
(
~track1.new;
~track2.new;
);
//files must be inside the 'audios' folder in caos_sampler folder
// ~track1.loadTrack;//loads default
(
~track1.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");//track name not in repository folder
~track2.loadTrack("josecaos-xib4lb4-01-Bilocacion.wav");
);
//
// ~track1.play;//play instance with defaults
(
~track1.play("One");//Name your instance + play instance with defaults
~track2.play("Two");
);
~track1.samplerName;//just to keep track of your instance;
~track2.samplerName;
//change instance parameters>
(
~track1.setToPlay(\out,0,\loop,0,\rate,2.2,\trigger,0,\startPos,0);
~track2.setToPlay(\out,0,\loop,1,\rate,0.2,\trigger,0,\startPos,0);
);
//
~track1.stop;//no need of reload after this
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