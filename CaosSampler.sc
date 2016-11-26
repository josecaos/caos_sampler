//
CaosSampler {

	classvar <server, <>coreurl, <>audioname, <bufread;


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
		^fork{1.wait;~inform.value("Wait",0.1);~inform.value(" ... ",0.25);0.01.wait;~inform.value("CaosSampler activated",0.1)}

	}

	*loadTrack {|name = "test-caos_sampler-115_bpm.wav", startFrame = 0|

		audioname = coreurl +/+ "audios/";

		bufread = Buffer.read(server,audioname ++ name, startFrame, -1);

		//pull synths
		// (coreurl +/+ "synths/sampler.scd").load;

		(
			SynthDef(\play,{|rate = 1, amp = #[1,1], out = 50, startPos = 0, loop = 0, reset = 0|

				var sample;

				sample = PlayBuf.ar(2,bufread,rate,BufRateScale.kr(bufread),startPos,loop,reset);

				Out.ar(out,Pan2.ar(sample),amp);

			}).add;
		);

		^fork{~inform.value(audioname ++ name,0.05)};
	}

}
