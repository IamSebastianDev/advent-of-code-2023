/** Standard Library */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** ValhallaScript compiled by @iasd/mjolnir@1.0.14 */

let  input  =  await readFile(`./entries/2/input.txt`, 'utf-8');

let  GREEN  =  13;
let  RED  =  12;
let  BLUE  =  14;

let  result  =  input.split(`\n`)
    .map((line) => {
        let  [ id, data ]  =  line.split(`:`)
        let  sets  =  data.split(`;`)
        let  samples  =  sets.map((sample) => 
           Object.fromEntries(sample.split(`,`).map((entry) => 
                [
                    entry.replace(/[0-9]* /gim, ``), // category
                    entry.replace(/[^0-9]/gim, '')] // count
            ))
        )

        return {id:id.replaceAll(/Game /gim, ``), samples}
    })
    .filter((entry) => 
        !entry.samples.some((sample) => (sample?.green ?? 0) > GREEN || (sample?.red ?? 0) > RED || (sample?.blue ?? 0) > BLUE)
    )
    .reduce((acc, cur) => acc + parseInt(cur.id), 0)

let  theory  =  input.split(`\n`)
    .map((line) => {
        let  [ id, data ]  =  line.split(`:`)
        let  sets  =  data.split(`;`)
        let  samples  =  sets.map((sample) => 
           Object.fromEntries(sample.split(`,`).map((entry) => 
                [
                    entry.replace(/[0-9]* /gim, ``), // category
                    entry.replace(/[^0-9]/gim, '')] // count
            ))
        )

        return samples
        .reduce(
            (acc, cur) => {
                console.log(acc)
                acc.red.push(cur.red ?? 0)
                acc.green.push(cur.green ?? 0)
                acc.blue.push(cur.blue ?? 0)
                return acc;
            },  
            {red: [], green:[], blue: [] }
        )
    })
    .map((sample) => ({
        red: Math.max(...sample.red.map((v) => parseInt(v))),
        green: Math.max(...sample.green.map((v) => parseInt(v))),
        blue: Math.max(...sample.blue.map((v) => parseInt(v))),
    }))
    .map((sample) => Object.values(sample).reduce((acc, cur) => acc * cur, 1))
    .reduce((acc, cur) => acc + cur)
    

console.log(result, theory)