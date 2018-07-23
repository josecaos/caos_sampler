// Sintes para el sampler
// La salida de los sintes es por default al master de la caosbox, cosa que podria
//
+ AbstractPlayControl {
	//
	// *loadTrack {|name = "test-caos_sampler-115_bpm.wav", startFrame = 0|
	//
	//
	// 	audiourl = coreurl +/+ "audios/";
	//
	// 	bufread = Buffer.read(server,audiourl ++ name, startFrame, -1);
	//
	// 	normalizeIn = false;
	// 	//
	// 	//sinte
	// 	SynthDef(\play,{|rate = 1, amp = #[1,1], out = 50, startPos = 0, loop = 0, reset = 0, normalizer, normLevel = 0.9|
	//
	// 		var sample;
	//
	// 		normalizer = normalizeIn;
	//
	// 		sample = PlayBuf.ar(2,bufread,rate,BufRateScale.kr(bufread),startPos,loop,reset);
	//
	// 		//
	// 		if(normalizer != true,{
	//
	// 			// sin normalizador
	// 			Out.ar(out,Pan2.ar(sample),amp);
	//
	// 			},{
	//
	// 				// con normalizador
	// 				Out.ar(out,Normalizer.ar(Pan2.ar(sample),normLevel),amp);
	//
	// 		});
	//
	//
	// 	}).add;
	// 	//
	//
	// 	^fork{~inform.value("The file " ++ name ++ " has been loaded" ,0.05)};
	// }
	//

}
//
// (//se graba a dos canales
// SynthDef(\rec,{|run = 0, amp = 0.85, out = 50, trigger = 1, loop = 0, reset = 0|
//
// 	var sample;
//
// 	sample = RecordBuf.ar(~track,~retrack,0,1,0,run,loop,trigger,reset);
//
// 	Out.ar(out,sample);
//
// }).add;
// );
// (//replay
// SynthDef(\replay,{|rate = 1, amp = 0.85, out = 64, startPos = 0, loop = 0, reset = 0|
//
// 	var sample;
//
// 	sample = PlayBuf.ar(2,~retrack.bufnum,rate,BufRateScale.kr(~track.bufnum),startPos,loop,reset);
//
// 	Out.ar(out,sample);
//
// }).add;
//
// );
