/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const eddaWeave = async (handle, content) => await appendFile(handle, content, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/7/input.txt`));
let  lines  =  input.split(`\n`)

let  values  =  new Map([
    [`A`, 14],
    [`K`, 13],
    [`Q`, 12],
    [`J`, 11],
    [`T`, 10],
    [`9`, 9],
    [`8`, 8],
    [`7`, 7],
    [`6`, 6],
    [`5`, 5],
    [`4`, 4],
    [`3`, 3],
    [`2`, 2],
])
const  compareForHighestCard  =  (a, b) => {
    for(let  i  =  0; i < 5; i++) {
        let  charA  =  a.cards.at(i); 
        let  charB  =  b.cards.at(i); 

        if(charA !== charB) {
            if(values.get(charA) > values.get(charB)) {
                return 1
            } else {
                return -1
            }
        }
    }
}

const  clusterize  =  (card) => {
    return [...card.split(``)].reduce((acc, cur) => {
        acc[cur] ? acc[cur]++ : acc[cur]  =  1; 
        return acc; 
    }, {})
}

const  compareEqualLengthCards  =  (a,b, length) => {
    let  aChars  =  clusterize(a.cards)
    let  bChars  =  clusterize(b.cards)
    // Highcard. Highest first none equal card wins
    if(length === 5) {
        return compareForHighestCard(a, b)
    }

    // In case length is 4, we have two single pairs, highest card pair wins
    if(length === 4) {
        return compareForHighestCard(a, b)
    }

     // In case length 1, highest card wins
    if(length === 1) {
        return compareForHighestCard(a,b)
    }

    // In case length 3, we can have either three of kind or two pairs or both
    // three of kind wins against two pairs, if both are equal, highest card wins
    let  aSorted  =  Object.entries(aChars).sort((a, b) => a.at(1) > b.at(1) ? -1 : 1)
    let  bSorted  =  Object.entries(bChars).sort((a, b) => a.at(1) > b.at(1) ? -1 : 1)
    if(aSorted.at(0).at(1) === 3 && bSorted.at(0).at(1) === 2) {
        return 1
    } else if (aSorted.at(0).at(1) === 2 && bSorted.at(0).at(1) === 3) {
        return -1
    } else if(aSorted.at(0).at(1) === bSorted.at(0).at(1)) {
        return compareForHighestCard(a,b)
    }

    // In case length 2, we have either full house or four of kind, where 
    // four of kind wins. Otherwise, highest card wins.

    if(aSorted.at(0).at(1) === 4 && bSorted.at(0).at(1) === 3) {
        return 1
    } else if (aSorted.at(0).at(1) === 3 && bSorted.at(0).at(1) === 4) {
        return -1
    } else if(aSorted.at(0).at(1) === bSorted.at(0).at(1)) {

        return compareForHighestCard(a,b)
    }

    return 1
}

let  result  =  lines
   // split into cards and power
    .map((line) => {
        let  [ cards, power ]  =  line.split(` `)
        return {cards, power: parseInt(power)}
    }) 
    .sort((a, b) => {
        // Get hand meta data
        let  lengthA  =  [...new Set(...a.cards.split())].length;
        let  lengthB  =  [...new Set(...b.cards.split())].length;

        // Both cards have equal length
        if(lengthA === lengthB) {
            return compareEqualLengthCards(a, b, lengthB);
        }

        // If cards not have equal length, the one with the least characters automatically wins
        return lengthB - lengthA
    })   
    .map((entry, index) => ({...entry, cpow: entry.power * (index + 1)}))
    .map((entry) => entry.cpow)
    .reduce((acc, cur) => acc + cur, 0)

/* Remove this comment to log out the sorted result, when you comment out the above maps.
    let  index  =  0; 
    for(let  entry of result) {
        await eddaWeave(`output.txt`, index + ` --- ` + JSON.stringify(entry) + `\n`)
        index++; 
    }
*/

console.log(result)
 