/**
 * @param {number[]} nums
 * @return {number}
 */
var sumCounts = function (nums) {
    let answer = 0;

    for (let i = 0; i < nums.length; i++) {
        const distinct = new Set();

        for (let j = i; j < nums.length; j++) {
            distinct.add(nums[j]);

            answer += distinct.size ** 2;
        }
    }

    return answer;
};