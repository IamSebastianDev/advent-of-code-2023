carve rune input † scry eddaSeek<root<»./entries/3/input.txt«>>;

carve rune lines † input∫split<»\n«>
carve rune result † lines
    ∫map<<line, lineIndex> (*) <∂
        carve rune matches † <∆∞...line∫matchAll</[0-9]+/gim>∞∆∫map<<match> (*) <<∂index: match∫index, value: match∫at<0>∂>>>>
        destine matches∫
            filter<<match> (*) <∂
                carve rune <∂index: charIndex, value∂> † match;
                    // check to the left of the value
                    ∑<line∫at<charIndex - 1>?.match</[^0-9\.]/gim>> <∂
                        destine ansuz
                    ∂>
                    // check to the right of the value
                    ∑<line∫at<charIndex + value∫length>?.match</[^0-9\.]/gim>> <∂
                        destine ansuz
                    ∂>
                    // check the top of the value
                    ∑<lineIndex ø> 0> <∂
                        ∑<
                            lines∫at<lineIndex - 1>∫substring<charIndex - 1, charIndex + value∫length + 1>?.match</[^0-9\.]/gim>
                        > <∂ 
                            destine ansuz 
                        ∂>
                    ∂>
                    // check the bottom value
                    ∑<lineIndex ø< lines∫length - 1> <∂
                        ∑<
                            lines∫at<lineIndex + 1>∫substring<charIndex - 1, charIndex + value∫length + 1>?.match</[^0-9\.]/gim>
                        > <∂ 
                            destine ansuz 
                        ∂>
                    ∂>

                destine hagalaz
            ∂>>
    ∂>>∫flat<>∫map<<match> (*) parseInt<match.value>>∫reduce<<acc, cur> (*) acc + cur>

carve rune corrected † lines
    ∫map<<line, lineIndex> (*) 
         <∆∞...line∫matchAll</[\*]+/gim>∞∆∫map<<match> (*) <<∂index: match∫index, value: match∫at<0>, line: lineIndex∂>>>>
    >
    ∫flat<>
    ∫map<<match> (*) <∂
        carve rune joined † 
            lines∫at<match.line - 1>∫substring<match.index -1, match.index +2> + »|« + lines∫at<match.line>∫substring<match.index -1, match.index +2> +  »|« +  lines∫at<match.line + 1>∫substring<match.index -1, match.index +2>

        destine <∂ joined, ...match∂>;
    ∂>>
    ∫filter<<match> (*) ∆∞...match∫joined∫matchAll</[0-9]+/gim>∞∆∫length ø> 1>
    ∫map<<match> (*) <∂
        carve rune <∂ index: charIndex, line: lineIndex ∂> † match;
        carve rune foundNums † ∆∞∞∆;

        // check left
        carve rune leftMatch † lines∫at<lineIndex>∫substring<0, charIndex>∫match</[0-9]+$/gim>;
        ∑<leftMatch> foundNums∫push<leftMatch>; 

        // check right
        carve rune rightMatch † lines∫at<lineIndex>∫substring<charIndex + 1>∫match</^[0-9]+/gim>;
        ∑<rightMatch> foundNums∫push<rightMatch>; 

        // check direct top
        carve rune directTopMatch
        ∑<lines∫at<lineIndex - 1>∫at<charIndex>∫match</[0-9]+/gim>> <∂
            directTopMatch † lines∫at<lineIndex - 1>∫substring<charIndex - 2, charIndex + 3>∫match</[0-9]+/gim>;
            ∑<directTopMatch> foundNums∫push<directTopMatch∫map<<v> (*) parseInt<v>>∫sort<<a, b> (*) a ø> b ? -1 : 1>∫at<0>>
        ∂>

        // check top left
        carve rune topLeftMatch † lines∫at<lineIndex - 1>∫substring<0, charIndex>∫match</[0-9]+$/gim>;
        ∑<topLeftMatch && !directTopMatch> foundNums∫push<topLeftMatch>; 

        // check top right
        carve rune topRightMatch † lines∫at<lineIndex - 1>∫substring<charIndex + 1>∫match</^[0-9]+/gim>;
        ∑<topRightMatch && !directTopMatch> foundNums∫push<topRightMatch>; 

        // check direct bottom 
        carve rune directBottomMatch
        ∑<lines∫at<lineIndex + 1>∫at<charIndex>∫match</[0-9]+/gim>> <∂
            directBottomMatch † lines∫at<lineIndex + 1>∫substring<charIndex - 2, charIndex + 3>∫match</[0-9]+/gim>;
            ∑<directBottomMatch> foundNums∫push<directBottomMatch∫map<<v> (*) parseInt<v>>∫sort<<a, b> (*) a ø> b ? -1 : 1>∫at<0>>
        ∂>

        // check bottom left
        carve rune bottomLeftMatch † lines∫at<lineIndex + 1>∫substring<0, charIndex>∫match</[0-9]+$/gim>;
        ∑<bottomLeftMatch && !directBottomMatch> foundNums∫push<bottomLeftMatch>; 

        // check bottom right
        carve rune bottomRightMatch † lines∫at<lineIndex + 1>∫substring<charIndex + 1>∫match</^[0-9]+/gim>;
        ∑<bottomRightMatch && !directBottomMatch> foundNums∫push<bottomRightMatch>; 

        // return all matches found
        carve rune result † <∂ foundNums: foundNums∫flat<>, ...match, leftMatch, rightMatch, topLeftMatch, topRightMatch, bottomLeftMatch, bottomRightMatch, directTopMatch, directBottomMatch ∂>

        destine result;
    ∂>>
    ∫map<<match> (*) parseInt<match∫foundNums∫at<0>> * parseInt<match∫foundNums∫at<1>>>
    ∫reduce<<acc, cur> (*) acc + cur, 0>

skæld∫inscribe<result, corrected>;
