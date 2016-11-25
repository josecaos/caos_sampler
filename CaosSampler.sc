//
// me quede buscando como conseguir la url de la clase
//
CaosSampler {

	// var >path;

	*init {

		var platform = Platform;
		var s = Server.local;

		// ~uri = PathName.new(Platform.userExtensionDir);


		s.waitForBoot({

		// platform.ideName.postcln;

			// modulo de informacion
			// (~uri +/+ "core/inform.scd").load;

			//revisa plataforma
			Platform.case(
				\linux,     { "Estás usando Linux".postln},
				// \windows,   { ~inform.value("Estás usando Windows".postln)},
				\linux,     { "Estás usando Linux".postln},
				// \linux,     { ~inform.value("Estás usando Linux".postln)},
				\osx,       {"Estás usando OSX".postln},
				// \osx,       { ~inform.value("Estás usando OSX".postln)},
			);

			// ~uri = thisProcess.nowExecutingPath.dirname;
			// ~uri = PathName.new(thisProcess.nowExecutingPath.dirname);

			/*~uri.folderName.postcln;
			~uri.postcln;*/


			// el sampler tocara varios canales simultaneos instancias de el mismo sinte
			//uno directos a master y otros procesado por la caosbox o una ruta
			//
			// (~uri +/+ "core/load-audio-file.scd").load;
			// (~uri +/+ "synths/sampler.scd").load;
			// (~uri +/+ "synths/synths.scd").load;
			// (~uri +/+ "midi/midiin.scd").load;

			// ~inform.value("CaosSampler Activado",0.085)

			},

			50,

			{fork{~inform.value("Error al iniciar, recompila tu librería.")}}

		);


		platform.platformDir.postcln;
		platform.classLibraryDir.postcln;

		^"hola caos sampler";
	}

}
