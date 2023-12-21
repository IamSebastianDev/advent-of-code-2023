/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/21/input.txt`));
let  tiles  =  input
    .split(`\n`)
    .flatMap((line, y) => line.split(``).map((char, x) => ({ char, x, y })))

// Get the starting location; 
let  startingPos  =  tiles.find(({char}) => char === `S`)
// Number of steps available
let  stepsAvailable  =  64;

let  reachedGardenPlots  =  [ [startingPos] ]; 

// Perform the available amount of steps
Array(stepsAvailable).fill().forEach((_, index) => {
    // get all neighboring tiles that are also a garden plot, based on the plots reached in the last step
    let  lastSteps  =  reachedGardenPlots.at(index); 
    console.log({lastSteps, index})
    let  neighbours  =  []; 
    // check all cardinal directions, push if eligble
    for(let  step of lastSteps){
        // top
        let  top  =  tiles.find(({x, y, char}) => char !== `#` && x === step.x && y === step.y - 1)
        if(top) neighbours.push(top); 
        // bottom
        let  bottom  =  tiles.find(({x, y, char}) => char !== `#` && x === step.x && y === step.y + 1)
        if(bottom) neighbours.push(bottom); 
        // right
        let  right  =  tiles.find(({x, y, char}) => char !== `#` && x === step.x + 1 && y === step.y)
        if(right) neighbours.push(right); 
        // left
        let  left  =  tiles.find(({x, y, char}) => char !== `#` && x === step.x - 1 && y === step.y)
        if(left) neighbours.push(left); 
    }

    // Push a unique set of elements to the index
    reachedGardenPlots[index + 1]  =  [...new Set([...neighbours.map(({x, y}) => `${x}:${y}`)])]
        .map((str) => {
                let  [x, y]  =  str.split(`:`); 
                return {x: parseInt(x), y: parseInt(y)}
            }
        );
})

// container for reachable tiles, that uses encoded x/y coords to store unique location data
let  reachableTiles  =  new Set(); 
reachedGardenPlots
    .at(-1)
    .forEach(({x, y}) => reachableTiles.add(`${x}:${y}`))

console.log({
    solutionOne: [...reachableTiles].length
}); 