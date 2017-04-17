//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <ids, <id;
	classvar <run1, <run2, <run3, <>instances;
	classvar <num = 1, >info;
	classvar <bufread;
	classvar >playname = "No name";


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
			server.waitForBoot{

				fork{~inform.value("Server boot .... CaosSampler instance created",0.015,false);}

			};

			}, {

				fork{~inform.value(" .... CaosSampler instance created ",0.015,false)}

		});
		//

		// (coreurl +/+ "synths/synths.scd").load;
		// (coreurl +/+ "midi/midiin.scd").load;

		^"";
	}

	*loadTrack {|name = "test-caos_sampler-115_bpm.wav", startFrame = 0|

		var informPositive = {fork{~inform.value("The file " ++ name ++ " has been loaded" ,0.015)}};

		audiourl = coreurl +/+ "tracks/";

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

/*
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
		// a.read(0, bufread.numFrames);todo el acrhivo
		a.readFile(bufread,0, bufread.numFrames);//tambien todo el archivo
		// a.elasticMode = true;

		a.timeCursorOn = true;
		a.timeCursorColor = Color.red;
		a.drawsWaveForm = true;
		a.gridOn = true;
		a.gridResolution = 0.1;
		// a.zoom(1).refresh;


		// Esta funcion se evalua al ineractuar con la ventana, no al evaluarla
		a.action = {|lecture|

			//
			// lecture = a.readProgress;
			//
			lecture.asString.postcln;
			position.postcln;
			a.timeCursorPosition.postcln;//muestra la posicion en frames del cursor

			a.readProgress.poll;
		};

		^w.front;//imprime ventana

	}
*/

	// registra el numero de copias de el audio a tocar
	*register {|name, copies = 3|

		var infoinstances;

		playname = name;

		instances = Array.newClear(copies);


		if( copies == 0 || copies < 0 || copies > 3,{

			fork{~inform.value("Only 1 to 3 simultaneous copies allowed",0.01)};

			}, {

				switch(copies,

					1,{run1 = Synth.newPaused(\playsample,[\amp,1]);
						instances = instances.put(0,run1);
						infoinstances = instances[0].nodeID;
					},

					2,{run1 = Synth.newPaused(\playsample,[\amp,1]);run2 = Synth.newPaused(\playsample,[\amp,0]);
						instances = instances.put(0,run1);instances = instances.put(1,run2);
						infoinstances = [instances[0].nodeID, instances[1].nodeID].join(", ");
					},

					3,{run1 = Synth.newPaused(\playsample,[\amp,1]);run2 = Synth.newPaused(\playsample,[\amp,0]);run3 = Synth.newPaused(\playsample,[\amp,0]);
						instances = instances.put(0,run1);instances = instances.put(1,run2); instances = instances.put(2,run3);
						infoinstances = [instances[0].nodeID,instances[1].nodeID,instances[2].nodeID].join(", ");
					}

				);


				fork{~inform.value("You chose " + copies + "track(s) to run simultaneously",0.01)};

				////asocia nombre de sinte con instancias
				info = [["Track name", name].join(": "), ["Instance Nodes", infoinstances].join(": ")].join(" => ") + "";
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

		switch(instances.size,

			1,{instances[0].run(paused)},

			2,{[instances[0].run(paused),instances[1].run(paused)]},

			3,{[instances[0].run(paused),instances[1].run(paused),instances[2].run(paused)]}

		);

		^"";
	}

	//depende del metodo .instance
	*setToPlay {|number, params|

		var instanceinform, values;

		num = number;
		//
		if(num == 0 || num < 0 || num > 3 , {

			fork{~inform.value("Use only numbers between '1 and 3' as first argument, to choose instance",0.015)};

			^"";

			}, {

				var inst = num-1;
				var variables;

				instanceinform = fork{~inform.value("Synth instance #" ++ num + "with node:" + instances[inst].nodeID + "affected",0.01)};
				//

				//iguala los argumentos necesarios
				values = params.copySeries(1,3,11);
				variables = Array.newClear(6);//numero de argumentos

				for(0,(params.size/2)-1, {|i|

					variables[i] = values[i];//asignacion de valor de argumento

				});

				//
				^instances[inst].set(\out,variables[0],\loop,variables[1],\rate,variables[2],\trigger,variables[3],\startPos,variables[4],\amp,variables[5]);

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
