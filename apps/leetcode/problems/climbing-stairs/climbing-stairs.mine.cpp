// You are climbing a staircase. It takes <code>n</code> steps to reach the top.</p>
// Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
# include <algorithm>
# include <iterator>
# include <vector>
# include <iostream>
# include <cassert>
# include <unordered_map>

class Solution {
public:
    int calculate(int n) {
        return 1;
    };

    typedef int t_result;
    typedef int t_input;
    t_result result;
    t_result expected;

    void run(void) {
        t_input in_val = 5;
        result = calculate(in_val);
    }
    void set_expect(void) {
        expected = 10;
        // int src[] = {8,7};
        // expected.assign(std::begin(src), std::end(src));
    }

    void test(void) {
        set_expect();
        run();
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
