# include <algorithm>
# include <iterator>
# include <vector>
# include <iostream>
# include <cassert>
# include <unordered_map>


class Solution {
public:
    std::vector<int> result;
    std::vector<int> expected;
    std::vector<int> calculate(std::vector<int>& nums, int target) {
        std::vector<int> rval;
        std::unordered_map<int, int> hm;

        return rval;
    }

    void run(void) {
      std::vector<int> nums{1,2,3,4,5,6,7,8,9,10,11,12};
      int target = 17;
      result = calculate(nums, target);
    }
    void set_expect(void) {
      int src[] = {8,7};
      expected.assign(std::begin(src), std::end(src));
    }

    void test(void) {
        set_expect();
        run();

        std::cout << "Expected: ";
        for (const auto& i: expected)
            std::cout << i << ' ';
        std::cout << std::endl;
        std::cout << "Result: ";
        for (const auto& i: result)
            std::cout << i << ' ';
        std::cout << std::endl;
    }
};


int main(int nargs, char** args) {
    std::cout << "-----" << std::endl;
    Solution code = Solution();
    code.test();
    std::cout << "-----" << std::endl;
    return 0;
}
