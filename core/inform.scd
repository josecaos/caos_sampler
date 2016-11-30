//init
//textos de aviso
~inform = {|print = "CaosSampler written by josecaos \n", tempoTexto = 0.075, breakLine = true|

	var txt = print.asArray;
	var texto = txt.size;
	var letrero = Array.newClear(texto);

	texto.do({|i|

		letrero.put(i, txt[i]);

		letrero[i].asString.post;

		tempoTexto.wait;

	});
	//
	if(breakLine == true, {

		"\n".postln;

	});

};
//