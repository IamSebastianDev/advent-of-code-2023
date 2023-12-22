/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/19/input.txt`));
let  [w, i]  =  input.split(/\n{2}/gim); 

// Parse workflow instructions and inputs into better usable data formats
let  workflows  =  new Map(
        [...w
            .split(`\n`)
            .map((line) => {
                return [
                    line.match(/^[^\{]*/gim).at(0),
                    [...line.matchAll(/{(.*)}/gim)].at(0).at(1).split(`,`)
                ]
            }),
            [ `A`, [`ACCEPT`] ],
            [ `R`, [`REJECT`] ],
        ]
    ); 
let  inputs  =  i
        .split(`\n`)
        .map((line) => Object.fromEntries((line
                .replace(`{`, ``)
                .replace(`}`, ``)
                .split(`,`)
                .map((val) => val.split(`=`))
            ))
        )

let  accepted  =  [];
// execute workflows for items
inputs
    .forEach((input) => {
        let  inputWorkflowInstruction  =  [...workflows.get(`in`)]; 
        let  workflowsToExecute  =  [...inputWorkflowInstruction]; 

        // as long as the workflow is not accepted or rejected, operate on the workflow
        while(!(workflowsToExecute.every((val) => val === `ACCEPT` || workflowsToExecute.every((val) => val === `REJECT`)))) {
            let  currentStep  =  workflowsToExecute.shift(); 

            // Get value, operator and condition and target of the current step
            let  match  =  [
                ...currentStep.matchAll(/^(?<value>s|x|m|a){1}(?<operator>\<|\>){1}(?<condition>[0-9]*):{1}?(?<target>[a-zA-Z]*)$|^(?<altTarget>[a-zA-Z]*)$/gim)
            ];
            let  {value, operator, condition, target, altTarget}  =  match.at(0).groups;

            // If an alternative target is specified, there should be no match on value and break, 
            // and the alternative target workflow can be pushed to the next workflow directly
            if(altTarget) {
                // empty the array and set new instruction
                workflowsToExecute  =  []; 
                workflowsToExecute.push(...workflows.get(altTarget))
            }

            if(!altTarget && target) {
                // if operator is bigger, check if value is bigger
                if(operator === `>`) {
                    if(parseInt(input[value]) > parseInt(condition)){
                        workflowsToExecute  =  []; 
                        workflowsToExecute.push(...workflows.get(target))
                    }
                }
                // if operator is smaller, check if value is smaller
                if(operator === `<`) {
                    if(parseInt(input[value]) < parseInt(condition)){
                        workflowsToExecute  =  []; 
                        workflowsToExecute.push(...workflows.get(target))
                    }
                }

            }

            // If now new workflow is pushed, workflow set continues
        }

        if(workflowsToExecute.includes(`ACCEPT`)) {
            accepted.push(input);
        }
    })

let  ratings  =  accepted
    .map((input) => Object.values(input).map((val) => parseInt(val)).reduce((a, b) => a + b))
    .reduce((a,b) => a + b)

console.log({
    solutionOne: ratings,
 })