/**
 * @param {number[][]} transactions
 * @return {number}
 */
var minTransfers = function (transactions) {
    const balance = new Map();

    for (const [from, to, amount] of transactions) {
        balance.set(from, (balance.get(from) || 0) - amount);
        balance.set(to, (balance.get(to) || 0) + amount);
    }

    const debts = [...balance.values()].filter(value => value !== 0);

    function dfs(start) {
        while (start < debts.length && debts[start] === 0) {
            start++;
        }

        if (start === debts.length) return 0;

        let minimum = Infinity;
        const tried = new Set();

        for (let i = start + 1; i < debts.length; i++) {
            if (debts[start] * debts[i] >= 0) continue;

            if (tried.has(debts[i])) continue;
            tried.add(debts[i]);

            const original = debts[i];

            debts[i] += debts[start];

            minimum = Math.min(minimum, 1 + dfs(start + 1));

            debts[i] = original;

            if (original + debts[start] === 0) break;
        }

        return minimum;
    }

    return dfs(0);
};