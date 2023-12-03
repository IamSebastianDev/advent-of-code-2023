/** Imports */

import {writeFile,readFile,appendFile,rm} from "node:fs/promises";
import {resolve,join} from "node:path";

/** Methods */

const eddaSeek = async (handle) => await readFile(handle, 'utf-8')
const eddaEtch = async (handle, content) => await writeFile(handle, content, 'utf-8')
const eddaWeave = async (handle, content) => await appendFile(handle, content, 'utf-8')
const eddaExile = async (handle, content) => await rm(handle, { recursive: true, force: true })
const root = (...fragments) => resolve(join(process.cwd(), ...fragments))

/** Script */

let  input  =  await eddaSeek(root(`./entries/3/input.txt`));

let  lines  =  input.split(`\n`)
let  result  =  lines
    .map((line, lineIndex) => {
        let  matches  =  ([...line.matchAll(/[0-9]+/gim)].map((match) => ({index: match.index, value: match.at(0)})))
        return matches.
            filter((match) => {
                let  {index: charIndex, value}  =  match;
                    // check to the left of the value
                    if(line.at(charIndex - 1)?.match(/[^0-9\.]/gim)) {
                        return true
                    }
                    // check to the right of the value
                    if(line.at(charIndex + value.length)?.match(/[^0-9\.]/gim)) {
                        return true
                    }
                    // check the top of the value
                    if(lineIndex > 0) {
                        if(
                            lines.at(lineIndex - 1).substring(charIndex - 1, charIndex + value.length + 1)?.match(/[^0-9\.]/gim)
                        ) { 
                            return true 
                        }
                    }
                    // check the bottom value
                    if(lineIndex < lines.length - 1) {
                        if(
                            lines.at(lineIndex + 1).substring(charIndex - 1, charIndex + value.length + 1)?.match(/[^0-9\.]/gim)
                        ) { 
                            return true 
                        }
                    }

                return false
            })
    }).flat().map((match) => parseInt(match.value)).reduce((acc, cur) => acc + cur)

let  corrected  =  lines
    .map((line, lineIndex) => 
         ([...line.matchAll(/[\*]+/gim)].map((match) => ({index: match.index, value: match.at(0), line: lineIndex})))
    )
    .flat()
    .map((match) => {
        let  joined  =  
            lines.at(match.line - 1).substring(match.index -1, match.index +2) + `|` + lines.at(match.line).substring(match.index -1, match.index +2) +  `|` +  lines.at(match.line + 1).substring(match.index -1, match.index +2)

        return { joined, ...match};
    })
    .filter((match) => [...match.joined.matchAll(/[0-9]+/gim)].length > 1)
    .map((match) => {
        let  { index: charIndex, line: lineIndex }  =  match;
        let  foundNums  =  [];

        // check left
        let  leftMatch  =  lines.at(lineIndex).substring(0, charIndex).match(/[0-9]+$/gim);
        if(leftMatch) foundNums.push(leftMatch); 

        // check right
        let  rightMatch  =  lines.at(lineIndex).substring(charIndex + 1).match(/^[0-9]+/gim);
        if(rightMatch) foundNums.push(rightMatch); 

        // check direct top
        let  directTopMatch
        if(lines.at(lineIndex - 1).at(charIndex).match(/[0-9]+/gim)) {
            directTopMatch  =  lines.at(lineIndex - 1).substring(charIndex - 2, charIndex + 3).match(/[0-9]+/gim);
            if(directTopMatch) foundNums.push(directTopMatch.map((v) => parseInt(v)).sort((a, b) => a > b ? -1 : 1).at(0))
        }

        // check top left
        let  topLeftMatch  =  lines.at(lineIndex - 1).substring(0, charIndex).match(/[0-9]+$/gim);
        if(topLeftMatch && !directTopMatch) foundNums.push(topLeftMatch); 

        // check top right
        let  topRightMatch  =  lines.at(lineIndex - 1).substring(charIndex + 1).match(/^[0-9]+/gim);
        if(topRightMatch && !directTopMatch) foundNums.push(topRightMatch); 

        // check direct bottom 
        let  directBottomMatch
        if(lines.at(lineIndex + 1).at(charIndex).match(/[0-9]+/gim)) {
            directBottomMatch  =  lines.at(lineIndex + 1).substring(charIndex - 2, charIndex + 3).match(/[0-9]+/gim);
            if(directBottomMatch) foundNums.push(directBottomMatch.map((v) => parseInt(v)).sort((a, b) => a > b ? -1 : 1).at(0))
        }

        // check bottom left
        let  bottomLeftMatch  =  lines.at(lineIndex + 1).substring(0, charIndex).match(/[0-9]+$/gim);
        if(bottomLeftMatch && !directBottomMatch) foundNums.push(bottomLeftMatch); 

        // check bottom right
        let  bottomRightMatch  =  lines.at(lineIndex + 1).substring(charIndex + 1).match(/^[0-9]+/gim);
        if(bottomRightMatch && !directBottomMatch) foundNums.push(bottomRightMatch); 

        // return all matches found
        let  result  =  { foundNums: foundNums.flat(), ...match, leftMatch, rightMatch, topLeftMatch, topRightMatch, bottomLeftMatch, bottomRightMatch, directTopMatch, directBottomMatch }

        return result;
    })
    .map((match) => parseInt(match.foundNums.at(0)) * parseInt(match.foundNums.at(1)))
    .reduce((acc, cur) => acc + cur, 0)

console.log(result, corrected);
