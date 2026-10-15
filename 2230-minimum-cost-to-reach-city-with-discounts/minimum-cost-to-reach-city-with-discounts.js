/**
 * @param {number} n
 * @param {number[][]} highways
 * @param {number} discounts
 * @return {number}
 */
var minimumCost = function (n, highways, discounts) {
    const graph = Array.from({ length: n }, () => []);

    for (const [from, to, toll] of highways) {
        graph[from].push([to, toll]);
        graph[to].push([from, toll]);
    }

    const limit = Math.min(discounts, n - 1);

    const dist = Array.from(
        { length: n },
        () => Array(limit + 1).fill(Infinity)
    );

    const heap = [];

    function push(state) {
        heap.push(state);
        let i = heap.length - 1;

        while (i > 0) {
            const parent = Math.floor((i - 1) / 2);

            if (heap[parent][0] <= heap[i][0]) break;

            [heap[parent], heap[i]] = [heap[i], heap[parent]];
            i = parent;
        }
    }

    function pop() {
        const smallest = heap[0];
        const last = heap.pop();

        if (heap.length > 0) {
            heap[0] = last;
            let i = 0;

            while (true) {
                let smallestIndex = i;
                const left = 2 * i + 1;
                const right = 2 * i + 2;

                if (
                    left < heap.length &&
                    heap[left][0] < heap[smallestIndex][0]
                ) {
                    smallestIndex = left;
                }

                if (
                    right < heap.length &&
                    heap[right][0] < heap[smallestIndex][0]
                ) {
                    smallestIndex = right;
                }

                if (smallestIndex === i) break;

                [heap[i], heap[smallestIndex]] =
                    [heap[smallestIndex], heap[i]];

                i = smallestIndex;
            }
        }

        return smallest;
    }

    dist[0][0] = 0;
    push([0, 0, 0]);

    while (heap.length > 0) {
        const [cost, city, used] = pop();

        if (cost !== dist[city][used]) continue;

        if (city === n - 1) return cost;

        for (const [next, toll] of graph[city]) {
            const fullCost = cost + toll;

            if (fullCost < dist[next][used]) {
                dist[next][used] = fullCost;
                push([fullCost, next, used]);
            }

            if (used < limit) {
                const discountedCost = cost + Math.floor(toll / 2);

                if (discountedCost < dist[next][used + 1]) {
                    dist[next][used + 1] = discountedCost;
                    push([discountedCost, next, used + 1]);
                }
            }
        }
    }

    return -1;
};