/**
 * @param {number} n
 * @param {number[][]} edges
 * @param {string} labels
 * @param {number} k
 * @return {number}
 */
var shortestPath = function(n, edges, labels, k) {
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
    }

    const heap = [];

    function push(item) {
        heap.push(item);
        let i = heap.length - 1;

        while (i > 0) {
            let parent = Math.floor((i - 1) / 2);

            if (heap[parent][0] <= heap[i][0]) break;

            [heap[parent], heap[i]] = [heap[i], heap[parent]];
            i = parent;
        }
    }

    function pop() {
        const top = heap[0];
        const last = heap.pop();

        if (heap.length === 0) return top;

        heap[0] = last;
        let i = 0;

        while (true) {
            let left = 2 * i + 1;
            let right = 2 * i + 2;
            let smallest = i;

            if (left < heap.length &&
                heap[left][0] < heap[smallest][0]) {
                smallest = left;
            }

            if (right < heap.length &&
                heap[right][0] < heap[smallest][0]) {
                smallest = right;
            }

            if (smallest === i) break;

            [heap[i], heap[smallest]] =
                [heap[smallest], heap[i]];

            i = smallest;
        }

        return top;
    }

    const dist = Array.from(
        { length: n },
        () => Array(k + 1).fill(Infinity)
    );

    dist[0][1] = 0;
    push([0, 0, 1]);

    while (heap.length > 0) {
        const [cost, node, count] = pop();

        if (cost > dist[node][count]) continue;

        if (node === n - 1) return cost;

        for (const [next, weight] of graph[node]) {
            let newCount;

            if (labels[node] === labels[next]) {
                newCount = count + 1;
            } else {
                newCount = 1;
            }

            if (newCount > k) continue;

            const newCost = cost + weight;

            if (newCost < dist[next][newCount]) {
                dist[next][newCount] = newCost;
                push([newCost, next, newCount]);
            }
        }
    }

    return -1;
};
