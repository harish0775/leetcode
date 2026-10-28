
/**
 * @param {string} s
 * @return {number}
 */
var romanToInt = function (s) {
    console.log("Hell", s);
    let array = s.split('');
    console.log('array', array);

    let str = [];
    let i = 0;

    while (i < s.length) {
        if (s[i] == "I" && s[i + 1] == "I" && s[i + 2] == "I") {
            str.push(3);
            i += 3;
            continue;
        } else if (s[i] == "C" && s[i + 1] == "M") {
            str.push(900);
            i += 2;
            continue;
        } else if (s[i] == "C" && s[i + 1] == "D") {
            str.push(400);
            i += 2;
            continue;
        } else if (s[i] == "I" && s[i + 1] == "V") {
            str.push(4);
            i += 2;
            continue;
        } else if (s[i] == "V") {
            str.push(5);
            i++;
            continue;
        } else if (s[i] == "I" && s[i + 1] == "X") {
            str.push(9);
            i += 2;
            continue;
        } else if (s[i] == "I") {
            str.push(1);
            i++;
            continue;
        } else if (s[i] == "X" && s[i + 1] == "C") {
            str.push(90);
            i += 2;
            continue;
        } else if (s[i] == "X" && s[i + 1] == "L") {
            str.push(40);
            i += 2;
            continue;
        } else if (s[i] == "X") {
            str.push(10);
            i++;
            continue;
        } else if (s[i] == "L") {
            str.push(50);
            i++;
            continue;
        } else if (s[i] == "C") {
            str.push(100);
            i++;
            continue;
        } else if (s[i] == "D") {
            str.push(500);
            i++;
            continue;
        } else if (s[i] == "M") {
            str.push(1000);
            i++;
            continue;
        }
    }

    console.log("ast", str);

    let sum = 0;
    for (let j = 0; j < str.length; j++) {
        sum = sum + str[j];
    }

    console.log('Sum', sum);
    return sum;
};
