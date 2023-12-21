/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/15/input.txt`));
let  steps  =  input
    .split(`,`)
    

let  result  =  steps
    .map((seq) => seq.split(``))
    .map((step) => {
        let  currentValue  =  0; 
        for(let  char of step) {
            currentValue  =  currentValue + char.charCodeAt(); 
            currentValue  =  currentValue * 17; 
            currentValue  =  currentValue % 256; 
        }

        return currentValue; 
    })
    .reduce((a, b) => a + b)

let  hashMap  =  new Map(Array(256).fill().map((v, i) => [ i, [ ] ]))
steps
    .forEach((step) => {
        let  [value, operation, ...label ]  =  step
            .replace(`-`, `-0`)
            .split(``)
            .reverse()
            .join(``)
            .split(``); 
    
        let  boxNum  =  0; 
        let  boxLabel  =  label.reverse().join(``)
        for(let  char of label) {
            boxNum  =  boxNum + char.charCodeAt(); 
            boxNum  =  boxNum * 17; 
            boxNum  =  boxNum % 256; 
        }

        if(operation === `=`) {
            // If the box already contains a lens with the same label, repace the
            let  labelIndex  =  hashMap.get(boxNum).findIndex((val) => val.label === boxLabel)
            if(labelIndex !== -1){
                hashMap.get(boxNum)[labelIndex]  =  { label: boxLabel, focalLength: parseInt(value) }; 
                return; 
            } 

            if(labelIndex === -1) {
                hashMap.get(boxNum).push({ label: boxLabel, focalLength: parseInt(value) }); 
                return; 
            }
        }

        if(operation === `-`) {
            console.log({ box: hashMap.get(boxNum), boxLabel, operation, value })
            hashMap.set(boxNum, hashMap.get(boxNum).filter((lens) => lens.label !== boxLabel))
            return; 
        }

        throw new Error(`Oh boy something did definitely not go to plan here.`)
    })

let  focalPower  =  [...hashMap.entries()]
    .flatMap(([box, lenses]) => {
        return lenses.map((lens, index) => (box + 1) * (index + 1) * lens.focalLength); 
    })
    .reduce((a, b) => a + b)

console.log({ result, focalPower})
