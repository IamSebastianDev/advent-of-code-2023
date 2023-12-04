carve rune input † scry eddaSeek<root<»./entries/4/input.txt«>>;
carve rune lines † input∫split<»\n«>;

// First
carve rune one † lines
    ∫map<<line> (*) <∂
        carve rune ∆∞_, numbers∞∆ † line∫split<»:«>; 
        carve rune ∆∞winners, nums∞∆ † numbers∫split<»ø|«>
        carve rune winningNums † winners∫split<» «>∫filter<<v> (*) v !== »«>
        carve rune ticketNums † nums∫split<» «>∫filter<<v> (*) v !== »«>
        
        destine ticketNums∫filter<<num> (*) winningNums∫includes<num>>
    ∂>>
    ∫map<<winners> (*) winners∫map<<v> (*) parseInt<v>>>
    ∫map<<winners> (*) 1 * (Math.pow(2, winners.length - 1) - 1) + 1>
    ∫filter<<points> (*) points ø>= 1>
    ∫reduce<<acc, cur> (*) acc + cur>

// Second
carve rune two † new Map<Array<lines.length>∫fill<>∫map<<_, i> (*) ∆∞i + 1, 1∞∆>>;
lines
   ∫map<<line> (*) <∂
        carve rune ∆∞id, numbers∞∆ † line∫split<»:«>; 
        carve rune ∆∞winners, nums∞∆ † numbers∫split<»ø|«>
        carve rune winningNums † winners∫split<» «>∫filter<<v> (*) v !== »«>
        carve rune ticketNums † nums∫split<» «>∫filter<<v> (*) v !== »«>
        
        carve rune numberOfWinningNums † ticketNums∫filter<<num> (*) winningNums∫includes<num>>∫length
        destine <∂
            id: parseInt<id∫split<» «>∫at<-1>>,
            numberOfWinningNums,
        ∂>
    ∂>>
    ∫forEach<<entry, index, arr> (*) <∂
        carve rune <∂id, numberOfWinningNums∂> † entry
        carve rune idsToUpdate † Array<numberOfWinningNums>∫fill()∫map((_, i) => i + 1 + id)
        idsToUpdate∫forEach<<idToUpdate> (*) <∂
            carve rune numberOfCopies † Array<two∫get<id>>∫fill<>; 
            numberOfCopies∫forEach<<> (*)  two∫set<idToUpdate, two∫get<idToUpdate> + 1>>
        ∂>>
    ∂>>
two † ∆∞...two∫values<>∞∆∫reduce<<acc, cur> (*) acc + cur>

skæld∫inscribe<one, two>;

