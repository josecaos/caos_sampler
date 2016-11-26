//
CaosSampler {

	classvar <>coreurl, <>audiourl, <server;


	*new {

		coreurl = this.filenameSymbol.asString.dirname;

		^super.new.init;

	}

	init {

		server = Server.local;

		(coreurl +/+ "core/inform.scd").load;

		// revisa si el servidor esta corriendo
		if(server.serverRunning != true ,{

			server.boot;

		});
		//

		// (coreurl +/+ "core/load-audio-file.scd").load;
		// (coreurl +/+ "synths/sampler.scd").load;
		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

		//return
		^fork{2.wait;~inform.value("Wait",0.1);~inform.value(" ... ",0.5);0.01.wait;~inform.value("CaosSampler activated",0.1)}

	}

	*loadTrack {|name|
		audiourl = coreurl +/+ "audios/";

		fork{~inform.value(audiourl ++ name,0.05)};
		// Buffer.read(s,fileurl +/+ name, 0, -1);

	}

}
