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
c.setToPlay(\out,0,\loop,1\normalizer,false);


//
Help.gui;