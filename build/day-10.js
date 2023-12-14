/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/10/input.txt`));
let  lines  =  input.split(`\n`)
let  coordinates  =  lines
    .map((line, y) => {
        return line.split(``).map((char, x) => ({char, x, y}))
    })
    .flat()
   
// find the starting point
let  start  =  coordinates.find(({char}) => char === `S`)
let  surroundingCoordinates  =  [
        // top
        coordinates.find(({x, y, char}) => y === start.y - 1 && x === start.x && [`|`, `7`, `F`].includes(char)),
        // left
        coordinates.find(({x, y, char}) => y === start.y && x === start.x - 1 && [`-`, `L`, `F`].includes(char)),
        // bottom
        coordinates.find(({x, y, char}) => y === start.y + 1 && x === start.x && [`|`, `J`, `L`].includes(char)),
        // right
        coordinates.find(({x, y, char}) => y === start.y && x === start.x + 1 && [`-`, `J`, `7`].includes(char)),
    ]
    .filter((v) => v !== undefined)

let  maxDistance  =  0
const  nextStep  =  (coordPair) => {
    if(coordPair.includes(undefined) || coordPair.every((coord) => coord.value !== undefined)) {
        return;
    }


    // assign the distance to the original coordinates based on the passed coord pair
    maxDistance++;
    coordPair.forEach((coord) => {
        let  originalCoordinate  =  coordinates.find(({ x, y }) => coord.x === x && coord.y === y);
        if(!originalCoordinate.distance) {
            originalCoordinate.distance  =  maxDistance
        }
    })

    // find the next coordinates based on the coordinates character
    let  nextCoords  =  coordPair.map(({char, x, y}) => {
        // top bottom connector
        if(char === `|`) {
            return coordinates.find((coord) => !coord.distance
                && (coord.y === y + 1 || coord.y === y - 1) 
                && coord.x === x 
                && coord.char !== `S`
                && coord.char !== `.`
            )
        }

        // left right connector
        if(char === `-`) {
            return coordinates.find((coord) => !coord.distance 
                && (coord.x === x + 1 || coord.x === x - 1) 
                && coord.y === y 
                && coord.char !== `S`
                && coord.char !== `.`
            )
        }

        // top right connector
        if(char === `L`) {
            return coordinates.find((coord) => !coord.distance 
                && ((coord.y === y - 1 && coord.x === x) || (coord.x === x + 1 && coord.y === y))
                 && coord.char !== `S`
                && coord.char !== `.`
            )
        }

        // top left connector
        if(char === `J`) {
            return coordinates.find((coord) => !coord.distance
                && ((coord.y === y - 1 && coord.x === x) || (coord.x === x - 1 && coord.y === y)) 
                 && coord.char !== `S`
                && coord.char !== `.`
            )
        }

        if(char === `F`) {
            return coordinates.find((coord) => !coord.distance 
                && ((coord.y === y + 1 && coord.x === x) || (coord.x === x + 1 && coord.y === y)) 
                 && coord.char !== `S`
                && coord.char !== `.`
            )
        }

        if(char === `7`) {
            return coordinates.find((coord) => !coord.distance 
                && ((coord.y === y + 1 && coord.x === x) || (coord.x === x - 1 && coord.y === y)) 
                 && coord.char !== `S`
                && coord.char !== `.`
            )
        }
    })
    console.log({coordPair, nextCoords, maxDistance})
    nextStep(nextCoords)
}

// Start the iteration
nextStep(surroundingCoordinates)

// Get the highest value

console.log({maxDistance, start})