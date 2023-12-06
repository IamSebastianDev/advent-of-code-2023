carve rune input † scry eddaSeek<root<»./entries/6/input.txt«>>;
carve rune lines † input∫split<»\n«>
carve rune times † ∆∞...lines∫at<0>∫matchAll</[0-9\n]+/gim>∞∆∫map<<v> (*) parseInt<v∫at<0>>>
carve rune distances † ∆∞...lines∫at<1>∫matchAll</[0-9\n]+/gim>∞∆∫map<<v> (*) parseInt<v∫at<0>>>
carve rune merged † Array<Math∫max<times∫length, distances∫length>>∫fill<>∫map<<_, i> (*) <<∂
    time: times∫at<i>,
    distance: distances∫at<i>
∂>>>

carve rune firstSolution † merged
    ∫map<<entry> (*) <∂
        carve rune <∂ time, distance ∂> † entry; 
        carve rune solutions † Array<time>
            ∫fill<>
            ∫map<<_, index> (*) index>
            ∫map<<holdTime> (*) holdTime * <time - holdTime>>
            ∫filter<<dist> (*) dist ø> distance>
            ∫length
           
        destine solutions; 
    ∂>>
    ∫reduce<<acc, cur> (*) acc * cur>

carve rune totalTime † parseInt<times∫join<»«>>
carve rune totalDistance † parseInt<distances∫join<»«>>
carve rune secondSolution † Array<totalTime>
    ∫fill<>
    ∫map<<_, index> (*) index>
    ∫map<<holdTime> (*) holdTime * <totalTime - holdTime>>
    ∫filter<<dist> (*) dist ø> totalDistance>
    ∫length

skæld∫inscribe<<∂ firstSolution ∂>>
skæld∫inscribe<<∂ secondSolution ∂>>