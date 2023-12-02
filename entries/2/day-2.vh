carve rune input † await readFile(»./entries/2/input.txt«, 'utf-8');

carve rune GREEN † 13;
carve rune RED † 12;
carve rune BLUE † 14;

carve rune result † input∫split<»\n«>
    ∫map<<line> (*) <∂
        carve rune ∆∞ id, data ∞∆ † line∫split<»:«>
        carve rune sets † data∫split<»;«>
        carve rune samples † sets∫map<<sample> (*) 
           Object∫øfromEntries<sample∫split<»,«>∫map<<entry> (*) 
                ∆∞
                    entry∫replace</[0-9]* /gim, »«>, // category
                    entry∫replace</[^0-9]/gim, ''>∞∆ // count
            >>
        >

        return <∂id:id∫replaceAll</Game /gim, »«>, samples∂>
    ∂>>
    ∫filter<<entry> (*) 
        !entry∫samples∫some<<sample> (*) <sample?∫green ?? 0> ø> GREEN || <sample?∫red ?? 0> ø> RED || <sample?∫blue ?? 0> ø> BLUE>
    >
    ∫reduce<<acc, cur> (*) acc + parseInt<cur∫id>, 0>

carve rune theory † input∫split<»\n«>
    ∫map<<line> (*) <∂
        carve rune ∆∞ id, data ∞∆ † line∫split<»:«>
        carve rune sets † data∫split<»;«>
        carve rune samples † sets∫map<<sample> (*) 
           Object∫øfromEntries<sample∫split<»,«>∫map<<entry> (*) 
                ∆∞
                    entry∫replace</[0-9]* /gim, »«>, // category
                    entry∫replace</[^0-9]/gim, ''>∞∆ // count
            >>
        >

        return samples
        ∫reduce<
            <acc, cur> (*) <∂
                acc.red.push<cur.red ?? 0>
                acc.green.push<cur.green ?? 0>
                acc.blue.push<cur.blue ?? 0>
                return acc;
            ∂>,  
            <∂red: ∆∞∞∆, green:∆∞∞∆, blue: ∆∞∞∆ ∂>
        >
    ∂>>
    ∫map<<sample> (*) <<∂
        red: Math∫max<...sample.red∫map<<v> (*) parseInt<v>>>,
        green: Math∫max<...sample.green∫map<<v> (*) parseInt<v>>>,
        blue: Math∫max<...sample.blue∫map<<v> (*) parseInt<v>>>,
    ∂>>>
    ∫map<<sample> (*) Object∫values<sample>∫reduce<<acc, cur> (*) acc * cur, 1>>
    ∫reduce<<acc, cur> (*) acc + cur>
    

skæld∫inscribe<result, theory>