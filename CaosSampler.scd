//joseCao5 mini sampler
o = Server.local.options;
o.device = "PCM2902 Audio Codec";
o.device;
//
// s.reboot;
// s.scope(2,0);
// s.meter;
// s.sampleRate;
(
s.waitForBoot {
	//

	var url = thisProcess.nowExecutingPath.dirname;


	// estos seran metodos para asi poder cambiar el track por medio un parametro url
	(
		~track = Buffer.read(s,"Desktop/josecaos-personal/josecaos-xib4lb4-EP/13-josecaos-Nuestro_amigo_Boox-(bonus_track).wav",0,-1);
		~retrack = Buffer.alloc(s,s.sampleRate * 8,2);
	);
	// el sampler toca dos canales simultaneos instancias de el mismo sinte
	//uno directos a master y otro procesado por la caosbox o una
	// ruta de efectos cualquiera.
	//
	(url +/+ "midi/midiin.scd").load;
	(url +/+ "synths/sampler.scd").load;
	(url +/+ "synths/synths.scd").load;
	// (url +/+ "synths/*.scd").load;

	//init
	{
	var txt = "CaosSampler activado".asArray;
	var letrero = Array.newClear(20);

	20.do{|i|

		letrero.put(i, txt[i]);

			letrero[i].asString.post;

		0.05.wait;

	}
	}.value;
	//
}
);
//termina waitForBoot
///
////
/////
// corren sintes
(
~playA = Synth(\play,[\rate,1.7]);//salida predeterminada al canal 50(master de la caosbox)
~playB = Synth(\play,[\rate,1.7,\out,64,\amp,[0.2,0.3]]);
~playC = Synth(\play,[\rate,1.7,\out,56,\amp,[0.3,0.2]]);
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

// Help.gui;
