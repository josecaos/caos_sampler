//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <>run;
	classvar <bufread, <>normalizeIn;


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
		});
		//

		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

		//simula loading
		^fork{1.wait;~inform.value("Wait",0.05,false);~inform.value(" ... ",0.25,false);0.01.wait;~inform.value("CaosSampler activated",0.05)}

	}

	*loadTrack {|name = "test-caos_sampler-115_bpm.wav", startFrame = 0|

		audiourl = coreurl +/+ "audios/";

		bufread = Buffer.read(server,audiourl ++ name, startFrame, -1);

		normalizeIn = false;
		//
		//pull synths
		// (coreurl +/+ "synths/sampler.scd").load;
		SynthDef(\play,{|rate = 1, amp = #[1,1], out = 50, startPos = 0, loop = 0, reset = 0, normalizer, normLevel = 0.9|

			var sample;

			normalizer = normalizeIn;

			sample = PlayBuf.ar(2,bufread,rate,BufRateScale.kr(bufread),startPos,loop,reset);

			//
			if(normalizer != true,{

					// sin normalizador
					Out.ar(out,Pan2.ar(sample),amp);

				},{

				// con normalizador
				Out.ar(out,Normalizer.ar(Pan2.ar(sample),normLevel),amp);

			});


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
