//Test  record and loop

// Ya existe un adelando del metodo grains, revisarlo

// Crar el buffer
// Grabar en el buffer
// reporducir
// Ap licar Tgrains
~seq = CaosBox;
~seq.enviroment;
~seq.play;
~seq.guiAlpha(0.3);
~seq.freqAnalyzer(true);

~sampler = CaosSampler;
~t=1
~track1 = CaosSampler.new;
~track1.load("Track1","josecaos-set/josecaos-e4n4e99n-master.wav",3);
~track1.play();
~track1.out(2,54)//
~track1.amp(2,0.5)//
~track1.amp(1,1)//
~track1.amp(1,0)//
~track1.loop(true)//
~track1.toggleReverse(1)
~sampler.scope;

~seq.autoFx(\grains,true,\normal,Array.series(10,0.1,0.1).scramble,Array.series(10,0.1,0.1));

(
Tdef(\fwrw,{
	loop {

		~track1.toggleReverse(~t=0.25);
		0.25.wait;
	}
}).quant_(4);
);
Tdef('fwrw').stop


// client <-> server  .local/share/SuperCollider/Help/Guides/structureEn.png
//
(
// declara Buffer
s.waitForBoot {
~dur = 4;
	b = Buffer.alloc(server:s, numFrames:44100 * ~dur,numChannels: 2,
		completionMessage:{"Done".postcln}	); // a four second 1 channel Buffer
})

// graba
(
SynthDef(\grabando, {|out = 0, bufnum = 0|
	var in;
	in = SoundIn.ar(0);
	RecordBuf.ar(in, bufnum, doneAction: Done.freeSelf, loop: 1);
}).add;
);
Synth(\grabando,[\bufnum,b]);
// play
(
SynthDef(\play, {|out = 0, bufnum = 0|
    var playbuf;
    playbuf = PlayBuf.ar(1,bufnum);
    FreeSelfWhenDone.kr(playbuf); // libera el sinte al terminar
    Out.ar(out, playbuf);
}).add;
);
Synth(\play,[\bufnum,b]);
// overdub
// (
// SynthDef(\help_RecordBuf_overdub, { arg out=0, bufnum=0;
// 	var formant;
// 	formant = Formant.ar(XLine.kr(400, 1000, 4), 2000, 800, 0.125);
// 	// mixes equally with existing data
// 	RecordBuf.ar(formant, bufnum, 0, 0.3, 0.5, doneAction: 2, loop: 1);
// }).play(s, [\out, 0, \bufnum, b]);
// )
//
// // play back the overdubbed version
// Synth.new(\help_RecordBuf_playback, [\out, 0, \bufnum, b], s);
//
// // write the contents of the buffer to a file (see Buffer for more options)
// (
// b.write(sampleFormat: 'int16');
// thisProcess.platform.recordingsDir +/+ "SC_" ++ Date.localtime.stamp ++ ".aiff"; // generated path
// )


// Avanzado
// play y stop boton + loop de la caosbox (bpm)
// Control de la longitud de sampleo
// unir a caosbox


