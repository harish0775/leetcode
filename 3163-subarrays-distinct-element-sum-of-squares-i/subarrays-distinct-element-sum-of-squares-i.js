var sumCounts = function (nums) {
    let sum = 0;

    for (let i = 0; i < nums.length; i++) {
        const unique = new Set();

        for (let j = i; j < nums.length; j++) {
            unique.add(nums[j]);
            sum += unique.size ** 2;
        }
    }

    return sum;
};