CaosSampler {

	classvar <server, <coreurl, <audiourl, <info;
	classvar <>tracks, <ids, <all;
	classvar reverse = 0;
	//
	var <>trackname, <>instances, <>buffer;
	var <run1, <run2, <run3;
	var defaultout = 0;
	var <buffer;

	*new {

		coreurl = this.filenameSymbol.asString.dirname;

		^super.new;
	}

	//
	load {|name = "Default",fileName = "test-caos_sampler-115_bpm.wav",copies = 1, startFrame = 0|

		server = Server.local;
		audiourl = coreurl +/+ "tracks/";

		// CaosBox Support
		if(~cbox_url.notNil,{
			defaultout = 50;
		});
		// Evita sobre escritura del array  'nombres de tracks'
		if(tracks.isNil, {
			tracks = Array.new(20);
			ids = Array.new(20);
			this.trackname_(name);
		},{
			tracks = tracks;
			ids = ids;
			this.trackname_(name);
		});

		if( tracks.find([name]).isNil, {//con mismo nombre rechaza la creacion de la instancia

			if(server.serverRunning != true ,{

				server.waitForBoot{

					1.do({
						this.inform("Server boot ...  ",0.075,true);
						1.5.yield;
						this.inform("CaosSampler instance created",0.015,true);
						0.5.yield;
						this.loadTrack(trackname,fileName,copies,startFrame);
						2.5.yield;
						this.register(name,copies);
						2.yield;
						this.loop(false);
						1.yield;
						this.out(defaultout);
						1.5.yield;
						if(defaultout == 50, {this.inform("CaosBox support On!")},{this.inform("CaosBox support Off!")});
					});
				};
			}, {

				fork {
					1.do({
						this.inform(" .... CaosSampler instance created ",0.015,true);
						1.yield;
						this.loadTrack(trackname,fileName,copies,startFrame);
						2.5.yield;
						this.register(name,copies);
						2.yield;
						this.loop(false);
						1.yield;
						this.out(defaultout);
						1.5.yield;
						if(defaultout == 50, {this.inform("CaosBox support On!")},{this.inform("CaosBox support Off!")});
					});
				}
			});

		}, {

			this.inform("Track name already exists and was not registered, try another one!",0.1);

		});
		//
		^"";
	}

	loadTrack {|name,fileName,copies,startFrame|

		var informPositive = this.inform("The file " ++ fileName ++ " has been loaded" ,0.015);
		var buf;

		//
		buf = Buffer.read(server,audiourl ++ fileName, startFrame, -1, informPositive);

		this.buffer_(buf.bufnum);

		^this.buildSynth(trackname,buffer);

	}

	buildSynth {|synthName, bufnumb|

		// Sinte instancia
		SynthDef(synthName.asString.asSymbol,{|rate = 1, pan = 0, amp = 1, trigger = 0,out=0, startPos = 0, loop = 1, reset = 0|

			var sample;

			sample = PlayBuf.ar(2,bufnumb,rate,trigger,startPos,loop,reset);
			Out.ar(out,Pan2.ar(sample,pan,amp));

		}).add;

		^"";

	}

	// registra el numero de copias simultaneas por track
	register {|name, copies|

		var infoinstances, allinstances;

		instances = [];

		if( copies < 1 or: {copies > 3}, {

			fork{2.5.wait;this.inform("Only 1 to 3 simultaneous copies allowed",0.01)  };

		}, {

			switch(copies,
				1,{
					run1 = Synth.newPaused(name.asString.asSymbol,[\amp,1]);
					instances = instances.add(run1);
					allinstances = instances[0];
					infoinstances = instances[0].nodeID;
				},

				2,{
					run1 = Synth.newPaused(name.asString.asSymbol,[\amp,1]);
					instances = instances.add(run1);
					run2 = Synth.newPaused(name.asString.asSymbol,[\amp,0]);
					instances = instances.add(run2);
					allinstances = [instances[0], instances[1]];
					infoinstances = [instances[0].nodeID, instances[1].nodeID];
				},

				3,{
					run1 = Synth.newPaused(name.asString.asSymbol,[\amp,1]);
					instances = instances.add(run1);
					run2 = Synth.newPaused(name.asString.asSymbol,[\amp,0]);
					instances = instances.add(run2);
					run3 = Synth.newPaused(name.asString.asSymbol,[\amp,0]);
					instances = instances.add(run3);
					allinstances = [instances[0],instances[1],instances[2]];
					infoinstances = [instances[0].nodeID,instances[1].nodeID,instances[2].nodeID];
				}

			);

			this.inform("You chose '" + copies + "' track(s) to run simultaneously",0.01);

			////asocia nombre de sinte con instancias
			info = [["Track name", name].join(": "),
				["Instance Nodes", infoinstances].join(": ")].join(" => ");

			ids = ids.add(info);//agrega informacion a un array global para posterior identificacion
			all = all.add(allinstances);

			tracks = tracks.add(name);//agrega nombre a array

			fork{1.wait;this.inform("Track Name: '" + name + "' registered ",0.01)};

		});

		^"";
	}

	/*	grain {
	var trate, dur, rate;

	trate = 16;
	dur = 4 / trate;
	rate = 4;

	TGrains.ar(2, Impulse.ar(trate), buffer, rate, BufDur.kr(buffer), dur, 1, 0.75, 2);

	^"Granulando buffer número" + buffer ;
	}*/

	out {|instance, chan|

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

			this.inform("All subtracks chaged output to channel: " ++ chan,0.01);

		}, {

			if(instance < 1 or: {instance > 3} , {

				this.inform("Use only numbers between 1 to 3, or \all symbol, as first argument, to choose subtrack Output",0.015);
			},{
				switch(instance,
					1,{instances[0].set(\out,chan);},
					2,{instances[1].set(\out,chan);},
					3,{instances[2].set(\out,chan);}
				);
				this.inform("Subtrack #" ++ instance ++ " changed output to channel: " ++ chan,0.01);
			}
			);
		});

		^"";

	}

	amp {|instance = 1, amp = 1|

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

				this.inform("Use only numbers between 1 to 3, or \all symbol, as first argument, to choose subtrack Output",0.015);

			},{

				if(amp > 0 or: { amp <1}, {

					switch(instance,
						1,{instances[0].set(\amp,amp);},
						2,{instances[1].set(\amp,amp);},
						3,{instances[2].set(\amp,amp);}
					);

					this.inform("Subtrack #" ++ instance ++ " changed amplitude to: " ++ amp,0.015);
				}, {

					this.inform("For safety, only linear values between '0' and '1' admited for amplitud",0.015);

				});

			});
		});

		^"";

	}

	loop {|state = false|

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

				this.inform("Use only ' true ' or ' false ' to toggle on / off", 0.015);
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

	*loopAll {|state = false|
		/*
		var toggle;

		if(state == false, {

		toggle = 0;

		this.inform("All track's Loop is Off \n", 0.015);

		}, {

		if(state == true , {

		toggle = 1;

		this.inform("All track's Loop is On ", 0.015);

		}, {

		this.inform("Use only ' true ' or ' false ' to toggle on / off", 0.015);
		});

		});

		all.deepCollect(2,{|item|
		item.set(\loop,toggle);
		});*/

		^"";
	}

	play {|paused = true|

		switch(instances.size,

			1,{instances[0].run(paused)},

			2,{[instances[0].run(paused),instances[1].run(paused)]},

			3,{[instances[0].run(paused),instances[1].run(paused),instances[2].run(paused)]}

		);

		if(paused != true, {

			^this.inform("Track paused",0.01);

		}, {

			^this.inform("Track running",0.01);

		});

	}

	*playAll {|paused = true, args|

		all.deepCollect(2,{|item|
			item.run(paused);
		});

		if(paused != true, {
			^this.inform("All tracks paused",0.01);

		}, {
			^this.inform("All tracks running",0.01);

		});
	}

	*stopAll {

		thisProcess.stop;

		this.inform("Everything stopped ", 0.01);

		^"";
	}

	speed {|vel = 1|

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
		this.inform("All subtracks changed speed rate to " ++ vel,0.01);

		^"";
	}

	*speedAll {|vel = 1|

		all.deepCollect(2,{|item|
			item.set(\rate,vel);
		});

		^this.inform("All tracks changed speed rate to " ++ vel,0.01);

	}

	*toggleReverse {|rate = 1|

		var res;

		switch(reverse,
			0,{
				res = rate * -1;
				all.deepCollect(2,{|item|
					item.set(\rate,res);
				});
				reverse = reverse + 1;
				this.inform("Tracks reversed: " ++ res ,0.001);
			},
			1,{
				res = rate * 1;
				all.deepCollect(2,{|item|
					item.set(\rate,res);
				});
				reverse = 0;//reset
				this.inform("Tracks with normal rate: " ++ res ,0.001);
			}
		);

		^"";
	}	//

	*scope {|numChannels = 2, fromBus = 0|

		server.scope(numChannels,fromBus);

	}
	//
	// looper
	loadLooper {|name,loopDur=1|

		var completionMessage = this.inform("A " ++ loopDur ++ " second buffer has been created" ,0.015);
		var buf;

		buf = Buffer.alloc(server,44100 *loopDur, 1,completionMessage	);

		this.buffer_(buf.bufnum);

		^this.buildSynth(trackname,buffer);

		// ^this.inform("A " ++ loopDur ++ " second buffer has been created" ,0.015);
	}

	recordLoop {


		// SynthDef(\grabando, {|out = 0, bufnum = 0|
		// 	var in;
		// 	in = SoundIn.ar(0);
		// 	RecordBuf.ar(in, bufnum, doneAction: Done.freeSelf, loop: 0);
		// }).add;
		//
		// Synth(\grabando,[\bufnum,b]);

	}
	//Response
	inform {|print = "CaosSampler written by @Ill_Slide ", tempoText = 0.025, breakLine = true|

		var txt = print.asArray;
		var texto = txt.size;
		var letrero = Array.newClear(texto);

		fork {
			texto.do({|i|
				letrero.put(i, txt[i]);
				letrero[i].asString.post;
				tempoText.wait;
				0.yield;//regresa un valor vacio, para evitar que se imprima en el post
			});

			if(breakLine == true, {

				"\n".post;

			});
		}
	}

	*inform {|print = "CaosSampler written by @Ill_Slide ", tempoText = 0.25, breakLine = true|

		this.inform(print,tempoText,breakLine);

	}

}
