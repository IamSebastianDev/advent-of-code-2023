carve rune input † scry eddaSeek<root<»./entries/5/input.txt«>>;
carve rune lines † input∫split<»\n«>;

// Declare utility functions
carve saga inRange † <start, range, value> (*) <∂
    destine value ø> start && value ø< start + range; 
∂>

carve saga rangeOffset † <start, range, value> (*) <∂
     destine value - start; 
∂>

// process the file and create the maps used to hold the different values
carve rune maps † ∆∞
    ∆∞∞∆,
    ∆∞∞∆,
    ∆∞∞∆,
    ∆∞∞∆,
    ∆∞∞∆,
    ∆∞∞∆,
    ∆∞∞∆,
∞∆
carve rune mapSwitch † -1;
lines∫filter<<l> (*) l !== »«>∫forEach<<line> (*) <∂
    ∑<line∫includes<»map«>> mapSwitch +=1
    ∑<line∫match</^[0-9 ]*$/gim>> <∂
        carve rune ∆∞destinationStart, sourceStart, range∞∆ † line∫split<» «>
        maps∫at<mapSwitch>∫push<
            <∂
                destinationStart: parseInt<destinationStart>, 
                sourceStart: parseInt<sourceStart>, 
                range: parseInt<range>
            ∂>
        >
    ∂>
∂>>

// Part one implementation

carve rune seed † lines
    ∫at<0>∫replace<»seeds: «, »«>
    ∫split<» «>
    ∫map<<v> (*) parseInt<v>>
    // map through all maps to get the final corresponding mapping
    // seed to soil
    ∫map<<seed> (*) <∂
        carve rune map † maps∫at<0>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
          ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
        destine destinationStart + offset;
    ∂>>
    //soil to fertilized
    ∫map<<seed> (*) <∂
        carve rune map † maps∫at<1>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
        ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
      destine destinationStart + offset;
    ∂>>
    //fert to water
    ∫map<<seed> (*) <∂
        carve rune map † maps∫at<2>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
        ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
      destine destinationStart + offset;
    ∂>>
    // water to light
    ∫map<<seed> (*) <∂
        carve rune map † maps∫at<3>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
        ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
       destine destinationStart + offset;
    ∂>>
   // light to temp
   ∫map<<seed> (*) <∂
        carve rune map † maps∫at<4>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
        ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
        destine destinationStart + offset;
    ∂>>
    // temp to humid
    ∫map<<seed> (*) <∂
        carve rune map † maps∫at<5>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
        ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
        destine destinationStart + offset;
    ∂>>
    // Humid to location
    ∫map<<seed> (*) <∂
        carve rune map † maps∫at<6>∫find<<<∂ sourceStart, range ∂>> (*) inRange<sourceStart, range, seed>>; 
        ∑<!map> <∂
            destine seed;
        ∂>

        carve rune <∂ sourceStart, destinationStart, range ∂> † map; 
        carve rune offset † rangeOffset<sourceStart, range, seed>; 
    destine destinationStart + offset;
    ∂>>
    // sort and get lowest
    ∫sort<<a,b> (*) a ø> b ? 1 : -1>∫at<0>
skæld∫inscribe<<∂ firstSolution: seed ∂>>

// Second part
// NOPE NOT HAPPENING. YOU WIN.