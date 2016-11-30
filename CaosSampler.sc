//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <>run;
	classvar <bufread;


	*new {

		coreurl = this.filenameSymbol.asString.dirname;

		^super.new.init;

	}

	init {

		server = Server.local;

		(coreurl +/+ "core/inform.scd").load;

		// revisa si el servidor esta corriendo
		if(server.serverRunning != true ,{
			// si no, enciendelo
			server.boot;
		^fork{2.wait;~inform.value("Wait",0.05,false);~inform.value(" .... ",0.25,false);0.01.wait;~inform.value("CaosSampler instance created",0.05)}
		}, {

		^fork{~inform.value(" .... ",0.15,false);0.01.wait;~inform.value("CaosSampler instance created",0.05)}


		});
		//

		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

	}

	*loadTrack {|name = "test-caos_sampler-115_bpm.wav", startFrame = 0|


		audiourl = coreurl +/+ "audios/";

		bufread = Buffer.read(server,audiourl ++ name, startFrame, -1);

		//
		//sinte
		SynthDef(\play,{|rate = 1, amp = #[1,1], trigger = 1, out = 50, startPos = 0, loop = 0, reset = 0|

			var sample;

			sample = PlayBuf.ar(2, bufread, rate, trigger, startPos, loop, reset);

				Out.ar(out,Pan2.ar(sample),amp);

		}).add;
		//

		^fork{~inform.value("The file " ++ name ++ " has been loaded" ,0.05)};
	}


	*play {

		^run = Synth(\play);

	}

	*setToPlay {|args|

		^run.set(args);

	}

}
