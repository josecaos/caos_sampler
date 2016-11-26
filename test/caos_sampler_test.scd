//test
s.boot;
s.quit;
CaosSampler.new;
// create new instance
c = CaosSampler;
c.new;
//files must be inside the 'audios' folder in CaosSampler repo folder
//default loading + custom file loading by name
c.loadTrack;
c.loadTrack("test-caos_sampler-115_bpm.wav");//track name



// play{SinOsc.ar(45*Pulse.ar(4,0.1,60,120))}
//
CaosSampler.browse;
CaosSampler.asClass;
CoasSampler.methods;
//
Help.gui;
Server.notify;
s.status;
s.notify;
s.serverRunning;