CaosTest : CaosSampler {

		*new {

		coreurl = this.filenameSymbol.asString.dirname;


		^super.new.init;

	}

	init {

		"hola clase".postcln;

	}

}