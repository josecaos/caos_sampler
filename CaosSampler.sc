//
CaosSampler {

	classvar <server, <>coreurl, <>audiourl, <ids, <id;
	classvar <bufread, <run1, <run2, <run3, <instances, <playname = "Generic name";
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
		SynthDef(\play,{|rate = 1, amp = #[1,1], trigger = 0, out = 0, startPos = 0, loop = 1, reset = 0|

			var sample;

			sample = PlayBuf.ar(2, bufread, rate, trigger, startPos, loop, reset);

			Out.ar(out,sample)*amp;

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

	*register {|name|

		playname = name;

		//tres instancias
		run1 = Synth.newPaused(\play);

		run2 = Synth.newPaused(\play);

		run3 = Synth.newPaused(\play);

		//Hack para tocar en vivo al rato

		~hack1 = Synth.newPaused(\play);

		~hack2 = Synth.newPaused(\play);

		~hack3 = Synth.newPaused(\play);

		//


		instances = [run1, run2, run3];

		//
		// info = [["Group name: ", name], ["Instance Nodes: ",instances[0].nodeID, instances[1].nodeID, instances[2].nodeID]];//asocia nombre de sinte con nombre de argumento ID + numero de nodo
		info = [["Group name: ", name], ["Instance Nodes: ",~hack1.nodeID, ~hack2.nodeID, ~hack3.nodeID]];//asocia nombre de sinte con nombre de argumento ID + numero de nodo

		ids.add(info);//agrega informacion a un array global para posterior iidentificacion


		fork{~inform.value("Synth group: " + name + "registered",0.01)};

		// ^instances.run;//sin correr
		^"";

	}

	*play {|paused = true|

		if(paused != true, {

			fork{~inform.value("Synth: " + playname + "paused",0.01)};


			}, {

				fork{~inform.value("Synth: " + playname + "running",0.01)};

		});

		// ^[instances[0].run(paused),instances[1].run(paused),instances[2].run(paused)];
		^[~hack1.run(paused),~hack2.run(paused),~hack3.run(paused)];
	}

	//depende del metodo .instance
	*setToPlay {|index, args|

		var instanceinform = fork{~inform.value("Synth instance" + ids[0][1][num] + "affected",0.01)};

		var setargs;
args.postcln;

		num = index;
		//
		if(num >= 4 || num == 0, {

			fork{~inform.value("Use only numbers from '1 to 3 to set arguments for each instance",0.01)};

			}, {

				switch(num,
					1,{instanceinform; run1.set(args)},
					2,{instanceinform; ^instances[1].set(args)},
					3,{instanceinform; ^instances[2].set(args)}
				);

		});
		//

		// ^setargs.set(args);
	}

	*samplerName {

		var name = playname;

		fork{~inform.value("Instance Name: " + name + "||  All Instances: " + ids.join, 0.01)};

		^name;

	}

	*stopAll {

		thisProcess.stop;

		fork{~inform.value("All Instances stopped ", 0.01)};

		^"";
	}

	//
}
// 