// Sintes para el sampler
//
(// synths
// La salida de los sintes esta por default al master de la caosbox, cosa que podria
//cambiar mas adelante, seleccionando el canal de salida manualmente
(
SynthDef(\play,{|rate = 1, amp = #[1,1], out = 50, startPos = 0, loop = 0, reset = 0|

	var sample;

	sample = PlayBuf.ar(2,bufread,rate,BufRateScale.kr(bufread),startPos,loop,reset);

	Out.ar(out,Pan2.ar(sample),amp);

}).add;
);
// (//se graba a dos canales
// SynthDef(\rec,{|run = 0, amp = 0.85, out = 50, trigger = 1, loop = 0, reset = 0|
//
// 	var sample;
//
// 	sample = RecordBuf.ar(~track,~retrack,0,1,0,run,loop,trigger,reset);
//
// 	Out.ar(out,sample);
//
// }).add;
// );
// (//replay
// SynthDef(\replay,{|rate = 1, amp = 0.85, out = 64, startPos = 0, loop = 0, reset = 0|
//
// 	var sample;
//
// 	sample = PlayBuf.ar(2,~retrack.bufnum,rate,BufRateScale.kr(~track.bufnum),startPos,loop,reset);
//
// 	Out.ar(out,sample);
//
// }).add;
//
// );

);