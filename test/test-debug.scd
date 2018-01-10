// Instancia
z = CaosSampler;
x = CaosSampler.new;
y = CaosSampler.new;
x.load("Test",copies:1);
y.load("Test2x",copies:3);
//instancia
x.play(false);
x.out(1,20)
y.play;
y.out(1,20);
y.out(2,22);
y.out(3,24);
y.amp(1,1);
y.amp(2,0.5);
y.amp(3,0.25);
// Clase
z.scope(6,20);
z.tracks;
z.ids;
z.all;
z.playAll;

//
Platform.userExtensionDir