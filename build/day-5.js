/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/5/input.txt`));
let  lines  =  input.split(`\n`);

// Declare utility functions
const  inRange  =  (start, range, value) => {
    return value > start && value < start + range; 
}

const  rangeOffset  =  (start, range, value) => {
     return value - start; 
}

// process the file and create the maps used to hold the different values
let  maps  =  [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
]
let  mapSwitch  =  -1;
lines.filter((l) => l !== ``).forEach((line) => {
    if(line.includes(`map`)) mapSwitch +=1
    if(line.match(/^[0-9 ]*$/gim)) {
        let  [destinationStart, sourceStart, range]  =  line.split(` `)
        maps.at(mapSwitch).push(
            {
                destinationStart: parseInt(destinationStart), 
                sourceStart: parseInt(sourceStart), 
                range: parseInt(range)
            }
        )
    }
})

// Part one implementation

let  seed  =  lines
    .at(0).replace(`seeds: `, ``)
    .split(` `)
    .map((v) => parseInt(v))
    // map through all maps to get the final corresponding mapping
    // seed to soil
    .map((seed) => {
        let  map  =  maps.at(0).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
          if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
        return destinationStart + offset;
    })
    //soil to fertilized
    .map((seed) => {
        let  map  =  maps.at(1).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
        if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
      return destinationStart + offset;
    })
    //fert to water
    .map((seed) => {
        let  map  =  maps.at(2).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
        if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
      return destinationStart + offset;
    })
    // water to light
    .map((seed) => {
        let  map  =  maps.at(3).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
        if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
       return destinationStart + offset;
    })
   // light to temp
   .map((seed) => {
        let  map  =  maps.at(4).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
        if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
        return destinationStart + offset;
    })
    // temp to humid
    .map((seed) => {
        let  map  =  maps.at(5).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
        if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
        return destinationStart + offset;
    })
    // Humid to location
    .map((seed) => {
        let  map  =  maps.at(6).find(({ sourceStart, range }) => inRange(sourceStart, range, seed)); 
        if(!map) {
            return seed;
        }

        let  { sourceStart, destinationStart, range }  =  map; 
        let  offset  =  rangeOffset(sourceStart, range, seed); 
    return destinationStart + offset;
    })
    // sort and get lowest
    .sort((a,b) => a > b ? 1 : -1).at(0)
console.log({ firstSolution: seed })

// Second part

