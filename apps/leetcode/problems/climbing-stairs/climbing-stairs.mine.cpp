// You are climbing a staircase. It takes <code>n</code> steps to reach the top.</p>
// Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
# include <algorithm>
# include <iterator>
# include <vector>
# include <iostream>
# include <cassert>
# include <unordered_map>

//                       p1=100  *1   = 100
// xxxxxxxxxxxxxxxxxxxxx x        1


//                           *3      *2      *1       *1       = p3 * 2 + p3 * 1
//                           r=3     r=2     r=1      r=0
//                           p3=25   p2=50   p1=100   p0=100   = p2 * 1 + p2 * 1 = 50
// xxxxxxxxxxxxxxxx   x   x  x       x       x        x


class Solution {
public:
    int calculate(int n) {
        std::unordered_map<int, int> hm;
        hm[0] = 1;
        hm[1] = 1;
        for (int i = 2; i <= n; ++i) {
            hm[i] = hm[i-1] + hm[i-2];
            std::cout << hm[i] << std::endl; //
        }

        return hm[n];
    };



    typedef int t_result;
    typedef int t_input;
    t_result result;
    t_result expected;
    t_input in_val;

    void run(void) {
        in_val = 3;
        result = calculate(in_val);
    }
    void set_expect(void) {
        expected = 3;
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
