// You are given an array of non-overlapping intervals <code>intervals</code>
// where <code>intervals[i] = [start<sub>i</sub>, end<sub>i</sub>]</code>
// represent the start and the end of the <code>i<sup>th</sup></code>
// interval and <code>intervals</code> is sorted in ascending order by
// <code>start<sub>i</sub></code>. You are also given an interval
// <code>newInterval = [start, end]</code> that represents the start and
// end of another interval.</p>


// Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
// Output: [[1,5],[6,9]]

// Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
// Output: [[1,2],[3,10],[12,16]]
// Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].


# include <algorithm>
# include <iterator>
# include <vector>
# include <iostream>
# include <cassert>
# include <unordered_map>


class Solution {
public:
    std::vector<std::vector<int> > calculate(std::vector<std::vector<int> >& intervals, std::vector<int>& newInterval) {
        std::vector<std::vector<int> > rval;

        int orig_idx = 0;
        int new_idx = 0;

        int orig_small = intervals[orig_idx][0];
        std::vector<int> n = newInterval;
        std::vector<int> tmp({0,0});
        int next_l;
        int next_h;

        for (auto c: intervals) {

            if (c[0] > n[0]){
                tmp[0] = n[0];

            }
            if (c[1] > n[1]){
                tmp[1] = n[1];
            }
            rval.push_back(tmp);
            printer(c[0]);
        }

        return rval;
    };


    typedef std::vector<std::vector<int> > t_result;
    typedef std::vector<std::vector<int> > t_input_1;
    typedef std::vector<int> t_input_2;
    t_result result;
    t_result expected;
    t_input_1 in_val_1;
    t_input_2 in_val_2;
    t_result& result_p = result;
    t_result& expected_p = expected;
    t_input_1& in_val_1_p = in_val_1;
    t_input_2& in_val_2_p = in_val_2;

    t_input_1& set_val_1(void) {
        t_input_1* val_1 = new t_input_1({{1, 3},{6, 9}});
        in_val_1_p = *val_1;
        return in_val_1_p;
    }
    t_input_2& set_val_2(void) {
        t_input_2* val_1 = new t_input_2({2, 5});
        in_val_2_p = *val_1;
        return in_val_2_p;
    }
    t_result& set_expected(void) {
        t_result* val_1 = new t_result({{1, 5},{6, 9}});
        expected_p = *val_1;
        return expected_p;
    }
    void run(void) {
        result = calculate(set_val_1(), set_val_2());
    }
    void test(void) {
        run();
        std::cout << std::endl << "Input: " << std::endl;
        printer(in_val_1);
        printer(in_val_2);
        std::cout << std::endl << "Expected: " << std::endl;
        printer(set_expected());
        std::cout << std::endl << "Result: " << std::endl;
        printer(result);
    }



    void printer(const std::vector<std::vector<int> >& print_val) {
        for (const auto& i: print_val)
            printer(i);
        std::cout << std::endl;
        return;
    }
    void printer(const std::vector<int>& print_val) {
        for (const auto& i: print_val)
            printer(i);
        std::cout << std::endl;
        return;
    }
    void printer(const int& print_val) {
        std::cout << print_val << " ";
        return;
    }
};


int main(int nargs, char** args) {
    std::cout << "-----" << std::endl;
    Solution code = Solution();
    code.test();
    std::cout << "-----" << std::endl;
    return 0;
}
