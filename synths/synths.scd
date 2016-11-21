//Audio to midi input
////
(
SynthDef(\sonuus,{|gate = 0, nota = 60|
	var son,env;
	son=LFTri.ar(nota.midicps,0,0.75);
	env=EnvGen.ar(Env.perc(0.01,0.5),gate,doneAction:2);
	Out.ar([0,1],son*env)
}).add;
);