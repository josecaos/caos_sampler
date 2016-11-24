//
CaosSampler {


	*init {

		var s = Server.local;
		var url = thisProcess.nowExecutingPath.dirname;

			(url +/+ "core/inform.scd").load;

		s.waitForBoot({


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

			url.postcln;
			~inform.value("CaosSampler Activado",0.085)
			},
			50,
			{fork{~inform.value("Error al iniciar, recompila tu librería.")}}

		);
	}

}
