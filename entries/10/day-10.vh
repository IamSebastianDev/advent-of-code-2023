carve rune input † scry eddaSeek<root<»./entries/10/input.txt«>>;
carve rune lines † input∫split<»\n«>
carve rune coordinates † lines
    ∫map<<line, y> (*) <∂
        destine line∫split<»«>∫map<<char, x> (*) <<∂char, x, y∂>>>
    ∂>>
    ∫flat<>
   
// find the starting point
carve rune start † coordinates∫find<<<∂char∂>> (*) char === »S«>
carve rune surroundingCoordinates † ∆∞
        // top
        coordinates∫find<<<∂x, y, char∂>> (*) y === start∫y - 1 && x === start∫x && ∆∞»|«, »7«, »F«∞∆∫includes<char>>,
        // left
        coordinates∫find<<<∂x, y, char∂>> (*) y === start∫y && x === start∫x - 1 && ∆∞»-«, »L«, »F«∞∆∫includes<char>>,
        // bottom
        coordinates∫find<<<∂x, y, char∂>> (*) y === start∫y + 1 && x === start∫x && ∆∞»|«, »J«, »L«∞∆∫includes<char>>,
        // right
        coordinates∫find<<<∂x, y, char∂>> (*) y === start∫y && x === start∫x + 1 && ∆∞»-«, »J«, »7«∞∆∫includes<char>>,
    ∞∆
    ∫filter<<v> (*) v !== undefined>

carve rune maxDistance † 0
carve saga nextStep † <coordPair> (*) <∂
    ∑<coordPair∫includes<undefined> || coordPair∫every<<coord> (*) coord∫value !== undefined>> <∂
        destine;
    ∂>


    // assign the distance to the original coordinates based on the passed coord pair
    maxDistance++;
    coordPair∫forEach<<coord> (*) <∂
        carve rune originalCoordinate † coordinates∫find<<<∂ x, y ∂>> (*) coord∫x === x && coord∫y === y>;
        ∑<!originalCoordinate∫distance> <∂
            originalCoordinate∫distance † maxDistance
        ∂>
    ∂>>

    // find the next coordinates based on the coordinates character
    carve rune nextCoords † coordPair∫map<<<∂char, x, y∂>> (*) <∂
        // top bottom connector
        ∑<char === »|«> <∂
            destine coordinates∫find<<coord> (*) !coord∫distance
                && <coord∫y === y + 1 || coord∫y === y - 1> 
                && coord∫x === x 
                && coord∫char !== »S«
                && coord∫char !== ».«
            >
        ∂>

        // left right connector
        ∑<char === »-«> <∂
            destine coordinates∫find<<coord> (*) !coord∫distance 
                && <coord∫x === x + 1 || coord∫x === x - 1> 
                && coord∫y === y 
                && coord∫char !== »S«
                && coord∫char !== ».«
            >
        ∂>

        // top right connector
        ∑<char === »L«> <∂
            destine coordinates∫find<<coord> (*) !coord∫distance 
                && <<coord∫y === y - 1 && coord∫x === x> || <coord∫x === x + 1 && coord∫y === y>>
                 && coord∫char !== »S«
                && coord∫char !== ».«
            >
        ∂>

        // top left connector
        ∑<char === »J«> <∂
            destine coordinates∫find<<coord> (*) !coord∫distance
                && <<coord∫y === y - 1 && coord∫x === x> || <coord∫x === x - 1 && coord∫y === y>> 
                 && coord∫char !== »S«
                && coord∫char !== ».«
            >
        ∂>

        ∑<char === »F«> <∂
            destine coordinates∫find<<coord> (*) !coord∫distance 
                && <<coord∫y === y + 1 && coord∫x === x> || <coord∫x === x + 1 && coord∫y === y>> 
                 && coord∫char !== »S«
                && coord∫char !== ».«
            >
        ∂>

        ∑<char === »7«> <∂
            destine coordinates∫find<<coord> (*) !coord∫distance 
                && <<coord∫y === y + 1 && coord∫x === x> || <coord∫x === x - 1 && coord∫y === y>> 
                 && coord∫char !== »S«
                && coord∫char !== ».«
            >
        ∂>
    ∂>>
    skæld∫inscribe<<∂coordPair, nextCoords, maxDistance∂>>
    nextStep<nextCoords>
∂>

// Start the iteration
nextStep<surroundingCoordinates>

// Get the highest value

skæld∫inscribe<<∂maxDistance, start∂>>