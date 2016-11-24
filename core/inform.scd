	//init
	//textos de aviso
	~inform = {|textoIn = "CaosSampler written by josecaos", tempoTexto = 0.075|

		var txt = textoIn.asArray;
		var texto = txt.size;
		var letrero = Array.newClear(texto);

		texto.do({|i|

			letrero.put(i, txt[i]);

			letrero[i].asString.post;

			tempoTexto.wait;

	})
	};
	//
// ~inform.value;
	// fork{~inform.value("esta es una prueba",0.125);}