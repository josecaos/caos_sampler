// Test Recording playing loop
c=CaosBox;
c.enviroment;
c.play;
x = CaosSampler.new;
x.load//loads audio
y = CaosSampler.new;
y.load("xx")//loads audio
y.play();
y.loop(true);
y.loop(false);
y.toggleReverse()
// now load a buffer and record on it
z = CaosSampler.new;
z.loadLooper("looper",4);//allocs buffer for recording
z.recordLoop(\in);//record the alloc instance
z.recordLoop(\i0);//bad input => won't record the alloc instance
z.play();
//sampler info
CaosSampler.coreurl
CaosSampler.audiourl
CaosSampler.info
CaosSampler.ids
CaosSampler.tracks
CaosSampler.all
//
z = "heeey"
z ++ "-rec"