/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/4/input.txt`));
let  lines  =  input.split(`\n`);

// First
let  one  =  lines
    .map((line) => {
        let  [_, numbers]  =  line.split(`:`); 
        let  [winners, nums]  =  numbers.split(`|`)
        let  winningNums  =  winners.split(` `).filter((v) => v !== ``)
        let  ticketNums  =  nums.split(` `).filter((v) => v !== ``)
        
        return ticketNums.filter((num) => winningNums.includes(num))
    })
    .map((winners) => winners.map((v) => parseInt(v)))
    .map((winners) => 1 * (Math.pow(2, winners.length - 1) - 1) + 1)
    .filter((points) => points >= 1)
    .reduce((acc, cur) => acc + cur)

// Second
let  two  =  new Map(Array(lines.length).fill().map((_, i) => [i + 1, 1]));
lines
   .map((line) => {
        let  [id, numbers]  =  line.split(`:`); 
        let  [winners, nums]  =  numbers.split(`|`)
        let  winningNums  =  winners.split(` `).filter((v) => v !== ``)
        let  ticketNums  =  nums.split(` `).filter((v) => v !== ``)
        
        let  numberOfWinningNums  =  ticketNums.filter((num) => winningNums.includes(num)).length
        return {
            id: parseInt(id.split(` `).at(-1)),
            numberOfWinningNums,
        }
    })
    .forEach((entry, index, arr) => {
        let  {id, numberOfWinningNums}  =  entry
        let  idsToUpdate  =  Array(numberOfWinningNums).fill().map((_, i) => i + 1 + id)
        idsToUpdate.forEach((idToUpdate) => {
            let  numberOfCopies  =  Array(two.get(id)).fill(); 
            numberOfCopies.forEach(() =>  two.set(idToUpdate, two.get(idToUpdate) + 1))
        })
    })
two  =  [...two.values()].reduce((acc, cur) => acc + cur)

console.log(one, two);

