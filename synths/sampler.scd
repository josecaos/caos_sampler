// Sintes para el sampler
//
(// synths
// La salida de los sintes esta por default al master de la caosbox, cosa que podria
//cambiar mas adelante, seleccionando el canal de salida manualmente
(
SynthDef(\play,{|rate = 1, amp = #[1,1], out = 50|

	var sample;

	sample = PlayBuf.ar(2,~track,rate,BufRateScale.kr(~track));

	Out.ar(out,Pan2.ar(sample),amp);

}).add;
);
(//se graba a dos canales
SynthDef(\rec,{|run = 0, amp = 0.85, trigger = 1, loop = 0, out = 50|

	var sample;

	sample = RecordBuf.ar(~track,~retrack,0,1,0,run,loop,trigger,2);

	Out.ar(out,sample);

}).add;
);
(//replay
SynthDef(\replay,{|rate = 1, amp = 0.85, out = 64|

	var sample;

	sample = PlayBuf.ar(2,~retrack,rate,BufRateScale.kr(~track));

	Out.ar(out,sample);

}).add;
);

);