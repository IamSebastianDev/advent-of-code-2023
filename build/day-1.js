/**
 * Standard Library
 *
 * @format
 */

import { writeFile, readFile, appendFile, rm } from 'node:fs/promises';
import { resolve, join } from 'node:path';

let input = await readFile(`./entries/1/input.txt`, 'utf-8');
let result = input
    .split(`\n`)
    .map((line) => line.replace(/[^0-9]/gim, ``))
    .map((nums) => parseInt([nums.at(0), nums.at(-1)].join(``)))
    .reduce((acc, cur) => acc + cur);

let dict = {
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    6: 6,
    7: 7,
    8: 8,
    9: 9,
};

let correctedResult = input
    .split(`\n`)
    .map((line) => {
        let first = line.match(/one|two|three|four|five|six|seven|eight|nine|[0-9]/gi).at(0);
        let second = [
            `one`,
            `two`,
            `three`,
            `four`,
            `five`,
            `six`,
            `seven`,
            `eight`,
            `nine`,
            `1`,
            `2`,
            `3`,
            `4`,
            `5`,
            `6`,
            `7`,
            `8`,
            `9`,
        ]
            .map((word) => line.lastIndexOf(word))
            .sort((a, b) => (a < b ? 1 : -1))
            .at(0);

        let parsed1 = dict[first];
        let parsed2 =
            dict[
                line
                    .substring(second)
                    .match(/one|two|three|four|five|six|seven|eight|nine|[0-9]/gi)
                    .at(0)
            ];
        console.log(line, parsed1, parsed2);

        return parseInt(`${parsed1}${parsed2}`);
    })
    .reduce((acc, cur) => acc + cur);

console.log(result, correctedResult);
