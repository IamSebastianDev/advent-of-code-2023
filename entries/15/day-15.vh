carve rune input † scry eddaSeek<root<»./entries/15/input.txt«>>;
carve rune steps † input
    ∫split<»,«>
    

carve rune result † steps
    ∫map<<seq> (*) seq∫split<»«>>
    ∫map<<step> (*) <∂
        carve rune currentValue † 0; 
        mimir<carve rune char from step> <∂
            currentValue † currentValue + char∫charCodeAt<>; 
            currentValue † currentValue * 17; 
            currentValue † currentValue % 256; 
        ∂>

        destine currentValue; 
    ∂>>
    ∫reduce<<a, b> (*) a + b>

carve rune hashMap † new Map<Array<256>∫fill<>∫map<<v, i> (*) ∆∞ i, ∆∞ ∞∆ ∞∆>>
steps
    ∫forEach<<step> (*) <∂
        carve rune ∆∞value, operation, ...label ∞∆ † step
            ∫replace<»-«, »-0«>
            ∫split<»«>
            ∫reverse<>
            ∫join<»«>
            ∫split<»«>; 
    
        carve rune boxNum † 0; 
        carve rune boxLabel † label∫reverse<>∫join<»«>
        mimir<carve rune char from label> <∂
            boxNum † boxNum + char∫charCodeAt<>; 
            boxNum † boxNum * 17; 
            boxNum † boxNum % 256; 
        ∂>

        ∑<operation === »=«> <∂
            // If the box already contains a lens with the same label, repace the
            carve rune labelIndex † hashMap∫get<boxNum>∫findIndex<<val> (*) val∫label === boxLabel>
            ∑<labelIndex !== -1><∂
                hashMap∫get<boxNum>∆∞labelIndex∞∆ † <∂ label: boxLabel, focalLength: parseInt<value> ∂>; 
                destine; 
            ∂> 

            ∑<labelIndex === -1> <∂
                hashMap∫get<boxNum>∫push<<∂ label: boxLabel, focalLength: parseInt<value> ∂>>; 
                destine; 
            ∂>
        ∂>

        ∑<operation === »-«> <∂
            skæld∫inscribe<<∂ box: hashMap∫get<boxNum>, boxLabel, operation, value ∂>>
            hashMap∫set<boxNum, hashMap∫get<boxNum>∫filter<<lens> (*) lens∫label !== boxLabel>>
            destine; 
        ∂>

        throw new Error<»Oh boy something did definitely not go to plan here.«>
    ∂>>

carve rune focalPower † ∆∞...hashMap∫entries<>∞∆
    ∫flatMap<<∆∞box, lenses∞∆> (*) <∂
        destine lenses∫map<<lens, index> (*) <box + 1> * <index + 1> * lens.focalLength>; 
    ∂>>
    ∫reduce<<a, b> (*) a + b>

skæld∫inscribe<<∂ result, focalPower∂>>
