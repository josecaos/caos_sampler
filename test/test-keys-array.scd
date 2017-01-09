z = #[\out,0,\loop,1,\rate,2,\trigger,0,\startPos,0,\amp,0.95];

z[2].asSymbol;
(
x = {| arrr|
var keys, values, setargs;
				keys = args[0,2,4,6,8,10];
				values = args[1,3,5,7,9,11];//.join(",");
				setargs = Array.newClear(arrr.size);

				forBy(0, 4, 2, {|i|

					setargs.put(i, values[i]);


				});
				forBy(1, 4, 2, {|i|

					setargs.put(i, keys[i]);


				});

}
);
x.value(z);
//
(
x = {|arrray|

				forBy(0, 20, 2, {|i=2|

		("hola mundo " + i).postcln;

				});

}
);
x.value(1);
//
forBy (0, 8, 2, { arg i; i.postln });