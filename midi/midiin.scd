////intento midi keyboard
//para usar la interfas sonuus
//
s.boot;
s.scope;
// s.quit;

MIDIIn.connectAll;//
// MIDIIn.connect(MIDIClient.sources.at(3).postln);//indice de el cliente i2M-musicport
(
MIDIIn.noteOn={|port,chan,note,vel|
	[port,chan,note,vel].postln;

	Synth(\sonuus,[\gate,1,\nota,note]);


};

);
MIDIIn.noteOn=nil;
////


(
SynthDef(\sonuus,{|gate=0,nota=60|
	var son,env;
	son=LFTri.ar(nota.midicps,0,0.75);
	env=EnvGen.ar(Env.perc(0.01,0.5),gate,doneAction:2);
	Out.ar([0,1],son*env)
}).add;
);
// Synth(\sonuus,[\gate,1,\nota,[60,63,67,71,73,77,82].choose]);
//
///
(
MIDIFunc.noteOn({|note,vel|
	[note,vel].postln;
Synth(\sonuus,[\gate,1,\nota,note]);
});
);

(
~bass = NoteOnResponder({ |src,chan,note,vel|
	[src,chan,note,vel].postln;
	Synth(\sonuus,[\gate,1,\nota,note+12]);

});
);
~bass.learn;


//
//

(

var notes, on, off;
notes = Array.newClear(128);  // array has one slot per possible MIDI note
on = Routine({
	var event, newNode;
	loop {
		event = MIDIIn.waitNoteOn;	// all note-on events
		// play the note
		newNode = Synth(\sonuus, [\nota, event.b.midicps/*,
		\amp, event.c * 0.00315*/]);  // 0.00315 approx. == 1 / 127 * 0.4
		notes.put(event.b, newNode);	// save it to free later
	}
}).play;

off = Routine({
	var event;
	loop {
		event = MIDIIn.waitNoteOff;
		// look up the node currently playing on this slot, and release it
		notes[event.b].set(\gate, 0);
	}
}).play;
q = { on.stop; off.stop; };

)