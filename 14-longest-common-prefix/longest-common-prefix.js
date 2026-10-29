var longestCommonPrefix = function(strs) {
    let str = '';
    for (let i = 0; i < strs[0].length; i++) {
        let j = 1;
        while (j < strs.length) {
            if (strs[0][i] !== strs[j][i]) {
                return str;
            }
            j++;
        }

        str += strs[0][i];
    }

    return str;
};
