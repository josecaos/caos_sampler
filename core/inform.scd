//init
//textos de aviso
~inform = {|print = "CaosSampler written by @joseCao5 \n", tempoTexto = 0.025, breakLine = true|

	var txt = print.asArray;
	var texto = txt.size;
	var letrero = Array.newClear(texto);

	texto.do({|i|

		letrero.put(i, txt[i]);

		letrero[i].asString.post;

		tempoTexto.wait;

		0.yield;//regresa un valor vacio, para evitar que se imprima en el post
	});
	//
	if(breakLine == true, {

		"\n".postln;

	});


};
//