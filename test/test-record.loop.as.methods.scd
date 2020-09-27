// Test Recording playing loop
c=CaosBox;
c.enviroment;
c.play;
x = CaosSampler.new;
x.load;//loads audio
x.play;
x.loop(false);
x.toggleReverse();
x.buffer
//
y = CaosSampler.new;
y.load("xx")//loads audio
y.play(true);
// y.loop(false);
y.loop(true);
y.toggleReverse;
// now load a buffer and record on it
z = CaosSampler.new;
z.loadLooper("looper",4);//allocs buffer for recording
z.recordLoop(\in);//record the alloc instance
z.recordLoop(\mic);//record the alloc instance
z.recordLoop(\i0);//bad input => won't record the alloc instance
z.play;
z.amp(1,1)
z.loop(true);
z.buffer
//sampler info
CaosSampler.coreurl
CaosSampler.audiourl
CaosSampler.info
CaosSampler.ids
CaosSampler.tracks
CaosSampler.all
//
Synth(\looper)
Synth(\looper_rec)
//
z = "heeey"
z ++ "-rec"
Server.local.queryAllNodes

(
Tdef(\x,{
	loop {

		x.toggleReverse();

		0.475.wait;
	}
});
)
Tdef(\x).play;

115/60
1.91/2
0.95/2
q = { 4.rand.post}.dup(34);
q.collect{|item,i| item+i.postln};
s.scope

//
s.boot;
s.scope;


b = Buffer.alloc(s, 44100 * 4.0, 1); // a four second 1 channel Buffer

// record for four seconds
(
SynthDef(\rec, { arg out = 0;
	RecordBuf.ar(SoundIn.ar([0,1]), 0, doneAction: Done.freeSelf, loop: 0);
}).play(s,[\out, 0]);
)
// play it back
(
SynthDef(\play , { |out = 0|
    var playbuf;
    playbuf = PlayBuf.ar(2,0);
    FreeSelfWhenDone.kr(playbuf); // frees the synth when the PlayBuf is finished
    Out.ar(out, playbuf);
}).play(s, [\out, 0, \bufnum, b]);
)