s.boot;
s.scope(12,0);
b = Buffer.alloc(s, 44100 * 4, 1); // 2 segundos
b.bufnum;
(
//
SynthDef(\signal, {|gate=0,done=2|
	var sig,env;
	sig = SinOsc.ar(LFNoise0.ar(4,440,880),0,0.5);
	env=EnvGen.ar(Env.asr(0.09,0.98,0.01,0),gate,doneAction:done);
	Out.ar(12,sig*env);
}).add;
SynthDef(\record, {
	var in;
	in = In.ar(12);
	// in = Pulse.ar(LFNoise0.ar(4,440,880),0.5,0.5)*
	// EnvGen.ar(Env.asr(0.09,0.98,0.01,0),1,doneAction:2);
	RecordBuf.ar(in,b.bufnum,doneAction: 2, loop: 0);
}).add;
SynthDef(\play, {
	var playbuf;
	playbuf = PlayBuf.ar(1,b.bufnum,2,0,0,1,2);
	// FreeSelfWhenDone.kr(playbuf);
	Out.ar(0, playbuf);
}).add;
);
z = Synth(\signal,[\gate,1,\done,2]);
z.free;
s.queryAllNodes;
Synth(\record);
Synth(\play);

//
Env.linen(1, 2, 3, 0.6, [[\sine, \welch, \lin, \exp]]).plot;

Env.adsr(0.02, 0.2, 0.25, 1, 1, -4).test(2).plot;
Env.adsr(0.001, 0.2, 0.25, 1, 1, -4).test(2).plot;
Env.adsr(0.001, 0.2, 0.25, 1, 1, -4).test(0.45).plot;

(
{
e = Env.sine.asStream;
5.do({
    e.next.postln;
    0.5.wait;
})}.fork
)