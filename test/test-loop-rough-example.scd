s.boot;
TempoClock.tempo = 60;
~beats = TempoClock.beatsPerBar
~compas =  TempoClock.beatDur * (TempoClock.tempo *  ~beats);
~buffer = Buffer.alloc(s, s.sampleRate * ~compas, 2);
//looper
(
SynthDef(\rec,{|loop=0,bufnum=0|
	var in = In.ar([20,21]);
	//var in = SoundIn.ar([0,1]);
	RecordBuf.ar(in,bufnum,doneAction: Done.freeSelf, loop: loop);
}).add;

SynthDef(\play, { |rate=1, trigger=1, bufnum = 0,loop=1|
    var playbuf;
		playbuf = PlayBuf.ar(2,bufnum,rate,trigger,loop:loop,doneAction:2);
    Out.ar(0, playbuf);
	FreeSelfWhenDone.kr(playbuf);
}).add;
);
~sampler = CaosSampler;
~sampler.scope(2,20);
a = ~sampler.new;
a.load("");
a.loop(true);
a.play();
a.out(1,20);
Synth(\rec);
Synth(\play, [\bufnum, 0]);
Synth(\play);
Synth(\play,[\loop,0]);
~buffer.free
//
//
//
//
a.play(false)
//
b = ~sampler.new;
b.loadLooper("Xxx",loopDur: TempoClock.beatDur * 8);
b.recordLoop();
b.play();
b.out(1,0);

//
(
Tdef(\crack, {
	var t;
	var tt = TempoClock.tempo;
	loop {
		t = rrand(0.25,1.75);
		a.speed(t);
		a.toggleReverse(t);
		tt.wait;
	}
})
);
Tdef('crack').play;

TempoClock.tempo.postcln