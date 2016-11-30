//test
s.boot;//CaosSampler checks if server is on
// s.quit;
// create new instance
// CaosSampler.new;
c = CaosSampler;
c.new;
//files must be inside the 'audios' folder in caos_sampler folder
c.loadTrack;//load default
c.loadTrack("test-caos_sampler-115_bpm.wav");//track name
//
c.play;//play instance
//change instance parameters
c.setToPlay(\out,0,\loop,0);


//*viewWaveForm
y = Window.screenBounds.height - 120;
w = Window.new("soundfile test", Rect(200, y, 740, 100)).alwaysOnTop_(true);
w.front;
a = SoundFileView.new(w, Rect(20,20, 700, 60));

f = SoundFile.new;
f.openRead("");

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