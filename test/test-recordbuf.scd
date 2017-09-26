s.boot;

b = Buffer.alloc(s, 44100 * 4, 1); // a four second 1 channel Buffer

(
SynthDef(\help_RecordBuf, { arg out = 0, bufnum = 0;
    var formant;
    formant = Formant.ar(XLine.kr(4000,1500, 4), 100, 400, 0.125);
	    RecordBuf.ar(formant, bufnum, doneAction: 2, loop: 1);
}).add;
Synth(\help_RecordBuf);
)

// play it back
(
SynthDef(\help_RecordBuf_overdub, { arg out = 0, bufnum = 0;
    var playbuf;
	    playbuf = PlayBuf.ar(1,bufnum,LFNoise0.kr(40),0,0,0);
	    FreeSelfWhenDone.kr(playbuf);
    Out.ar(out, playbuf);
}).add;
Synth(\help_RecordBuf_overdub);
)