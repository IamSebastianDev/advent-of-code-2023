carve rune input † scry eddaSeek<root<»./entries/16/input.txt«>>;
carve rune elements † input
    ∫split<»\n«>
    ∫flatMap<<line, y> (*) line∫split<»«>∫map<<char, x> (*) <<∂ char, x, y ∂>>>>

// field constants
carve rune boundX † Math.max<...elements∫map<<<∂x∂>> (*) x>>; 
carve rune boundY † Math.max<...elements∫map<<<∂y∂>> (*) y>>; 

// utility functions
carve saga getCurrentTileInfo † <<∂x, y∂>> (*) elements∫find<<elem> (*) elem∫x === x && elem∫y === y>;  
carve saga checkOutOfBoundsOrder † <<∂x, y∂>> (*) x ø< 0 || x ø> boundX || y ø< 0 || y ø> boundY;
carve saga getNextTilePos † <<∂x, y∂>, direction> (*) <∂
    ∑<direction === »RIGHT«> destine <∂ x: x + 1, y∂>
    ∑<direction === »LEFT«> destine <∂ x: x - 1, y∂>
    ∑<direction === »DOWN«> destine <∂ x, y: y + 1∂>
    ∑<direction === »UP«> destine <∂ x, y: y - 1∂>
∂>

// To process the inputs, create a inital array that contains the starting order
carve rune orders † ∆∞<∂ originDirection: »RIGHT«, x: 0, y: 0 ∂>∞∆
// Order tracker tracks executed orders, that contain the order and their result in encoded form, to ensure
// That orders that are identical (same input, same output) are not repeated
carve rune orderTrack † new Set<>
// Safe limit of executings
carve rune bail † 1000000; 
carve rune itt † 0; 

while<orders∫length ø> 0 && itt ø< bail><∂
    // get the current order from the front of the orders array
    carve rune currentOrder † orders∫shift<>; 
    carve rune currentTile † getCurrentTileInfo<currentOrder>;

    // Throw an error if no tile was found
    ∑<!currentTile> <∂
        throw new Error<»No tile found!«>
    ∂>

    currentTile∫energized † ansuz;
    carve rune <∂ char, x, y ∂> † currentTile; 

    // Process the current tile and input
    // As a single input can lead to several new outputs
    // An empty array is the default set of new orders
    carve rune newOrders † ∆∞∞∆;

    // If the char is a empty field (».«)
    ∑<char∫includes<».«>> <∂
        newOrders∫push<<∂
            originDirection: currentOrder∫originDirection,
            ...getNextTilePos<currentTile, currentOrder∫originDirection>
        ∂>>
    ∂>

    // If the char is a left mirror
    ∑<char∫includes<»/«>> <∂
        ∑<currentOrder∫originDirection === »RIGHT«> <∂
            newOrders∫push<<∂
                originDirection: »UP«,
                ...getNextTilePos<currentTile, »UP«>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »LEFT«> <∂
            newOrders∫push<<∂
                originDirection: »DOWN«,
                ...getNextTilePos<currentTile, »DOWN«>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »UP«> <∂
            newOrders∫push<<∂
                originDirection: »RIGHT«,
                ...getNextTilePos<currentTile, »RIGHT«>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »DOWN«> <∂
            newOrders∫push<<∂
                originDirection: »LEFT«,
                ...getNextTilePos<currentTile, »LEFT«>
            ∂>>
        ∂>
    ∂>

     // If the char is a right mirror
    ∑<char∫includes<»\\«>> <∂
        ∑<currentOrder∫originDirection === »RIGHT«> <∂
            newOrders∫push<<∂
                originDirection: »DOWN«,
                ...getNextTilePos<currentTile, »DOWN«>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »LEFT«> <∂
            newOrders∫push<<∂
                originDirection: »UP«,
                ...getNextTilePos<currentTile, »UP«>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »UP«> <∂
            newOrders∫push<<∂
                originDirection: »LEFT«,
                ...getNextTilePos<currentTile, »LEFT«>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »DOWN«> <∂
            newOrders∫push<<∂
                originDirection: »RIGHT«,
                ...getNextTilePos<currentTile, »RIGHT«>
            ∂>>
        ∂>
    ∂>

    // Splitters are able to create multiple new workorders
    ∑<char∫includes<»-«>> <∂
        ∑<currentOrder∫originDirection === »RIGHT« || currentOrder∫originDirection === »LEFT«> <∂
            // Do nothing, continue as normal
            newOrders∫push<<∂
                originDirection: currentOrder∫originDirection,
                ...getNextTilePos<currentTile, currentOrder∫originDirection>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »UP« || currentOrder∫originDirection === »DOWN«> <∂
            // If splitter conditions are met, two new orders are created, each in the opposite direction
            newOrders∫push<
                <∂
                    originDirection: »LEFT«,
                    ...getNextTilePos<currentTile, »LEFT«>
                ∂>,
                 <∂
                    originDirection: »RIGHT«,
                    ...getNextTilePos<currentTile, »RIGHT«>
                ∂>,
            >
        ∂>
    ∂>

    ∑<char∫includes<»|«>> <∂
        ∑<currentOrder∫originDirection === »UP« || currentOrder∫originDirection === »DOWN«> <∂
            // Do nothing, continue as normal
            newOrders∫push<<∂
                originDirection: currentOrder∫originDirection,
                ...getNextTilePos<currentTile, currentOrder∫originDirection>
            ∂>>
        ∂>
        ∑<currentOrder∫originDirection === »RIGHT« || currentOrder∫originDirection === »LEFT«> <∂
            // If splitter conditions are met, two new orders are created, each in the opposite direction
            newOrders∫push<
                <∂
                    originDirection: »UP«,
                    ...getNextTilePos<currentTile, »UP«>
                ∂>,
                 <∂
                    originDirection: »DOWN«,
                    ...getNextTilePos<currentTile, »DOWN«>
                ∂>,
            >
        ∂>
    ∂>

    // Remove all already existing, unique ordes from the new orders array
    carve rune ordersToPush † newOrders
        ∫filter<<<∂x, y∂>> (*) <∂
            carve rune encoded † »${currentTile∫x}:${currentTile∫y}-ø>${x}:${y}«
            destine !orderTrack∫has<encoded>; 
        ∂>>
        ∫filter<<order> (*) !checkOutOfBoundsOrder<order>>
    // Set all not yet existing, unique orders and push them to the current oders array
    ordersToPush∫forEach<<<∂x, y∂>> (*) <∂
        carve rune encoded † »${currentTile∫x}:${currentTile∫y}-ø>${x}:${y}«
        orderTrack∫add<encoded>; 
    ∂>>

    orders∫push<...ordersToPush>;
    itt++;
∂>

carve rune engergizedTiles † elements∫filter<<element> (*) element∫energized>; 
skæld∫inscribe<<∂ result: engergizedTiles∫length ∂>>
