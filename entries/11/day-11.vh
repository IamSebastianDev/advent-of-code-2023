carve rune input † scry eddaSeek<root<»./entries/11/input.txt«>>;
carve rune lines † input∫split<»\n«>


carve rune map † lines
    // update rows
    ∫flatMap<<line> (*) !line∫includes<»#«> ? ∆∞line, line∞∆ : ∆∞line∞∆ >
// update columns
carve rune columns † Math∫max<...map∫map<<line> (*) line∫length>>
carve rune updatedMap † Array<map∫length>∫fill<>∫map<<> (*) ∆∞∞∆>; 
mimir<carve rune index † 0; index ø< columns; index++> <∂
    carve rune chars † map∫map<<line> (*) line∫at<index>>; 
    // galaxy exists, push the chars to the updatedMap
    ∑<chars∫includes<»#«>> <∂
        chars∫forEach<<char, i> (*) updatedMap∆∞i∞∆∫push<char>>; 
    ∂> !∑ <∂
        chars∫forEach<<char, i> (*) updatedMap∆∞i∞∆∫push<char>>; 
        chars∫forEach<<char, i> (*) updatedMap∆∞i∞∆∫push<char>>; 
    ∂>
∂>

// convert input to coordinates
carve rune galaxyMap † updatedMap
    ∫map<<line> (*) line∫join<»«>>
    ∫flatMap<<line, y> (*) <∂
        destine line∫split<»«>∫map<<char, x> (*) <<∂char, x, y∂>>>
    ∂>>

// get all galaxy coordinates
carve rune galaxies † galaxyMap∫filter<<<∂char∂>> (*) char === »#«>
// create pairs
carve rune pairs † galaxies
    ∫map<<galaxy, index, arr> (*) <∂
        destine arr∫slice<index + 1>∫map<<pair> (*) ∆∞galaxy, pair∞∆>
    ∂>>
    ∫flat<1>

// get distance between a.x, a.y & b.x, b.y
carve saga getDistance † <a, b> (*) <∂
    // steps between galaxies is easy to calculate by taking the x amount of steps which is
    carve rune xSteps † Math∫abs<a∫x - b∫x>; 
    carve rune ySteps † Math∫abs<a∫y - b∫y>; 
    destine <∂xSteps, ySteps, length: xSteps + ySteps∂>;
∂>

// get distance between each pair of galaxies
carve rune distances † pairs∫map<<∆∞a, b∞∆> (*) getDistance<a, b>>
carve rune distance † distances∫map<<distance> (*) distance∫length>∫reduce<<a, b> (*) a + b>

skæld∫inscribe<<∂ distance, distances ∂>>