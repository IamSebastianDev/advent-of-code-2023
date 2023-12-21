/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/11/input.txt`));
let  lines  =  input.split(`\n`)

// This is amount specified to expand the universe
let  expansionFactor  =  100000


let  map  =  lines
    // update rows
    .flatMap((line) => !line.includes(`#`) ? Array(expansionFactor).fill().map(() => line) : [line] )
// update columns
let  columns  =   map.at(0).length; 
let  updatedMap  =  Array(map.length).fill().map(() => []); 
for(let  index  =  0; index < columns; index++) {
    let  chars  =  map.map((line) => line.at(index)); 
    // galaxy exists, push the chars to the updatedMap
    if(chars.includes(`#`)) {
        chars.forEach((char, i) => updatedMap[i].push(char)); 
    } else {
        Array(expansionFactor).forEach(() => {
            chars.forEach((char, i) => updatedMap[i].push(char)); 
        })
    }
}

// convert input to coordinates
let  galaxyMap  =  updatedMap
    .map((line) => line.join(``))
    .flatMap((line, y) => {
        console.log({line, y})
        return line.split(``).map((char, x) => ({char, x, y}))
    })

console.log({galaxyMap})
// get all galaxy coordinates
let  galaxies  =  galaxyMap.filter(({char}) => char === `#`)
// create pairs
let  pairs  =  galaxies
    .map((galaxy, index, arr) => {
        return arr.slice(index + 1).map((pair) => [galaxy, pair])
    })
    .flat(1)

console.log({pairs})

// get distance between a.x, a.y & b.x, b.y
const  getDistance  =  (a, b) => {
    // steps between galaxies is easy to calculate by taking the x amount of steps which is
    let  xSteps  =  Math.abs(a.x - b.x); 
    let  ySteps  =  Math.abs(a.y - b.y); 
    return {xSteps, ySteps, length: xSteps + ySteps};
}

// get distance between each pair of galaxies
let  distances  =  pairs.map(([a, b], index) => {
    console.log({a, b, index})
    return getDistance(a, b)
})
let  distance  =  distances.map((distance) => distance.length).reduce((a, b) => a + b)

console.log({ distance, distances })