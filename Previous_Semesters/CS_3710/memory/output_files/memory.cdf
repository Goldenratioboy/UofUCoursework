/* Quartus Prime Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Cfg)
		Device PartName(5CSEMA5F31) Path("C:/Users/steen/Desktop/ECE-3710/memory/output_files/") File("memory.sof") MfrSpec(OpMask(1));
	P ActionCode(Ign)
		Device PartName(5CSEMA6F31) MfrSpec(OpMask(0));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
