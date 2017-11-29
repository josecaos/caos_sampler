CaosSampler {

	classvar <server, <>coreurl,  <>audiourl,  <info;
	classvar <run1, <run2, <run3;
	classvar <num = 1, reverse = 0;
	classvar <>tracks, <ids, <instances;
	//
	var <>trackname;
	var <bufread;


	*loadTrack {|name = "Default",fileName = "test-caos_sampler-115_bpm.wav",copies = 1, startFrame = 0|

		coreurl = this.filenameSymbol.asString.dirname;
		(coreurl +/+ "core/inform.scd").load;

		^super.new.init(name,fileName,copies,startFrame);

	}

	init {|name,fileName,copies,startFrame|

		server = Server.local;

		this.trackName(name);

		if(server.serverRunning != true ,{

			server.waitForBoot{

				1.do({
					this.inform("Server boot ...  ",0.075,true);
					1.5.yield;
					this.load(trackname,fileName,copies,startFrame);
					1.yield;
					this.inform("CaosSampler instance created",0.015,true);
				});

			};
			}, {

				fork {
					1.do({
						this.load(trackname,fileName,copies,startFrame);
						1.yield;
						this.inform(" .... CaosSampler instance created ",0.015,true);
					});
				}

		});
		//
		^"";
	}

	trackName {|name|
		// evita sobre escritura del array
		if(tracks.isNil, {
			tracks = Array.new(20);
			ids = Array.new(20);
			^this.trackname_(name);
			},{
				tracks = tracks;
				ids = ids;
				^this.trackname_(name);
		});

	}

	load {|name,fileName,copies,startFrame|

		var informPositive = fork{1.wait;this.inform("The file " ++ fileName ++ " has been loaded" ,0.015) };

		audiourl = coreurl +/+ "tracks/";

		name = Buffer.read(server,audiourl ++ fileName, startFrame, -1, informPositive);

		^this.buildSynth(trackname,name.bufnum,copies);

	}

	buildSynth {|synthName, bufnumb,copies|
		//sinte
		SynthDef(synthName.asSymbol,{|rate = 1, pan = 0, amp = 1, trigger = 0,
			out = 50, startPos = 0, loop = 1, reset = 0|

			var sample;

			sample = PlayBuf.ar(2,bufnumb,rate,trigger,startPos,loop,reset);

			Out.ar(out,Pan2.ar(sample,pan,amp));

		}).add;

		this.register(synthName.asSymbol,copies);

		^"";

	}

	// registra el numero de copias simultaneas por track
	register {|name, copies|

		var infoinstances;
		var synth = name.asSymbol;

		instances = Array.newClear(copies);

		if( copies < 1 or: {copies > 3}, {

			fork{2.5.wait;this.inform("Only 1 to 3 simultaneous copies allowed",0.01)  };

			}, {

				if( tracks.find([name]).isNil, {

					switch(copies,

						1,{
							run1 = Synth.newPaused(synth,[\amp,1]);
							instances = instances.put(0,run1);
							infoinstances = instances[0].nodeID;
						},

						2,{
							run1 = Synth.newPaused(synth,[\amp,1]);
							run2 = Synth.newPaused(synth,[\amp,0]);
							instances = instances.put(0,run1);
							instances = instances.put(1,run2);
							infoinstances = [instances[0].nodeID, instances[1].nodeID].join(", ");
						},

						3,{
							run1 = Synth.newPaused(synth,[\amp,1]);
							run2 = Synth.newPaused(synth,[\amp,0]);
							run3 = Synth.newPaused(synth,[\amp,0]);
							instances = instances.put(0,run1);
							instances = instances.put(1,run2);
							instances = instances.put(2,run3);
							infoinstances = [instances[0].nodeID,instances[1].nodeID,instances[2].nodeID].join(", ");
						}

					);

					fork{3.wait;this.inform("You chose " + copies + "track(s) to run simultaneously",0.01)  };

					////asocia nombre de sinte con instancias
					info = [["Track name", name].join(": "),
						["Instance Nodes", infoinstances].join(": ")].join(" => ");

					ids = ids.add(info);//agrega informacion a un array global para posterior identificacion

					tracks = tracks.add(name);//agrega nombre a array

					fork{4.wait;this.inform("Track Name: " + name + "registered ",0.01)};

					}, {

						fork{4.wait;this.inform("Track name already exists and was not registered, try another one!",0.01)};

				});

		});


		^"";
	}


	//depende del metodo .instance
	*setToPlay {|number, params|

		var instanceinform, values;

		num = number;
		//
		if(num < 1 or: {num > 3} , {

			this.inform("Use only numbers between '1 and 3' as first argument, to choose instance",0.015);

			^"";

			}, {

				var inst = num-1;
				var variables;

				instanceinform = this.inform("Synth instance #" ++ num + "with node:" + instances[inst].nodeID + " affected",0.01);
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
		this.inform("All instances changed speed rate to " ++ vel,0.01);

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
				this.inform("Track reversed: " ++ res ,0.001);
			},
			1,{
				res = rate * 1;
				instances.collect({|item|
					item.set(\rate,res);
				});
				reverse = 0;//reset
				this.inform("Track with normal rate: " ++ res ,0.001);
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
			this.inform("All instances chaged output to channel: " ++ chan,0.01);

			}, {

				if(instance < 1 or: {instance > 3} , {

					this.inform("Use only numbers between 1 to 3, or \all symbol, as first argument, to choose instance Output",0.015);
					},{
						switch(instance,
							1,{instances[0].set(\out,chan);},
							2,{instances[1].set(\out,chan);},
							3,{instances[2].set(\out,chan);}
						);
						this.inform("Instance #" ++ instance ++ " changed output to " ++ chan,0.01);
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

					this.inform("Use only numbers between 1 to 3, or \all symbol, as first argument, to choose instance Output",0.015);
					},{

						switch(instance,
							1,{instances[0].set(\amp,amp);},
							2,{instances[1].set(\amp,amp);},
							3,{instances[2].set(\amp,amp);}
						);

						this.inform("Instance #" ++ instance ++ " changed amplitude to " ++ amp,0.015);
					}
				);

		});//endif

		^"";

	}

	*loop {|state = false|

		var arr = instances.size;
		var toggle;

		if(state == false, {

			toggle = 0;

			this.inform("Loop is Off \n", 0.015);

			}, {

				if(state == true ,{

					toggle = 1;

					this.inform("Loop is On ", 0.015);

					}, {

						this.inform("Use only ' true ' or ' false ' to toggle on / off \n", 0.015);
				});

		});


		switch(arr,
			1,{
				instances[0].set(\loop,toggle);
			},
			2,{
				instances.collect({|item|
					item.set(\loop,toggle);
				});
			},
			3,{
				instances.collect({|item|
					var a;
					a = item.set(\loop,toggle);
				});
			}

		);

		^"";

	}

	*play {|paused = true, args|

		if(paused != true, {

			// this.inform("Track: " + this.instanceName + "paused",0.01);
			this.inform("Track paused",0.01);

			}, {

				// this.inform("Track: " + this.instanceName + "running",0.01);
				this.inform("Track running",0.01);

		});

		switch(instances.size,

			1,{instances[0].run(paused)},

			2,{[instances[0].run(paused),instances[1].run(paused)]},

			3,{[instances[0].run(paused),instances[1].run(paused),instances[2].run(paused)]}

		);

		^"";
	}

	*stopAll {

		thisProcess.stop;

		this.inform("All Instances stopped ", 0.01);

		^"";
	}



	//debug inform class and instance methods
	inform {|print = "CaosSampler written by @joseCao5 \n", tempoTexto = 0.025, breakLine = true|

		var txt = print.asArray;
		var texto = txt.size;
		var letrero = Array.newClear(texto);

		fork {
			texto.do({|i|

				letrero.put(i, txt[i]);
				letrero[i].asString.post;
				tempoTexto.wait;
				0.yield;//regresa un valor vacio, para evitar que se imprima en el post

			});

			if(breakLine == true, {

				"\n".post;

			});
		}
	}

	*inform {|print = "CaosSampler written by @joseCao5 \n", tempoTexto = 0.025, breakLine = true|

		var txt = print.asArray;
		var texto = txt.size;
		var letrero = Array.newClear(texto);

		fork {
			texto.do({|i|

				letrero.put(i, txt[i]);
				letrero[i].asString.post;
				tempoTexto.wait;
				0.yield;//regresa un valor vacio, para evitar que se imprima en el post

			});

			if(breakLine == true, {

				"\n".post;

			});
		}
	}

}
