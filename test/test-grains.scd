~c = CaosSampler;//declara la superclase
//soporte para la caosbox
~x = CaosBox;
~x.enviroment;
~x.play;
~x.bpm(120);
~x.freqAnalyzer(true);
//
~t = 1;
a = CaosSampler.new;
b = CaosSampler.new;
c = CaosSampler.new;
d = CaosSampler.new;
e = CaosSampler.new;
f = CaosSampler.new;
g = CaosSampler.new;
h = CaosSampler.new;


//
a.load("teest","a11wlk01.wav",2);
b.load("1500","IMPT-josecaos-master/josecaos-1500(edit)-master-48khz-24bits-josecaos.xyz.wav",2);
c.load("NR15","master.final/josecaos-x4x1e1e-NR15-mezcla.aiff",2);
c.load("NR150-chida","master.final/josecaos-x4x1e1e-NR15-mezcla.wav",2);
d.load("p43wnda","master.final/josecaos-11-xibalba-p4nda-master-48khz-24bits.wav",2);
d.load("di3","master.final/josecaos-02-xibalba-wdyjdi3-master-48khz-24bits.wav",2);
e.load("bilocacion","master.final/josecaos-01-xibalba-bilocacion-master-48khz-24bits.wav",2);
g.load("gggg","master.final/josecaos-07-xibalba-eternas_lluvias-master-48khz-24bits.wav",2);
h.load("finale","master.final/josecaos-07-xibalba-eternas_lluvias-master-48khz-24bits.wav",2);

a.play(true);
a.out(1,0);
h.amp(1,0.6);
h.amp(1,0.3);
b.toggleReverse();
a.grain;
a.loop(true);
d.out(1,60);
d.amp(1,1);
d.play(false)
// class methods
~c.ids;
~c.all;
~c.scope
b.buffer;
a.buffer';
// c.amp('all',0.9);
// seqs
(
Tdef(\test,{
	var t = Pwrand([1,0.5,0.25],[0.2,0.3,0.5],inf).asStream;
	// var n = Pwrand([0.25,0.5,1,1.25,1.5,1.75,2]*2,[0.2,0.2,0.3,0.1,0.2,0.1],inf).asStream;
	var n = Pxrand([0.25,0.5,1.25,1.5,1.75,2],inf).asStream;
	var x=[0.25,0.5,0.75,1]*2;
	loop{
		// d.toggleReverse(x.choose);
		f.toggleReverse(~t = n.next);
		f.speed(~t = n.next);
		t.next.wait
		// 0.5.wait
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
