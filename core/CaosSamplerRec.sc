//
CaosSamplerRec : CaosSampler {


	*overDub {|texto = "Sobredubeando: "|

		 fork{~inform.value(texto + coreurl, 0.125)};

		^this.instance;

	}


	instance {

		^"Hey dub";
	}



}