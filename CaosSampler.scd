//joseCao5 mini sampler
s.boot;
// s.reboot;
s.scope(2,0);
// s.meter;
s.sampleRate;
//
o = Server.local.options;
o.device = "PCM2902 Audio Codec";
//
MIDIIn.source.postln;
MIDIClient.sources;
o.device;
(
~track = Buffer.read(s,"Desktop/josecaos-personal/josecaos-xib4lb4-EP/13-josecaos-Nuestro_amigo_Boox-(bonus_track).wav",0,-1);
~retrack = Buffer.alloc(s,s.sampleRate * 8,2);
);
// el sampler toca dos canales simultaneos instancias de el mismo sinte
//uno directos a master y otro procesado por la caosbox o una
// ruta de efectos cualquiera.


(// synths
(
SynthDef(\play,{|rate=1|

	var sample,out,env;

	sample = PlayBuf.ar(2,~track,rate,BufRateScale.kr(~track));

	Out.ar(0,sample);

}).add;
);
(//se graba a dos canales
SynthDef(\rec,{|run = 0, trigger = 1, loop = 0|

	var sample;

	sample = RecordBuf.ar(~track,~retrack,0,1,0,run,loop,trigger,2);

	Out.ar(0,sample);

}).add;
);
(//replay
SynthDef(\replay,{|rate=1|

	var sample,out,env;

	sample = PlayBuf.ar(2,~retrack,rate,BufRateScale.kr(~track));

	Out.ar(0,sample);

}).add;
);

);

(
x = Synth(\play,[\rate,1.1]);
y = Synth(\play,[\rate,2.2]);//separar los canales crossfade xsessions
);
(
x.free;
y.free;
)
x.set(\rate,1);
//

(
~recA = Synth(\rec,[\run,1,\trigger,1,\loop,0]);//defaults
// ~recB = Synth(\rec,[\rate,2.2]);//separar los canales crossfade xsessions
);
(
~recA.free;
// ~recB.free;
)
// playback de el canal grabado
//
~track.numChannels;
~retrack.numChannels;

(
~replayA = Synth(\replay,[\rate,1]);//
// ~replayB = Synth(\replay,[\rate,1]);
);
(
~replayA.free;
// ~replayB.free;
)


Help.gui;

play{Formant.ar(200, 1900, 2000, 0.125);}




// PROXY
// ~alloc = Bufxfer.alloc(s, s.sampleRate * 8, 2);
//
// SynthDef(\sampler,{|bufunm|
// 	var read,env;
// 	read = Buffer.read(s,~alloc.ar,2,bufnum:bufnum);
// 	env = EnvGen.ar(Env.asr(0.01,0.98,0.01),1);
// 	Out.ar([0,1],Pan2.ar(read*env),[1,-0.97]);
// 	//
// 	~out.play;
// 	~rec.play;//
// 	//
// 	~play = {|bufnum|PlayBuf.ar(2,bufnum)};
//
// 	~record = {|bufnum|RecordBuf.ar(~rec.ar,bufnum,0,0.9,0,1,1,1,0)};
//


Help.gui;