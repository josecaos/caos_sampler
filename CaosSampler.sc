//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <>run;
	classvar <bufread, <playname = "Generic name";



	*new {

		coreurl = this.filenameSymbol.asString.dirname;

		^super.new.init;

	}

	init {

		server = Server.local;

		(coreurl +/+ "core/inform.scd").load;

		// revisa si el servidor esta corriendo
		if(server.serverRunning != true ,{

			// si no, enciendelo
			// server.boot;

			fork{1.75.wait;~inform.value("Wait",0.025,false);~inform.value(" .... ",0.1,false);~inform.value("CaosSampler instance created",0.025)}

			}, {

				fork{~inform.value(" .... ",0.1,false);~inform.value("CaosSampler instance created",0.025)}

		});
		//

		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

		^"";
	}

	*loadTrack {|name = "test-caos_sampler-115_bpm.wav", startFrame = 0|

		var informPositive = {fork{~inform.value("The file " ++ name ++ " has been loaded" ,0.025)}};

		audiourl = coreurl +/+ "audios/";

		bufread = Buffer.read(server,audiourl ++ name, startFrame, -1, informPositive);

		//
		//sinte
		SynthDef(\play,{|rate = 1, amp = #[1,1], trigger = 0, out = 50, startPos = 0, loop = 0, reset = 0|

			var sample;

			sample = PlayBuf.ar(2, bufread, rate, trigger, startPos, loop, reset);

			Out.ar(out,Pan2.ar(sample),amp);

		}).add;

		//
		^"";

	}

	*viewTrack {|position|

		// El view del sampleo estara completo mas adelante
		//
		//waveform GUI
		var y, x, w, a, f;

		position = 0;//reset de posicion


		y = Window.screenBounds.height - 25;
		x = Window.screenBounds.width;
		w = Window.new("CaosSampler instance soundfile", Rect(400, y, x, 220)).alwaysOnTop_(true);
		a = SoundFileView.new(w, Rect(5,5, x, 210));
		// bufread.inspect;

		a.soundfile = bufread;
		a.read(0, bufread.numFrames);
		a.elasticMode = true;

		a.timeCursorOn = true;
		a.timeCursorColor = Color.red;
		a.drawsWaveForm = true;
		a.gridOn = true;
		a.gridResolution = 0.1;
		// a.zoom(1).refresh;



		a.action = {|lecture|
			/*
			lecture = a.readProgress.postln;

			a.timeCursorPosition  =  lecture;

			a.timeCursorPosition.postcln;
			*/

			lecture.postcln;

		};


		^w.front;//imprime ventana



	}


	*play {|id = "Generic Name for Sampler"|

		playname = id;

		run = Synth(\play);

		run.defName;

		fork{~inform.value("Synth: " + id + "running",0.01)};

		^run;
	}

	*setToPlay {|args|

		fork{~inform.value("Sampler: " + playname + "arguments modified", 0.01)};

		^run.set(args);

	}

	*samplerName {

		fork{~inform.value("Instance Name: " + playname, 0.01)};

		^"";
	}

}

