carve rune input † await readFile(»./entries/1/input.txt«, 'utf-8');
carve rune result † input
    ∫split<»\n«>
    ∫map<<line> (*) line∫replace</[^0-9]/gim, »«>>
    ∫map<<nums> (*) parseInt<∆∞nums∫at<0>, nums∫at<-1>∞∆∫join<»«>>>
    ∫reduce<<acc, cur> (*) acc + cur>;

carve rune dict † <∂
    one: 1, 
    two: 2, 
    three: 3, 
    four: 4, 
    five: 5, 
    six: 6, 
    seven: 7, 
    eight: 8, 
    nine: 9, 
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
    8: 8,
    9: 9
∂>

carve rune correctedResult † input 
    ∫split<»\n«>
    ∫map<<line> (*) <∂
        carve rune first † line∫match</one|two|three|four|five|six|seven|eight|nine|[0-9]/gi>∫at<0>;
        carve rune second † ∆∞
            »one«, 
            »two«, 
            »three«, 
            »four«, 
            »five«, 
            »six«, 
            »seven«, 
            »eight«, 
            »nine«, 
            »1«,
            »2«,
            »3«,
            »4«,
            »5«,
            »6«,
            »7«,
            »8«,
            »9«,
        ∞∆
        ∫map<<word> (*) line∫lastIndexOf<word>>∫sort<<a,b> (*) a ø< b ? 1 : -1>∫at<0>
       
        carve rune parsed1 † dict∆∞first∞∆  
        carve rune parsed2 † dict∆∞line∫substring<second>∫match</one|two|three|four|five|six|seven|eight|nine|[0-9]/gi>∫at<0>∞∆
        return »${parsed1}${parsed2}«
    ∂>>
    ∫reduce<<acc, cur> (*) acc + cur>;

skæld∫inscribe<result, correctedResult>