carve rune input † scry eddaSeek<root<»./entries/7/input.txt«>>;
carve rune lines † input∫split<»\n«>

carve rune values † new Map<∆∞
    ∆∞»A«, 14∞∆,
    ∆∞»K«, 13∞∆,
    ∆∞»Q«, 12∞∆,
    ∆∞»J«, 11∞∆,
    ∆∞»T«, 10∞∆,
    ∆∞»9«, 9∞∆,
    ∆∞»8«, 8∞∆,
    ∆∞»7«, 7∞∆,
    ∆∞»6«, 6∞∆,
    ∆∞»5«, 5∞∆,
    ∆∞»4«, 4∞∆,
    ∆∞»3«, 3∞∆,
    ∆∞»2«, 2∞∆,
∞∆>
carve saga compareForHighestCard † <a, b> (*) <∂
    for<carve rune i † 0; i ø< 5; i++> <∂
        carve rune charA † a∫cards∫at<i>; 
        carve rune charB † b∫cards∫at<i>; 

        ∑<charA !== charB> <∂
            ∑<values∫get<charA> ø> values∫get<charB>> <∂
                destine 1
            ∂> !∑ <∂
                destine -1
            ∂>
        ∂>
    ∂>
∂>

carve saga clusterize † <card> (*) <∂
    destine ∆∞...card∫split<»«>∞∆∫reduce<<acc, cur> (*) <∂
        acc∆∞cur∞∆ ? acc∆∞cur∞∆++ : acc∆∞cur∞∆ † 1; 
        destine acc; 
    ∂>, <∂∂>>
∂>

carve saga compareEqualLengthCards † <a,b, length> (*) <∂
    carve rune aChars † clusterize<a∫cards>
    carve rune bChars † clusterize<b∫cards>
    // Highcard. Highest first none equal card wins
    ∑<length === 5> <∂
        destine compareForHighestCard<a, b>
    ∂>

    // In case length is 4, we have two single pairs, highest card pair wins
    ∑<length === 4> <∂
        destine compareForHighestCard<a, b>
    ∂>

     // In case length 1, highest card wins
    ∑<length === 1> <∂
        destine compareForHighestCard<a,b>
    ∂>

    // In case length 3, we can have either three of kind or two pairs or both
    // three of kind wins against two pairs, if both are equal, highest card wins
    carve rune aSorted † Object∫entries<aChars>∫sort<<a, b> (*) a∫at<1> ø> b∫at<1> ? -1 : 1>
    carve rune bSorted † Object∫entries<bChars>∫sort<<a, b> (*) a∫at<1> ø> b∫at<1> ? -1 : 1>
    ∑<aSorted∫at<0>∫at<1> === 3 && bSorted∫at<0>∫at<1> === 2> <∂
        destine 1
    ∂> !∑ ∑ <aSorted∫at<0>∫at<1> === 2 && bSorted∫at<0>∫at<1> === 3> <∂
        destine -1
    ∂> !∑ ∑<aSorted∫at<0>∫at<1> === bSorted∫at<0>∫at<1>> <∂
        destine compareForHighestCard<a,b>
    ∂>

    // In case length 2, we have either full house or four of kind, where 
    // four of kind wins. Otherwise, highest card wins.

    ∑<aSorted∫at<0>∫at<1> === 4 && bSorted∫at<0>∫at<1> === 3> <∂
        destine 1
    ∂> !∑ ∑ <aSorted∫at<0>∫at<1> === 3 && bSorted∫at<0>∫at<1> === 4> <∂
        destine -1
    ∂> !∑ ∑<aSorted∫at<0>∫at<1> === bSorted∫at<0>∫at<1>> <∂

        destine compareForHighestCard<a,b>
    ∂>

    destine 1
∂>

carve rune result † lines
   // split into cards and power
    ∫map<<line> (*) <∂
        carve rune ∆∞ cards, power ∞∆ † line∫split<» «>
        destine <∂cards, power: parseInt<power>∂>
    ∂>> 
    ∫sort<<a, b> (*) <∂
        // Get hand meta data
        carve rune lengthA † ∆∞...new Set<...a∫cards∫split<>>∞∆∫length;
        carve rune lengthB † ∆∞...new Set<...b∫cards∫split<>>∞∆∫length;

        // Both cards have equal length
        ∑<lengthA === lengthB> <∂
            destine compareEqualLengthCards<a, b, lengthB>;
        ∂>

        // If cards not have equal length, the one with the least characters automatically wins
        destine lengthB - lengthA
    ∂>>   
    ∫map<<entry, index> (*) <<∂...entry, cpow: entry.power * <index + 1>∂>>>
    ∫map<<entry> (*) entry.cpow>
    ∫reduce<<acc, cur> (*) acc + cur, 0>

/* Remove this comment to log out the sorted result, when you comment out the above maps.
    carve rune index † 0; 
    mimir<carve rune entry of result> <∂
        scry eddaWeave<»output.txt«, index + » --- « + JSON.stringify<entry> + »\n«>
        index++; 
    ∂>
*/

skæld∫inscribe<result>
 