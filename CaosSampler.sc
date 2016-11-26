//
// me quede buscando como conseguir la url de la clase
//
CaosSampler {

	// var >path;

	*init {

		var s = Server.local;

		var path = this.filenameSymbol.asString.dirname;//

		// ~uri = PathName.new(Platform.userExtensionDir);

			// ~uri = thisProcess.nowExecutingPath.dirname;
			// ~uri = PathName.new(thisProcess.nowExecutingPath.dirname);

		s.waitForBoot({

		// platform.ideName.postcln;

			// modulo de informacion
			// (~uri +/+ "core/inform.scd").load;

			//revisa plataforma
			Platform.case(
				\linux,     { "Estás usando Linux".postln},
				// \windows,   { ~inform.value("Estás usando Windows".postln)},
				\windows,     { "Estás usando Windows".postln},
				// \linux,     { ~inform.value("Estás usando Linux".postln)},
				\osx,       {"Estás usando OSX".postln},
				// \osx,       { ~inform.value("Estás usando OSX".postln)},
			);


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

/*		platform.platformDir.postcln;
		platform.classLibraryDir.postcln;*/

		// ^"hola caos sampler";
		^path;
	}

}
