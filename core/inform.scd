//init
//textos de aviso
//args -> 'string',number
~inform = {|imprime = "CaosSampler written by josecaos", tempoTexto = 0.075|

	var txt = imprime.asArray;
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