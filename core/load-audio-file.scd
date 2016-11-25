// estos seran metodos para asi poder cambiar el track por medio un parametro url

~track = {|name|

	var fileurl = ~uri+/+ "audios";

	fork{~inform.value(fileurl)};
	// Buffer.read(s,fileurl +/+ name, 0, -1);

};
//
// arreglar BUG
//problema por que la funcion carga el archivo y se declaran tantos buffers como aparezca la funcion
// ~track.value("13-josecaos-Nuestro_amigo_Boox-bonus_track.wav");

// overdub
// ~retrack = Buffer.alloc(s,s.sampleRate * 8,2);
