//joseCao5 mini sampler
o = Server.local.options;
o.device = "PCM2902 Audio Codec";
o.device;
//
(
s.waitForBoot {
// s.reboot;
	// s.scope(2,0);
// s.meter;
// s.sampleRate;
//

	var url = thisProcess.nowExecutingPath.dirname;

(
~track = Buffer.read(s,"Desktop/josecaos-personal/josecaos-xib4lb4-EP/13-josecaos-Nuestro_amigo_Boox-(bonus_track).wav",0,-1);
~retrack = Buffer.alloc(s,s.sampleRate * 8,2);
);
// el sampler toca dos canales simultaneos instancias de el mismo sinte
//uno directos a master y otro procesado por la caosbox o una
// ruta de efectos cualquiera.
//
	(url +/+ "midi/midiin.scd").load;
	// (url +/+ "midi/*.scd").load;
	(url +/+ "synths/sampler.scd").load;
	(url +/+ "synths/synths.scd").load;
	// (url +/+ "synths/*.scd").load;

}
);
// corren sintes
(
~playA = Synth(\play,[\rate,1.1]);
// ~playB = Synth(\play,[\rate,2.2]);//separar los canales crossfade xsessions
);
(
~playA.free;
// ~playB.free;
)
x.set(\rate,1);
//

(
~recA = Synth(\rec,[\run,1,\trigger,1,\loop,0]);//defaults
// ~recB = Synth(\rec,[\rate,2.2]);//separar los canales crossfade xsessions
);
(
~recA.free;
// ~recB.free;
)
// playback de el canal grabado

(
~replayA = Synth(\replay,[\rate,1]);//
// ~replayB = Synth(\replay,[\rate,1]);
);
(
~replayA.free;
// ~replayB.free;
)

Help.gui;
