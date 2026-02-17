// Test .chain method
//
z = CaosSampler;
// declare all instances
(
q = z.new;
w = z.new;
e = z.new;
r = z.new;
t = z.new;
y = z.new;
)
// declare all buffers
(
q.load("The","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-the.wav",3);
w.load("Pill","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-pill.wav",3);
e.load("For","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-for.wav",3);
r.load("Your","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-your.wav",3);
t.load("Mental","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-mental.wav",3);
y.load("Ill","set2/EP-the_pill_for_your_ill/renders/TPFYI/josecaos-ill.wav",3);
)
// chain all
(
fork { // forked just to read the debigging information
q.chain(w);
0.5.wait;
w.chain(e);
0.5.wait;
e.chain(r);
0.5.wait;
r.chain(t);
0.5.wait;
t.chain(y);
}
// y.chain(q); if looping project
)
// Play first track
q.play;
