//
CaosSampler {

	classvar <>coreurl, <s;


	*new {

		coreurl = this.filenameSymbol.asString.dirname;

		^super.new.init;

	}

	init {

		s = Server.local;

		if(s.serverRunning == true ,{

			"servidor encendido".inform;

			},{

				"servidor apagado".inform;

				s.waitForBoot({

					"ya ya esta encendido".inform;

				});
		});

		//revisa plataforma
		Platform.case(
			\linux, { ~inform.value("Estás usando Linux")},
			\windows, { ~inform.value("Estás usando Windows")},
			\osx, { ~inform.value("Estás usando OSX")},
		);
		//
		(coreurl +/+ "core/inform.scd").load;
		// (coreurl +/+ "core/load-audio-file.scd").load;
		// (coreurl +/+ "synths/sampler.scd").load;
		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

		//return
		^fork{~inform.value("CaosSampler Activado",0.085)}

	}


}
