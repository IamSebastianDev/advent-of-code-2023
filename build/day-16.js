/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/16/input.txt`));
let  elements  =  input
    .split(`\n`)
    .flatMap((line, y) => line.split(``).map((char, x) => ({ char, x, y })))

// field constants
let  boundX  =  Math.max(...elements.map(({x}) => x)); 
let  boundY  =  Math.max(...elements.map(({y}) => y)); 

// utility functions
const  getCurrentTileInfo  =  ({x, y}) => elements.find((elem) => elem.x === x && elem.y === y);  
const  checkOutOfBoundsOrder  =  ({x, y}) => x < 0 || x > boundX || y < 0 || y > boundY;
const  getNextTilePos  =  ({x, y}, direction) => {
    if(direction === `RIGHT`) return { x: x + 1, y}
    if(direction === `LEFT`) return { x: x - 1, y}
    if(direction === `DOWN`) return { x, y: y + 1}
    if(direction === `UP`) return { x, y: y - 1}
}

// To process the inputs, create a inital array that contains the starting order
let  orders  =  [{ originDirection: `RIGHT`, x: 0, y: 0 }]
// Order tracker tracks executed orders, that contain the order and their result in encoded form, to ensure
// That orders that are identical (same input, same output) are not repeated
let  orderTrack  =  new Set()
// Safe limit of executings
let  bail  =  1000000; 
let  itt  =  0; 

while(orders.length > 0 && itt < bail){
    // get the current order of the front of the orders array
    let  currentOrder  =  orders.shift(); 
    let  currentTile  =  getCurrentTileInfo(currentOrder);

    // Throw an error if no tile was found
    if(!currentTile) {
        throw new Error(`No tile found!`)
    }

    currentTile.energized  =  true;
    let  { char, x, y }  =  currentTile; 

    // Process the current tile and input
    // As a single input can lead to several new outputs
    // An empty array is the default set of new orders
    let  newOrders  =  [];

    // If the char is a empty field (`.`)
    if(char.includes(`.`)) {
        newOrders.push({
            originDirection: currentOrder.originDirection,
            ...getNextTilePos(currentTile, currentOrder.originDirection)
        })
    }

    // If the char is a left mirror
    if(char.includes(`/`)) {
        if(currentOrder.originDirection === `RIGHT`) {
            newOrders.push({
                originDirection: `UP`,
                ...getNextTilePos(currentTile, `UP`)
            })
        }
        if(currentOrder.originDirection === `LEFT`) {
            newOrders.push({
                originDirection: `DOWN`,
                ...getNextTilePos(currentTile, `DOWN`)
            })
        }
        if(currentOrder.originDirection === `UP`) {
            newOrders.push({
                originDirection: `RIGHT`,
                ...getNextTilePos(currentTile, `RIGHT`)
            })
        }
        if(currentOrder.originDirection === `DOWN`) {
            newOrders.push({
                originDirection: `LEFT`,
                ...getNextTilePos(currentTile, `LEFT`)
            })
        }
    }

     // If the char is a right mirror
    if(char.includes(`\\`)) {
        if(currentOrder.originDirection === `RIGHT`) {
            newOrders.push({
                originDirection: `DOWN`,
                ...getNextTilePos(currentTile, `DOWN`)
            })
        }
        if(currentOrder.originDirection === `LEFT`) {
            newOrders.push({
                originDirection: `UP`,
                ...getNextTilePos(currentTile, `UP`)
            })
        }
        if(currentOrder.originDirection === `UP`) {
            newOrders.push({
                originDirection: `LEFT`,
                ...getNextTilePos(currentTile, `LEFT`)
            })
        }
        if(currentOrder.originDirection === `DOWN`) {
            newOrders.push({
                originDirection: `RIGHT`,
                ...getNextTilePos(currentTile, `RIGHT`)
            })
        }
    }

    // Splitters are able to create multiple new workorders
    if(char.includes(`-`)) {
        if(currentOrder.originDirection === `RIGHT` || currentOrder.originDirection === `LEFT`) {
            // Do nothing, continue as normal
            newOrders.push({
                originDirection: currentOrder.originDirection,
                ...getNextTilePos(currentTile, currentOrder.originDirection)
            })
        }
        if(currentOrder.originDirection === `UP` || currentOrder.originDirection === `DOWN`) {
            // If splitter conditions are met, two new orders are created, each in the opposite direction
            newOrders.push(
                {
                    originDirection: `LEFT`,
                    ...getNextTilePos(currentTile, `LEFT`)
                },
                 {
                    originDirection: `RIGHT`,
                    ...getNextTilePos(currentTile, `RIGHT`)
                },
            )
        }
    }

    if(char.includes(`|`)) {
        if(currentOrder.originDirection === `UP` || currentOrder.originDirection === `DOWN`) {
            // Do nothing, continue as normal
            newOrders.push({
                originDirection: currentOrder.originDirection,
                ...getNextTilePos(currentTile, currentOrder.originDirection)
            })
        }
        if(currentOrder.originDirection === `RIGHT` || currentOrder.originDirection === `LEFT`) {
            // If splitter conditions are met, two new orders are created, each in the opposite direction
            newOrders.push(
                {
                    originDirection: `UP`,
                    ...getNextTilePos(currentTile, `UP`)
                },
                 {
                    originDirection: `DOWN`,
                    ...getNextTilePos(currentTile, `DOWN`)
                },
            )
        }
    }

    // Remove all already existing, unique ordes of the new orders array
    let  ordersToPush  =  newOrders
        .filter(({x, y}) => {
            let  encoded  =  `${currentTile.x}:${currentTile.y}->${x}:${y}`
            return !orderTrack.has(encoded); 
        })
        .filter((order) => !checkOutOfBoundsOrder(order))
    // Set all not yet existing, unique orders and push them to the current oders array
    ordersToPush.forEach(({x, y}) => {
        let  encoded  =  `${currentTile.x}:${currentTile.y}->${x}:${y}`
        orderTrack.add(encoded); 
    })

    orders.push(...ordersToPush);
    itt++;
}

let  engergizedTiles  =  elements.filter((element) => element.energized); 
console.log({ result: engergizedTiles.length })
