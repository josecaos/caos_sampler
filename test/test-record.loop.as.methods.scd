// Test Recording playing loop
/*c=CaosBox;
c.enviroment;
c.play;*/
x = CaosSampler.new;
x.load//loads audio
x.loadLooper;
x.recordLoop("c");
x.play()
//
x.loadTrack("gggg")
//
z = "heeey"
z ++ "-rec"