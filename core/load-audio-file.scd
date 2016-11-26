// estos seran metodos para asi poder cambiar el track por medio un parametro url

	*loadTrack {|name|

		audiourl = coreurl +/+ "audios";

		fork{~inform.value(audiourl,0.1)};
		// Buffer.read(s,fileurl +/+ name, 0, -1);

	}
//
// arreglar BUG
// ~track.value("13-josecaos-Nuestro_amigo_Boox-bonus_track.wav");

// overdub
// ~retrack = Buffer.alloc(s,s.sampleRate * 8,2);
