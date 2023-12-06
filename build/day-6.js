/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/6/input.txt`));
let  lines  =  input.split(`\n`)
let  times  =  [...lines.at(0).matchAll(/[0-9\n]+/gim)].map((v) => parseInt(v.at(0)))
let  distances  =  [...lines.at(1).matchAll(/[0-9\n]+/gim)].map((v) => parseInt(v.at(0)))
let  merged  =  Array(Math.max(times.length, distances.length)).fill().map((_, i) => ({
    time: times.at(i),
    distance: distances.at(i)
}))

let  firstSolution  =  merged
    .map((entry) => {
        let  { time, distance }  =  entry; 
        let  solutions  =  Array(time)
            .fill()
            .map((_, index) => index)
            .map((holdTime) => holdTime * (time - holdTime))
            .filter((dist) => dist > distance)
            .length
           
        return solutions; 
    })
    .reduce((acc, cur) => acc * cur)

let  totalTime  =  parseInt(times.join(``))
let  totalDistance  =  parseInt(distances.join(``))
let  secondSolution  =  Array(totalTime)
    .fill()
    .map((_, index) => index)
    .map((holdTime) => holdTime * (totalTime - holdTime))
    .filter((dist) => dist > totalDistance)
    .length

console.log({ firstSolution })
console.log({ secondSolution })