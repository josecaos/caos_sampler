~c = CaosSampler;//declara la superclase
//soporte para la caosbox
~x = CaosBox;
~x.enviroment;
~x.play;
//
~t = 1;
a = CaosSampler.new;
b = CaosSampler.new;
c = CaosSampler.new;


a.load("NRfw15","master.final/josecaos-11-xibalba-p4nda-master-48khz-24bits.wav",2);
b.load("impt","IMPT-josecaos-master/josecaos-1500(edit)-master-48khz-24bits-josecaos.xyz.wav",2);
c.load("impt","master.final/josecaos-02-xibalba-wdyjdi3-master-48khz-24bits.wav",2);

a.play;
a.out(2,64);
a.amp(2,0.65);
a.toggleReverse;
b.play;
b.out(1,0);
b.amp('all',0.3);
b.toggleReverse;
c.play;
c.out(2,64);
c.amp(2,0.95);
c.speed(~t=1.02);
c.loop(false);
c.toggleReverse(~t);
~c.scope(2,0);
~c.toggleReverse;
~c.ids;
~c.all;

b.out(2,64);
b.amp(2,1.001);
b.out(2,54);
b.amp(2,0.45);
b.out(3,56);

~c.toggleReverse
c.loop(false);
// seqs
(
Tdef(\test,{
	var t = Pwrand([1,0.5,0.25]+0.5,[0.2,0.3,0.5],inf).asStream;
	var n = Pwrand([0.25,0.5,1,1.25,1.5,1.75,2]*2,[0.2,0.2,0.3,0.1,0.2,0.1],inf).asStream;
	loop{
		c.toggleReverse;
		c.speed(~t = n.next);
	t.next.wait
	}
});
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
