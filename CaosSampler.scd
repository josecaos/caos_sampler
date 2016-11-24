//joseCao5 mini sampler
o = Server.local.options;
o.device = "PCM2902 Audio Codec";
o.device;
//
// s.reboot;
// s.scope(2,0);
// s.meter;
// s.sampleRate;
//
CaosSampler.init;

////
//nota: usar metodo .normalize() como opcion para sampleos de baja amplitud
/////
// corren sintes
(
~playA = Synth(\play,[\rate,1.7,\out,50,\startPos,18245312,\loop,0,\reset,0]);//salida predeterminada al canal 50(master de la caosbox)
~playB = Synth(\play,[\rate,1.7,\out,64,\amp,[0.2,0.3],\startPos,0,\loop,0,\reset,0]);
~playC = Synth(\play,[\rate,1.7,\out,56,\amp,[0.3,0.2],\startPos,0,\loop,0,\reset,0]);
);
//libera sintes
(
~playA.free;
~playB.free;
~playC.free;
);
//modula sintes
(
~playA.set(\rate,0.9);
~playB.set(\rate,0.9);
~playC.set(\rate,1.8);
);
//

(
~recA = Synth(\rec,[\run,1,\trigger,1,\loop,0,\reset,0]);//defaults
// ~recB = Synth(\rec,[\rate,2.2]);//separar los canales crossfade xsessions
);
(
~recA.free;
// ~recB.free;
)
// playback de el canal grabado

(
~replayA = Synth(\replay,[\rate,1,\out,50,\startPos,0,\loop,0,\reset,0]);//
// ~replayB = Synth(\replay,[\rate,1]);
);
(
~replayA.free;
// ~replayB.free;
)

// Help.gui;
//
~track.numFrames;
~track.bufnum;
~track.duration;
value{BufSamples(~track)}