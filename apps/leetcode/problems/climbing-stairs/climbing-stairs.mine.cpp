// You are climbing a staircase. It takes <code>n</code> steps to reach the top.</p>
// Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
# include <algorithm>
# include <iterator>
# include <vector>
# include <iostream>
# include <cassert>
# include <unordered_map>


//     8     7     6     5     4     3     2     1
//     1     2     3     4     5     6     7     8
//     21    13    8     5     3     2     1     1
//
class Solution {
public:
    int calculate(int n) {
        int first = 1;
        int second = 1;
        int answer = 1;

        for (int i = 2; i < n; i ++) {
            answer = first + second;
            second = first;
            first = answer;
        }

        return answer;
    };


    typedef int t_result;
    typedef int t_input;
    t_result result;
    t_result expected;
    t_input in_val;

    void run(void) {
        in_val = 8;
        result = calculate(in_val);
    }
    void set_expect(void) {
        expected = 21;
        // int src[] = {8,7};
        // expected.assign(std::begin(src), std::end(src));
    }

    void test(void) {
        set_expect();
        run();
        std::cout << "Input: ";
        std::cout << in_val << std::endl;
        // for (const auto& i: in_val)
        //     std::cout << i << ' ';
        // std::cout << std::endl;

        std::cout << "Expected: ";
        std::cout << expected << std::endl;
        // for (const auto& i: expected)
        //     std::cout << i << ' ';
        // std::cout << std::endl;
        std::cout << "Result: ";
        std::cout << result << std::endl;

        // for (const auto& i: result)
        //     std::cout << i << ' ';
        // std::cout << std::endl;
    }
};


int main(int nargs, char** args) {
    std::cout << "-----" << std::endl;
    Solution code = Solution();
    code.test();
    std::cout << "-----" << std::endl;
    return 0;
}
