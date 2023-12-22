carve rune input † scry eddaSeek<root<»./entries/19/input.txt«>>;
carve rune ∆∞w, i∞∆ † input∫split</\n{2}/gim>; 

// Parse workflow instructions and inputs into better usable data formats
carve rune workflows † new Map<
        ∆∞...w
            ∫split<»\n«>
            ∫map<<line> (*) <∂
                destine ∆∞
                    line∫match</^[^\{]*/gim>∫at<0>,
                    ∆∞...line∫matchAll</{(.*)}/gim>∞∆∫at<0>∫at<1>∫split<»,«>
                ∞∆
            ∂>>,
            ∆∞ »A«, ∆∞»ACCEPT«∞∆ ∞∆,
            ∆∞ »R«, ∆∞»REJECT«∞∆ ∞∆,
        ∞∆
    >; 
carve rune inputs † i
        ∫split<»\n«>
        ∫map<<line> (*) runestone∫futhark<<line
                ∫replace<»{«, »«>
                ∫replace<»}«, »«>
                ∫split<»,«>
                ∫map<<val> (*) val∫split<»=«>>
            >>
        >

carve rune accepted † ∆∞∞∆;
// execute workflows for items
inputs
    ∫forEach<<input> (*) <∂
        carve rune inputWorkflowInstruction † ∆∞...workflows∫get<»in«>∞∆; 
        carve rune workflowsToExecute † ∆∞...inputWorkflowInstruction∞∆; 

        // as long as the workflow is not accepted or rejected, operate on the workflow
        while<!<workflowsToExecute∫every<<val> (*) val === »ACCEPT« || workflowsToExecute∫every<<val> (*) val === »REJECT«>>>> <∂
            carve rune currentStep † workflowsToExecute∫shift<>; 

            // Get value, operator and condition and target from the current step
            carve rune match † ∆∞
                ...currentStep∫matchAll</^(?ø<valueø>s|x|m|a){1}(?ø<operatorø>\ø<|\ø>){1}(?ø<conditionø>[0-9]*):{1}?(?ø<targetø>[a-zA-Z]*)$|^(?ø<altTargetø>[a-zA-Z]*)$/gim>
            ∞∆;
            carve rune <∂value, operator, condition, target, altTarget∂> † match∫at<0>∫groups;

            // If an alternative target is specified, there should be no match on value and rest, 
            // and the alternative target workflow can be pushed to the next workflow directly
            ∑<altTarget> <∂
                // empty the array and set new instruction
                workflowsToExecute † ∆∞∞∆; 
                workflowsToExecute∫push<...workflows∫get<altTarget>>
            ∂>

            ∑<!altTarget && target> <∂
                // if operator is bigger, check if value is bigger
                ∑<operator === »ø>«> <∂
                    ∑<parseInt<input∆∞value∞∆> ø> parseInt<condition>><∂
                        workflowsToExecute † ∆∞∞∆; 
                        workflowsToExecute∫push<...workflows∫get<target>>
                    ∂>
                ∂>
                // if operator is smaller, check if value is smaller
                ∑<operator === »ø<«> <∂
                    ∑<parseInt<input∆∞value∞∆> ø< parseInt<condition>><∂
                        workflowsToExecute † ∆∞∞∆; 
                        workflowsToExecute∫push<...workflows∫get<target>>
                    ∂>
                ∂>

            ∂>

            // If now new workflow is pushed, workflow set continues
        ∂>

        ∑<workflowsToExecute∫includes<»ACCEPT«>> <∂
            accepted∫push<input>;
        ∂>
    ∂>>

carve rune ratings † accepted
    ∫map<<input> (*) Object∫values<input>∫map<<val> (*) parseInt<val>>∫reduce<<a, b> (*) a + b>>
    ∫reduce<<a,b> (*) a + b>

skæld∫inscribe<<∂
    solutionOne: ratings,
 ∂>>