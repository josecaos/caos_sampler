////
// COnexion MIDI comentada, por el momento el midi se inicializa en la caosbox
// MIDIIn.connectAll;//
// MIDIIn.connect
// MIDIClient.sources;
// MIDIIn.connect(MIDIClient.sources.at(3).postln);//indice de el cliente i2M-musicport
(
MIDIIn.noteOn={|port,chan,note,vel|
	[port,chan,note,vel].postln;

	Synth(\sonuus,[\gate,1,\nota,note]);


};
);
// Synth(\sonuus,[\gate,1,\nota,[60,63,67,71,73,77,82].choose]);
//
//Clases Alternativas de noteOn
/*(
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
~bass.learn;*/


//
//

(
~midiin = {

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

}
)


//
// mapeo del controlador copiado de caosbox
//
/*(
MIDIIn.control={|src,chan,num,val| /*[src,chan,num,val].postln;//[num].postln;*/
	switch(num,12,{~mast.set(\vol,val.linlin(0,127,0,1));{~mastfader.value_(val/127);~num.value_(val/127)}.defer},
               26,{~mast.set(\below,val.linlin(0,127,0.01,1));{~mastfader2.value_(val/127);~num2.value_(val/127)}.defer},
               25,{~mast.set(\relaxTime,val.linlin(0,127,0.01,1));{~mastfader3.value_(val/127);~num3.value_(val/127)}.defer},
               24,{~mast.set(\limit,val.linlin(0,127,0.01,1));{~mastfader4.value_(val/127);~num4.value_(val/127)}.defer},
               29,{~mastrev.set(\mix,val.linlin(0,127,0.01,1));{~auxrfader.value_(val/127);~numr.value_(val/127)}.defer},
               28,{~mastrev.set(\room,val.linlin(0,127,0.01,1.3));{~auxroomfader.value_(val/127);~numroom.value_(val/127)}.defer},
		       27,{~mastrev.set(\damp,val.linlin(0,127,1,0.01));{~auxdfader.value_(val/127);~numd.value_(val/127)}.defer},
			   11,{~mastdel.set(\delaytime,val.explin(0,127,0,1));{~auxtfader.value_(val/127);~numt.value_(val/127)}.defer},
		       14,{~mastdel.set(\delfeed,val.linlin(0,127,0,1));{~auxffader.value_(val/127);~numf.value_(val/127)}.defer},
               36,{~mastpit.set(\pitch,val.linlin(0,127,0.1,4));{~auxpfader.value_(val/127);~nump.value_(val/127)}.defer},
               35,{~mastpit.set(\pitchDispersion,val.linlin(0,127,0.01,1));{~auxpdfader.value_(val/127);~numpd.value_(val/127)}.defer},
               34,{~mastpit.set(\timeDispersion,val.linlin(0,127,0.01,1));{~auxtdfader.value_(val/127);~numtd.value_(val/127)}.defer},
		       33,{~mastlowf.set(\cutfreq,val.linexp(0,127,20,20000));{~lowcfader.value_(val/127);~numf1.value_(val*157.4811)}.defer},
			   32,{~mastbandf.set(\cutfreq,val.linexp(0,127,20,20000));{~bandcfader.value_(val/127);~numf5.value_(val*157.4811)}.defer},
		       31,{~masthighf.set(\cutfreq,val.linexp(0,127,20,20000));{~highcfader.value_(val/127);~numf3.value_(val*157.4811)}.defer},
		       20,{~grains.set(\trigger,val.linlin(0,127,0.1,8));{~gfaders.x_(val/127)}.defer},
		       17,{~grains.set(\size,val.linlin(0,127,1,0.01));{~gfaders.y_(val/127)}.defer},
		       15,{~grains.set(\size,val.linlin(0,127,-1,-0.01));~grains.set(\trigger,val.linlin(0,127,-1,-0.01));
			             {~gfaders.y_(val/127);~gfaders.x_(val/127)}.defer
		           }
               )
            };
);*/