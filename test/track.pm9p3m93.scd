// Clase
c = CaosSampler
b = CaosBox
b.enviroment;
b.play;
b.guiAlpha(0.5);
// inistancia sampler
a = c.new;
a.load(copies:3);//carga defaut
a.play
a.loop(true);
a.toggleReverse((rrand(0.25,2)));
a.out(2,64);
a.amp(2,0.75);
//  trip
(
Tdef(\x,{
	var arr= Prand([0.75,1,1.25,1.5]/1.25, inf).asStream;
	loop {
		a.toggleReverse(arr.next);
		2.wait;
	}
}).quant_(4);
);
Tdef(\x).play
Tdef(\x).stop
//
a.out(1,54);
a.out(1,64);
a.amp(2,0.5);
//
b.autoFx(\delay,true,\normal,Array.series(20,0.02,0.02), 0.05);
b.bpm(115);
b.freqAnalyzer(true);
// c.scope;
