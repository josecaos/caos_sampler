// test SoundFile
s.boot
//
(
f = SoundFile.new;
f.openRead(Platform.resourceDir +/+ "Extensions/caos_sampler/audios/josecaos-xib4lb4-07-Chechen.wav");
// f.inspect;
// f.close;
f.path;
);
//
SoundFile.collect("/usr/share/SUperCollider/Extesions/caos_sampler/audios/*").do{ |f| f.path.postln };
SoundFile.use(Platform.resourceDir +/+ "sounds/a11wlk01.wav", { |f| f.inspect });
//
s.boot;
(
SynthDef(\diskIn2, { | bufnum, out, gate = 0, sustain, amp = 1, ar = 0, dr = 0.01 |
    Out.ar(out, DiskIn.ar(2, bufnum)
    * Linen.kr(gate, ar, 1, dr, 2)
    * EnvGen.kr(Env.linen(0, sustain - ar - dr max: 0 ,dr),1, doneAction: 2) * amp)
}).add;
);
f = SoundFile.collect(Platform.resourceDir +/+ "Extensions/caos_sampler/audios/*");
e = f[1].cue;

e = f[1].cue( (addAction: 2, group: 1, lastFrame: nil),true );//posicion ahead de el grupo
e = f[0].cue( (addAction: 2, group: 1, lastFrame: nil),true );


//

s.scope(2,0);
// test-soundfileview
//empezamos con el ejemplo de la documentacion
s.boot
( // make a simple SoundFileView
y = Window.screenBounds.height - 120;
w = Window.new("soundfile test", Rect(0, y, 1360, 200)).alwaysOnTop_(true);
w.front;
a = SoundFileView.new(w, Rect(5,2, 1330, 190));

f = SoundFile.new;
f.openRead(Platform.resourceDir +/+ "sounds/a11wlk01.wav");
// f.inspect;

a.soundfile = f;            // set soundfile
a.read(0, f.numFrames);     // read in the entire file.
a.refresh;                  // refresh to display the file.
)

// In Qt GUI:
// To zoom in/out: Shift + right-click + mouse-up/down
// To scroll: right-click + mouse-left/right

// reading file
a.read(0, f.numFrames / 8).refresh; // read first half
a.read.refresh;                     // read entire file by default
a.read(f.numFrames / 2).refresh;    // read second half
a.read(0, -1).refresh;              // -1 lee archivo completo

// In Qt GUI, the resolution of the view is always infinite;
// you can always zoom in until you see a single sample.

// In other GUI kits, 'block' sets the resolution of the view (default is 64).
// i.e. the view keeps peak values for each block of e.g. 64 samples
// rather than the entire waveform.
a.read(0, -1, block: 32).refresh;
a.read(0, -1, block: 24).refresh;
a.read(0, -1, block: 16).refresh;

// for longer files, you can use:
a.readWithTask;

// zoom is relative
a.zoom(0.2).refresh;
a.zoom(2).refresh;
a.zoom(2).refresh;
a.zoomToFrac(0.5); // zoom to half file size
a.zoomAllOut;

a.gridOn = true;            // rejilla, 1 segundo default,
a.gridResolution = 0.25;     // un cuarto de segundo la rejilla
a.gridColor = Color.cyan;   // color de rejilla
a.gridOffset_(0.04);         // desfase de la erjilla

a.timeCursorOn = true;          // cursor
a.timeCursorPosition = 2050;    // posicion en frames.
a.timeCursorColor = Color.black;

//
a.drawsWaveForm = false;
a.drawsWaveForm = true;

// propiedades de la vista:
a.gridOn
a.gridResolution
a.gridColor
a.timeCursorOn
a.timeCursorPosition
a.timeCursorColor
//
//
// Selections: multiple selections are supported.
// e.g. use selection 0:
a.setSelectionColor(0, Color.red);  // parametros ( index, value )
a.selectionStart(0);                // indice
a.setSelectionStart(0, 12345);
a.setSelectionSize(0, 12345);

a.setSelectionStart(0, 1234);
a.selectionStart(0);

// now selection 1
a.setSelectionColor(1, Color.white);
a.setSelectionStart(1, 1234).setSelectionSize(1, 1234 * 2);
a.selectionStart(3);
a.setSelectionStart(3, 102345).setSelectionSize(1,124 * 6);

// the current selection gets changed when click/dragging in view.
a.currentSelection;     // index of current selection;
a.currentSelection_(1); // switch current selection - try click/drag white now.
a.currentSelection;

a.selections.size;      // 64 selections
a.selections[0];
a.selections[1];
a.selections;

// setSelection (index, selection);
a.setSelection(0, [234, 2345]);
a.selection(1); // returns [start, size].


a.elasticMode = true;   // not sure if this is working yet?

(       // mouseUpAction
a.mouseUpAction = {
    ("mouseUp, current selection is now:"
        + a.selections[a.currentSelection]).postln;
};
)
// lock selection 0:
a.currentSelection_(0);
a.setEditableSelectionStart(0, false);
a.setEditableSelectionSize(0, false);


// unlock selection 0:
a.setEditableSelectionStart(0, true);
a.setEditableSelectionSize(0, true);

a.selectionStartTime(0);
a.selectionDuration(0);


a.setSelectionStart(0, 12345);
a.setSelectionSize(0, 12345);
a.readSelection.refresh;
a.readSelection(16).refresh;    // in higher resolution
a.read.refresh;                 // go back to entire file.


a.dataNumSamples;   // visual data have this many points
a.data.plot;
a.setData(a.data.reverse);


a.zoom(0.25);       // scrolling is normalized
a.scrollTo(0.5);    //
a.scrollTo(0.6);    //
a.scroll(12);       // scroll is in viewFrames.

a.zoom(4);

w.close;

