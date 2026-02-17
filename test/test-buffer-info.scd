// Test to obtain a Buffer information via Caos Sampler
//
z = CaosSampler;
//
x = z.new;
x.load("test","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-the.wav");
x.play;
y = z.new;
y.load("test2","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-pill.wav");
z.play;

// Obtain Information
x.buffer;
x.bufferInfo;
x.bufferInfo.duration;
x.bufferInfo.numFrames;
x.bufferInfo.sampleRate;
x.bufferInfo.numChannels;
