carve rune input † scry eddaSeek<root<»./entries/8/input.txt«>>;
carve rune ∆∞instructions, mapData∞∆ † input∫split<»\n\n«>
carve rune map † mapData∫split<»\n«>∫map<<entry> (*) <∂
    carve rune ∆∞key, directions∞∆ † entry∫split<» = «>
    carve rune ∆∞left, right∞∆ † directions∫matchAll</[1-9A-Z]{3}/gim>
    destine <∂key, L: left∫at<0>, R: right∫at<0>∂>
∂>>
carve rune sequence † instructions∫split<»«>

carve rune failsafe † 100000000;
carve rune steps † 0; 

/*
carve rune nextStep † "AAA"; 

while<steps ø< failsafe && nextStep !== »ZZZ«><∂
    carve rune dir † sequence∆∞steps % sequence∫length∞∆; 
    carve rune currentStep † map∫find<<entry> (*) entry∫key === nextStep>;
    ∑<!currentStep> throw new Error<»NO MAP FOUND!«>
    nextStep † currentStep∆∞dir∞∆
    steps++
    //skæld∫inscribe<<∂ dir, currentStep, nextStep, steps ∂>>
    skæld∫inscribe<steps>
∂>
*/

carve rune currentNodes † map∫filter<<<∂ key ∂>> (*) key∫endsWith<»A«>>
carve saga checkNodes † <nodes> (*) nodes∫every<<node> (*) node∫key∫endsWith<»Z«>>

while<steps ø< failsafe && !checkNodes<currentNodes>><∂
    carve rune dir † sequence∆∞steps % sequence∫length∞∆; 
    currentNodes † currentNodes∫map<<node> (*) <∂
        carve rune nextNode † map∫find<<<∂ key ∂>> (*) key === node∆∞dir∞∆>
        ∑<!nextNode> throw new Error<»No Node found«>;
        destine nextNode
    ∂>>

    steps++
    //skæld∫inscribe<<∂ dir, currentStep, nextStep, steps ∂>>
    skæld∫inscribe<steps>
∂>

skæld∫inscribe<<∂sequence, map, currentNodes, steps ∂>>