//test
// s.quit;
// create new instance
// CaosSampler.new;
s.boot;//CaosSampler checks if server is on
c = CaosSampler;
c.new;
//files must be inside the 'audios' folder in caos_sampler folder
c.loadTrack;//load default
c.loadTrack("test-caos_sampler-115_bpm.wav");//track name
//
c.play;//play instance with defaults
//change instance parameters
c.setToPlay(\out,0,\loop,0,\rate,1.27,\trigger,0,\startPos,0);
//
c.viewTrack;//waveform GUI
c.viewTrack(\position, 2050);//change cursor position, meanwhile manually
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