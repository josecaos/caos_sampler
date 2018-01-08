// Instancia
x = CaosSampler.new("Test",copies:1);
z = CaosSampler;
y = CaosSampler.new("Test2x",copies:3);
x.play;
x.out(1,20);
x.out_(20);
x.server.scope(2,0);
// debug
x.debug;
z.debug;
CaosSampler.debug;
z.playAll;
// Clase
CaosSampler.init
CaosSampler.scope;
CaosSampler.tracks;
CaosSampler.ids;
CaosSampler.all;
CaosSampler.playAll;



Platform.userExtensionDir