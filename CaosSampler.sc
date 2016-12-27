//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <ids, <id;
	classvar <bufread, <run1, <run2, <run3, <>instances, <playname = "No name";
	classvar <num = 1, >info;


	*new {

		coreurl = this.filenameSymbol.asString.dirname;

		^super.new.init;

	}

	init {

		server = Server.local;

		ids = Array.new(4);//array de ids de los sintes usados

		(coreurl +/+ "core/inform.scd").load;

		// revisa si el servidor esta corriendo
		if(server.serverRunning != true ,{

			// si no, enciendelo
			server.boot;

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
		//sintes
		SynthDef(\playsample,{|rate = 1, pan = 0, amp = 1, trigger = 0, out = 50, startPos = 0, loop = 1, reset = 0|

			var sample;

			sample = PlayBuf.ar(2, bufread, rate, trigger, startPos, loop, reset);

			Out.ar(out,Pan2.ar(sample,pan,amp));

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

			lecture = a.readProgress;

			a.timeCursorPosition.poll;
			a.readProgress.poll;


		};

		^w.front;//imprime ventana

	}

	// registra el numero de copias de el audio a tocar
	*register {|name, copies = 3|

		var infoinstances;

		playname = name;

		instances = Array.newClear(copies);


		if(copies >=4 || copies == 0,{

			fork{~inform.value("Only 1 to 3 simultaneous copies allowed",0.01)};

			}, {


				switch(copies,

					1,{run1 = Synth.newPaused(\playsample);
						instances = instances.put(0,run1);
						infoinstances = instances[0].nodeID;
					},

					2,{run1 = Synth.newPaused(\playsample);run2 = Synth.newPaused(\playsample);
						instances = instances.put(0,run1);instances = instances.put(1,run2);
						infoinstances = [instances[0].nodeID, instances[1].nodeID].join(", ");
					},

					3,{run1 = Synth.newPaused(\playsample);run2 = Synth.newPaused(\playsample);run3 = Synth.newPaused(\playsample);
						instances = instances.put(0,run1);instances = instances.put(1,run2); instances = instances.put(2,run3);
						infoinstances = [instances[0].nodeID,instances[1].nodeID,instances[2].nodeID].join(", ");
					}

				);


				fork{~inform.value("You chose " + copies + "track(s) to run simultaneously",0.01)};

				////asocia nombre de sinte con instancias
				info = [["Track name", name].join(": "), ["Instance Nodes", infoinstances].join(": ")].join(" => ");
				//
				ids.add(info);//agrega informacion a un array global para posterior identificacion

				fork{1.wait;~inform.value("Track Name: " + name + "registered",0.01)};

		});

		^"";
	}

	*trackName {

		var name = playname;

		fork{~inform.value("Instance Name: " + name + "||  All Instances: " + ids.join, 0.01)};

		^name;

	}

	*play {|paused = true, args|

		if(paused != true, {

			fork{~inform.value("Synth: " + playname + "paused",0.01)};


			}, {

				fork{~inform.value("Synth: " + playname + "running",0.01)};

		});

		// ^[instances[0].run(paused),instances[1].run(paused),instances[2].run(paused)];
		switch(instances.size,
			1,{instances[0].run(paused)},
			2,{[instances[0].run(paused),instances[1].run(paused)]},
			3,{[instances[0].run(paused),instances[1].run(paused),instances[2].run(paused)]}
		);
	}

	//depende del metodo .instance
	*setToPlay {|index, args|

		var instanceinform;

		var setargs;

		num = index;
		//
		if(num >= 4 || num == 0, {

			fork{~inform.value("Use only numbers from '1 to 3' as first argument, to choose instance",0.01)};

			}, {

				var i = num-1;

				instanceinform = fork{~inform.value("Synth instance" + instances[i].nodeID + "affected",0.01)};

				switch(num,
					1,{instanceinform; ^instances[i].set(args)},
					2,{instanceinform; ^instances[i].set(args)},
					3,{instanceinform; ^instances[i].set(args)}
				);

		});

	}

	*stopAll {

		thisProcess.stop;

		fork{~inform.value("All Instances stopped ", 0.01)};

		^"";
	}

	//
}
// 