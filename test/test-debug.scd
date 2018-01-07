// Instancia
x = CaosSampler.new("Test",copies:3);
y = CaosSampler.new("Test2x",copies:3);
x.instances;
x.out(1,20);
x.out_(20);
x.server.scope(2,0);
// Clase
CaosSampler.scope(true);
CaosSampler.tracks;
CaosSampler.ids;
CaosSampler.all;
CaosSampler.instances;



Platform.userExtensionDir