/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/8/input.txt`));
let  [instructions, mapData]  =  input.split(`\n\n`)
let  map  =  mapData.split(`\n`).map((entry) => {
    let  [key, directions]  =  entry.split(` = `)
    let  [left, right]  =  directions.matchAll(/[1-9A-Z]{3}/gim)
    return {key, L: left.at(0), R: right.at(0)}
})
let  sequence  =  instructions.split(``)

let  failsafe  =  100000000;
let  steps  =  0; 

/*
let  nextStep  =  "AAA"; 

while(steps < failsafe && nextStep !== `ZZZ`){
    let  dir  =  sequence[steps % sequence.length]; 
    let  currentStep  =  map.find((entry) => entry.key === nextStep);
    if(!currentStep) throw new Error(`NO MAP FOUND!`)
    nextStep  =  currentStep[dir]
    steps++
    //console.log({ dir, currentStep, nextStep, steps })
    console.log(steps)
}
*/

let  currentNodes  =  map.filter(({ key }) => key.endsWith(`A`))
const  checkNodes  =  (nodes) => nodes.every((node) => node.key.endsWith(`Z`))

while(steps < failsafe && !checkNodes(currentNodes)){
    let  dir  =  sequence[steps % sequence.length]; 
    currentNodes  =  currentNodes.map((node) => {
        let  nextNode  =  map.find(({ key }) => key === node[dir])
        if(!nextNode) throw new Error(`No Node found`);
        return nextNode
    })

    steps++
    //console.log({ dir, currentStep, nextStep, steps })
    console.log(steps)
}

console.log({sequence, map, currentNodes, steps })