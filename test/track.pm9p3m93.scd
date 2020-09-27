// Clase
c = CaosSampler
b = CaosBox
b.enviroment;
b.play;
// inistancia sampler
a = c.new;
a.load;//carga defaut
a.play
a.loop(true);
a.toggleReverse((rrand(0.25,2)));
a.toggleReverse(1.5);
//  trip
(
Tdef(\x,{
	var arr= Prand([0.75,1,1.25,1.5]/0.725, inf).asStream;
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
