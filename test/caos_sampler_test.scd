//test
// s.quit;
// create new instance
// CaosSampler.new;
s.boot;//CaosSampler checks if server is on
(//setup
c = CaosSampler;
d = CaosSampler;
c.new;
d.new;
);
//files must be inside the 'audios' folder in caos_sampler folder
// c.loadTrack;//load default
(
c.loadTrack("test-caos_sampler-115_bpm.wav");//track name
d.loadTrack("test-caos_sampler-115_bpm.wav");
);
//
// c.play;//play instance with defaults
(
c.play("One");//Name your instance + play instance with defaults
d.play("Two");
);
c.samplerName//just to keep track of your instance;
d.samplerName
//change instance parameters>
(
c.setToPlay(\out,0,\loop,1,\rate,2,\trigger,0,\startPos,0,\amp,[0,0]);
d.setToPlay(\out,0,\loop,1,\rate,1,\trigger,0,\startPos,0,\amp,[0,0]);
);
//
c.viewTrack;//waveform GUI
// c.viewTrack(\position, 2050);//change cursor position, meanwhile manually
//
c.stopAll;//no need of reload after this

CaosSamplerRec.overDub;
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