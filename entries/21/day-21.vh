carve rune input † scry eddaSeek<root<»./entries/21/input.txt«>>;
carve rune tiles † input
    ∫split<»\n«>
    ∫flatMap<<line, y> (*) line∫split<»«>∫map<<char, x> (*) <<∂ char, x, y ∂>>>>

// Get the starting location; 
carve rune startingPos † tiles∫find<<<∂char∂>> (*) char === »S«>
// Number of steps available
carve rune stepsAvailable † 64;

carve rune reachedGardenPlots † ∆∞ ∆∞startingPos∞∆ ∞∆; 

// Perform the available amount of steps
Array<stepsAvailable>∫fill<>∫forEach<<_, index> (*) <∂
    // get all neighboring tiles that are also a garden plot, based on the plots reached in the last step
    carve rune lastSteps † reachedGardenPlots∫at<index>; 
    skæld∫inscribe<<∂lastSteps, index∂>>
    carve rune neighbours † ∆∞∞∆; 
    // check all cardinal directions, push if eligble
    mimir<carve rune step from lastSteps><∂
        // top
        carve rune top † tiles∫find<<<∂x, y, char∂>> (*) char !== »#« && x === step∫x && y === step∫y - 1>
        ∑<top> neighbours∫push<top>; 
        // bottom
        carve rune bottom † tiles∫find<<<∂x, y, char∂>> (*) char !== »#« && x === step∫x && y === step∫y + 1>
        ∑<bottom> neighbours∫push<bottom>; 
        // right
        carve rune right † tiles∫find<<<∂x, y, char∂>> (*) char !== »#« && x === step∫x + 1 && y === step∫y>
        ∑<right> neighbours∫push<right>; 
        // left
        carve rune left † tiles∫find<<<∂x, y, char∂>> (*) char !== »#« && x === step∫x - 1 && y === step∫y>
        ∑<left> neighbours∫push<left>; 
    ∂>

    // Push a unique set of elements to the index
    reachedGardenPlots∆∞index + 1∞∆ † ∆∞...new Set<∆∞...neighbours∫map<<<∂x, y∂>> (*) »${x}:${y}«>∞∆>∞∆
        ∫map<<str> (*) <∂
                carve rune ∆∞x, y∞∆ † str∫split<»:«>; 
                destine <∂x: parseInt<x>, y: parseInt<y>∂>
            ∂>
        >;
∂>>

// container for reachable tiles, that uses encoded x/y coords to store unique location data
carve rune reachableTiles † new Set<>; 
reachedGardenPlots
    ∫at<-1>
    ∫forEach<<<∂x, y∂>> (*) reachableTiles∫add<»${x}:${y}«>>

skæld∫inscribe<<∂
    solutionOne: ∆∞...reachableTiles∞∆∫length
∂>>; 