/** Script compiled with @iasd/mjolnir@1.1.1 */
/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/9/input.txt`));
let  lines  =  input
    .split(`\n`)
    .map((line) => line.split(` `).map((v) => parseInt(v)))

let  result  = 
    lines.map((line) => {
        let  rows  =  [line];
        while(!line.every((val) => val === 0)) {
            line  =  line.reduce((acc, cur, i, arr) => {
                let  next  =  arr.at(i + 1);
                next !== undefined ? acc.push(next - cur) : null;
                return acc
            }, [])
            rows.push(line);
        }

        rows.reverse()


        let  result  =  [];
        for(let  i  =  0; i < rows.length; i++) {
            result.push([...rows[i], rows[i].at(-1) + (result[i - 1] ?? [0]).at(-1)])
        }

        return result.at(-1)
    })
    .map((arr) => arr.at(-1))
    .reduce((acc, cur) => acc + cur)

let  second  = 
    lines.map((line) => {
        let  rows  =  [line];
        while(!line.every((val) => val === 0)) {
            line  =  line.reduce((acc, cur, i, arr) => {
                let  next  =  arr.at(i + 1);
                next !== undefined ? acc.push(next - cur) : null;
                return acc
            }, [])
            rows.push(line);
        }

        rows.reverse()


        let  result  =  [];
        for(let  i  =  0; i < rows.length; i++) {
            result.push([rows[i].at(0) - (result[i - 1] ?? [0]).at(0), ...rows[i],])
        }

        return result.at(-1)
    })
    .map((arr) => arr.at(0))
    .reduce((acc, cur) => acc + cur)

console.log(second)