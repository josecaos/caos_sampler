~c = CaosSampler;//declara la superclase
//soporte para la caosbox
~x = CaosBox;
~x.enviroment;
~x.play;
~x.bpm(190);
~x.freqAnalyzer(true);
//
~t = 0.1;
a = CaosSampler.new;
b = CaosSampler.new;
c = CaosSampler.new;
d = CaosSampler.new;
//
a.load("NR15","master.final/josecaos-x4x1e1e-NR15-mezcla.aiff",2);
b.load("p43wnda","master.final/josecaos-11-xibalba-p4nda-master-48khz-24bits.wav",2);
c.load("di3","master.final/josecaos-02-xibalba-wdyjdi3-master-48khz-24bits.wav",2);
d.load("15080","IMPT-josecaos-master/josecaos-1500(edit)-master-48khz-24bits-josecaos.xyz.wav",2);

a.play(false);
a.out(1,0);
a.amp(2,0.5);
a.toggleReverse;
a.loop(true);
b.play(true);
b.out(1,0);
b.out(,64);
b.amp(1,0.85);
b.loop(false);
b.toggleReverse(~t=[0.25,0.5,0.75,1].choose);
b.toggleReverse(~t=1.05);
c.play;
c.out(1,0);
c.amp(1,1);
c.speed(~t=1.02);
c.loop(false);
c.toggleReverse(~t=1);
d.play(true);
d.out(1,0)
d.loop(false);
d.toggleReverse(~t=0.25);
d.toggleReverse(~t=1.12);

// class methods
~c.scope(2,0);
~c.toggleReverse;
~c.ids;
~c.all;
~c.loopAll;

c.amp('all',0.9);
// seqs
(
Tdef(\test,{
	var t = Pwrand([1,0.5,0.25],[0.2,0.3,0.5],inf).asStream;
	var n = Pwrand([0.25,0.5,1,1.25,1.5,1.75,2]*2,[0.2,0.2,0.3,0.1,0.2,0.1],inf).asStream;
	// var n = Pxrand([0.25,0.5,1.25,1.5,1.75,2],inf).asStream;
	var x=[0.25,0.5,0.75,1]*2;
	loop{
		// d.toggleReverse(x.choose);
		d.toggleReverse(~t = n.next*2);
		d.speed(~t = n.next);
		// t.next.wait
	0.25.wait
	}
}).quant_(1);
)
Tdef('test').play;
Tdef('test').stop;

//
// "IMPT-josecaos-master/josecaos-1500(edit)-master-48khz-24bits-josecaos.xyz.wav"
// "master.final/josecaos-15-xibalba-boox_(bonus_track)-master-48khz-24bits.wav"
// "master.final/josecaos-03-xibalba-engranes-master-48khz-24bits.wav"
// "master.final/josecaos-13-xibalba-selva_de_noche-master-48khz-24bits.wav"
//
// "josecaos-bug5-mixed_v2-peaks-3db-48khz-16bits.wav"
// "master.final/josecaos-12-xibalba-toh-master-48khz-24bits.wav"
// "master.final/josecaos-02-xibalba-wdyjdi3-master-48khz-24bits.wav"
// "master.final/josecaos-11-xibalba-p4nda-master-48khz-24bits.wav"
// "master.final/josecaos-07-xibalba-eternas_lluvias-master-48khz-24bits.wav"
// "master.final/josecaos-01-xibalba-bilocacion-master-48khz-24bits.wav"
//
//
