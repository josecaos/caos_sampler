//
CaosSampler {

	classvar <server, <>coreurl,  <>audiourl, <id, <ids, info;
	classvar <run1, <run2, <run3, <>instances;
	classvar <bufread, reverse = 0;
	classvar >playname = "Default name";
	classvar <num = 1;
	//
	var <synthNum = 0;

	*new {

		coreurl = this.filenameSymbol.asString.dirname;


		^super.new.init;

	}

	init {

		server = Server.local;

		ids = [];//array de ids de los sintes usados

		// revisa si el servidor esta corriendo
		if(server.serverRunning != true ,{

			// si no, enciendelo
			server.waitForBoot{

				fork{~inform.value("Server boot .... CaosSampler instance created",0.015,false);}

			};

			}, {

				fork{~inform.value(" .... CaosSampler instance created ",0.015,false)}

		});

		synthNum = synthNum + 1;//indice de synthefs
		(coreurl +/+ "core/inform.scd").load;

		^"";

	}

	*loadTrack {|filename = "test-caos_sampler-115_bpm.wav", startFrame = 0|

		var informPositive = {fork{~inform.value("The file " ++ filename ++ " has been loaded" ,0.015)}};

		audiourl = coreurl +/+ "tracks/";

		bufread = Buffer.read(server,audiourl ++ filename, startFrame, -1, informPositive);


		//
		^this.buildSynth(bufread.bufnum);

	}

	*buildSynth {|bufnumb|
		//sintes
		SynthDef(\sample,{|rate = 1, pan = 0, amp = 1, trigger = 0,
			out = 50, startPos = 0, loop = 1, reset = 0|

			var sample;

			sample = PlayBuf.ar(2, bufnumb, rate, trigger, startPos, loop, reset);

			Out.ar(out,Pan2.ar(sample,pan,amp));

		}).add;
	}

	// registra el numero de copias simultaneas de el track
	*register {|name, copies = 3|

		var infoinstances;

		playname = name;

		instances = Array.newClear(copies);


		if( copies < 1 or: {copies > 3},{

			fork{~inform.value("Only 1 to 3 simultaneous copies allowed",0.01)};

			}, {

				switch(copies,

					1,{
						run1 = Synth.newPaused(\sample,[\amp,1]);
						instances = instances.put(0,run1);
						infoinstances = instances[0].nodeID;
					},

					2,{
						run1 = Synth.newPaused(\sample,[\amp,1]);
						run2 = Synth.newPaused(\sample,[\amp,0]);
						instances = instances.put(0,run1);
						instances = instances.put(1,run2);
						infoinstances = [instances[0].nodeID, instances[1].nodeID].join(", ");
					},

					3,{
						run1 = Synth.newPaused(\sample,[\amp,1]);
						run2 = Synth.newPaused(\sample,[\amp,0]);
						run3 = Synth.newPaused(\sample,[\amp,0]);
						instances = instances.put(0,run1);
						instances = instances.put(1,run2);
						instances = instances.put(2,run3);
						infoinstances = [instances[0].nodeID,instances[1].nodeID,instances[2].nodeID].join(", ");
					}

				);

				fork{~inform.value("You chose " + copies + "track(s) to run simultaneously",0.01)};

				////asocia nombre de sinte con instancias
				info = [["Track name", name].join(": "), ["Instance Nodes", infoinstances].join(": ")].join(" => ") + "";
				//
				ids = ids.add(info);//agrega informacion a un array global para posterior identificacion

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
		if(num < 1 or: {num > 3} , {

			fork{~inform.value("Use only numbers between '1 and 3' as first argument, to choose instance",0.015)};

			^"";

			}, {

				var inst = num-1;
				var variables;

				instanceinform = fork{~inform.value("Synth instance #" ++ num + "with node:" + instances[inst].nodeID + " affected",0.01)};
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

	*speed {|vel = 1|

		var arr = instances.size;

		switch(arr,
			1,{
				instances[0].set(\rate,vel);
			},
			2,{
				instances[0].set(\rate,vel);
				instances[1].set(\rate,vel);
			},
			3,{
				instances[0].set(\rate,vel);
				instances[1].set(\rate,vel);
				instances[2].set(\rate,vel);

			}
		);
		fork{~inform.value("All instances changed speed rate to " ++ vel,0.01)};

		^"";
	}

	*toggleReverse {|rate = 1|

		var res;

		switch(reverse,
			0,{
				res = rate * -1;
				instances.collect({|item|
					item.set(\rate,res);
				});
				reverse = reverse + 1;
				fork{~inform.value("Track reversed: " ++ res ,0.001)};
			},
			1,{
				res = rate * 1;
				instances.collect({|item|
					item.set(\rate,res);
				});
				reverse = 0;//reset
				fork{~inform.value("Track with normal rate: " ++ res ,0.001)};
			}
		);

		^"";
	}

	*out {|instance = 1, chan = 50|

		var arr = instances.size;

		if(instance == 'all', {

			switch(arr,
				1,{
					instances[0].set(\out,chan);
				},
				2,{
					instances.collect({|item|
						item.set(\out,chan);
					});
				},
				3,{
					instances.collect({|item|
						var a;
						a = item.set(\out,chan);
					});
				}

			);
			fork{~inform.value("All instances chaged output to channel: " ++ chan,0.01)};

			}, {

				if(instance < 1 or: {instance > 3} , {

					fork{~inform.value("Use only numbers between 1 to 3, or \all symbol, as first argument, to choose instance Output",0.015)};
					},{
						switch(instance,
							1,{instances[0].set(\out,chan);},
							2,{instances[1].set(\out,chan);},
							3,{instances[2].set(\out,chan);}
						);
						fork{~inform.value("Instance #" ++ instance ++ " changed output to " ++ chan,0.01)};
					}
				);
		});

		^"";

	}

	*amp {|instance = 1, amp = 1|

		var arr = instances.size;

		if(instance == 'all', {

			switch(arr,
				1,{
					instances[0].set(\amp,amp);
				},
				2,{
					instances.collect({|item|
						item.set(\amp,amp);
					});
				},
				3,{
					instances.collect({|item|
						var a;
						a = item.set(\amp,amp);
					});
				}

			);

			}, {

				if(instance < 1 or: {instance > 3}, {

					fork{~inform.value("Use only numbers between 1 to 3, or \all symbol, as first argument, to choose instance Output",0.015)};
					},{

						switch(instance,
							1,{instances[0].set(\amp,amp);},
							2,{instances[1].set(\amp,amp);},
							3,{instances[2].set(\amp,amp);}
						);

						fork{~inform.value("Instance #" ++ instance ++ " changed amplitude to " ++ amp,0.015)};
					}
				);

		});//endif

		^"";

	}


	*stopAll {

		thisProcess.stop;

		fork{~inform.value("All Instances stopped ", 0.01)};

		^"";
	}


	*testNombre {|nombre = "default"|

		// id, ids, info
		var x;
		x = ids.add(nombre);

		^ids.postln;

	}


}


