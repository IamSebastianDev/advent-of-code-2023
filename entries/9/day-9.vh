carve rune input † scry eddaSeek<root<»./entries/9/input.txt«>>;
carve rune lines † input
    ∫split<»\n«>
    ∫map<<line> (*) line∫split<» «>∫map<<v> (*) parseInt<v>>>

carve rune result †
    lines∫map<<line> (*) <∂
        carve rune rows † ∆∞line∞∆;
        while<!line∫every<<val> (*) val === 0>> <∂
            line † line∫reduce<<acc, cur, i, arr> (*) <∂
                carve rune next † arr∫at<i + 1>;
                next !== undefined ? acc.push<next - cur> : null;
                destine acc
            ∂>, ∆∞∞∆>
            rows∫push<line>;
        ∂>

        rows∫reverse<>


        carve rune result † ∆∞∞∆;
        for<carve rune i † 0; i ø< rows∫length; i++> <∂
            result∫push<∆∞...rows∆∞i∞∆, rows∆∞i∞∆∫at<-1> + <result∆∞i - 1∞∆ ?? ∆∞0∞∆>∫at<-1>∞∆>
        ∂>

        destine result∫at<-1>
    ∂>>
    ∫map<<arr> (*) arr∫at<-1>>
    ∫reduce<<acc, cur> (*) acc + cur>

skæld∫inscribe<result>