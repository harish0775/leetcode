/**
 * @param {character[][]} picture
 * @return {number}
 */
var findLonelyPixel = function(picture) {
    let m = picture.length;
    let n = picture[0].length;

    let rowCount = new Array(m).fill(0);
    let colCount = new Array(n).fill(0);

    // Step 1: Count B in every row and column
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (picture[i][j] === 'B') {
                rowCount[i]++;
                colCount[j]++;
            }
        }
    }

    let lonely = 0;

    // Step 2: Find lonely B
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (
                picture[i][j] === 'B' &&
                rowCount[i] === 1 &&
                colCount[j] === 1
            ) {
                lonely++;
            }
        }
    }

    return lonely;
};