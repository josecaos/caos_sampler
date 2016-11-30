//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <>run;
	classvar <bufread;


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
			server.boot;

			^fork{1.75.wait;~inform.value("Wait",0.025,false);~inform.value(" .... ",0.1,false);~inform.value("CaosSampler instance created",0.025)}

			}, {

				^fork{~inform.value(" .... ",0.1,false);~inform.value("CaosSampler instance created",0.05)}

		});
		//

		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

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

		//waveform GUI
		var y, x, w, a, f, much, string;

		w = Window;
		position = 0;//reset de posicion


		w.new("CaosSampler instance soundfile", Rect(200, y, x, 100)).alwaysOnTop_(true);
		y = Window.screenBounds.height - 50;
		x = Window.screenBounds.width;
		a = SoundFileView.new(w, Rect(5,5, x, 90));
		// bufread.inspect;

		a.soundfile = bufread;
		a.read(0, bufread.numFrames);
		a.elasticMode = true;

		a.readProgress;

		a.timeCursorOn = true;
		a.timeCursorColor = Color.red;
		// a.timeCursorPosition = position;
		a.drawsWaveForm = true;
		a.gridOn = true;
		a.gridResolution = 0.1;
		// a.zoom(1).refresh;

		//
		string = "gui ".dup(24).join;
		much = = 0.02;

		w.drawFunc = Routine {
			    var i = 0;
			    var size = 40;
			    var func = { |i, j| sin(i * 0.07 + (j * 0.0023) + 1.5pi) * much + 1 };
			    var scale;
			    var font = Font("Helvetica", 40).boldVariant;
			    loop {
				        i = i + 1;
				        Pen.font = font;
				        string.do { |char, j|

					            scale = func.value(i, j).dup(6);

					            Pen.fillColor = Color.new255(0, 120, 120).vary;
					            Pen.matrix = scale * #[1, 0, 0, 1, 1, 0];
					            Pen.stringAtPoint(char.asString,
						                ((size * (j % 9)) - 10) @ (size * (j div: 9))
					            );
				        };
				        0.yield // stop here, return something unimportant
			    }
		};

		{ while { w.isClosed.not } { w.refresh; 0.04.wait; } }.fork(AppClock);
		//
		//

		^w.front;//imprime ventana


		// fork{~inform.value(Window.allWindows)}

	}


	*play {

		^run = Synth(\play);

	}

	*setToPlay {|args|

		^run.set(args);

	}

}
