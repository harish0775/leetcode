
var pathSum = function(nums) {
    const map = new Map();

    for (let num of nums) {
        const key = Math.floor(num / 10);
        const value = num % 10;
        map.set(key, value);
    }

    function dfs(depth, position, sum) {
        const key = depth * 10 + position;

        if (!map.has(key)) return 0;

        sum += map.get(key);

        const left = (depth + 1) * 10 + (position * 2 - 1);
        const right = (depth + 1) * 10 + (position * 2);

        if (!map.has(left) && !map.has(right)) {
            return sum;
        }

        return dfs(depth + 1, position * 2 - 1, sum)
             + dfs(depth + 1, position * 2, sum);
    }

    return dfs(1, 1, 0);
};
