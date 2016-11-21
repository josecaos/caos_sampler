// Sintes para el sampler
//
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