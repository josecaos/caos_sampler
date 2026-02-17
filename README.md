# CaosSampler

### This SuperCollider extension, reproduce audio files in a tweaky way, supports connection thru CaosBox or to use it stand-alone.
### Basic use:
```
~sampler = CaosSampler; // Sampler Class
~t = 1; //constant for rate
~track1 = CaosSampler.new; // Create track Instance
~track1.load(name:"Track1",fileName:"josecaos-set/josecaos-e4n4e99n-master.wav",copies:3); //load file + number of copies
~track1.play(); // Play true, pause false
~track1.out(2,54); // Out copy number 2, thru channel 54
~track1.amp(2,0.5); // Amplify copy number 2, up to half amplitud
~track1.loop(true); // Apply loop, default is off
~track1.toggleReverse(~t); // Reverse track + copies
~sampler.scope; // view sampler oscilloscope
```
### Get all methods
```
CaosSampler.browse;
```