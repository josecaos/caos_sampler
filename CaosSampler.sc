//
CaosSampler {


	*init {

		var s = Server.local;

		~uri = thisProcess.nowExecutingPath.dirname;

		(~uri +/+ "core/inform.scd").load;

		s.waitForBoot({

			// el sampler tocara varios canales simultaneos instancias de el mismo sinte
			//uno directos a master y otros procesado por la caosbox o una ruta
			//
			(~uri +/+ "core/load-audio-file.scd").load;
			(~uri +/+ "synths/sampler.scd").load;
			(~uri +/+ "synths/synths.scd").load;
			(~uri +/+ "midi/midiin.scd").load;

			~inform.value("CaosSampler Activado",0.085)

			},

			50,

			{fork{~inform.value("Error al iniciar, recompila tu librería.")}}

		);

		// ^

	}

}
