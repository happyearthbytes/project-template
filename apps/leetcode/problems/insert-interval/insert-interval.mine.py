#!/usr/bin/env python3
# https://leetcode.com/problems/insert-interval


# You are given an array of non-overlapping intervals <code>intervals</code>
# where <code>intervals[i] = [start<sub>i</sub>, end<sub>i</sub>]</code>
# represent the start and the end of the <code>i<sup>th</sup></code>
# interval and <code>intervals</code> is sorted in ascending order by
# <code>start<sub>i</sub></code>. You are also given an interval
# <code>newInterval = [start, end]</code> that represents the start and
# end of another interval.</p>

# Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
# Output: [[1,5],[6,9]]

# Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
# Output: [[1,2],[3,10],[12,16]]
# Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].

import dataclasses
from dataclasses import dataclass
from typing import Generator, List, NewType

# ---- <IMPLEMENT> -------------------------------------
intervalsType = NewType('intervalsType', List[List[int]])
newIntervalType = NewType('newIntervalType', List[List[int]])

# ---- <IMPLEMENT> -------------------------------------
outputType = NewType('outputType', List[List[int]])
@dataclass
class In:
    # ---- <IMPLEMENT> -------------------------------------
    intervals: intervalsType
    newInterval: newIntervalType
    def __iter__(self):
        iter(dataclass.astuple(self))

@dataclass
class TestCases:
    _in: In
    _out: outputType


################################################################################

# ---- <IMPLEMENT> -------------------------------------
class Solution(object):
    def insert(self, intervals, newInterval):
        """
        :type intervals: List[List[int]]
        :type newInterval: List[int]
        :rtype: List[List[int]]
        """
        # return on malformed inputs
        if not intervals:
            return newInterval
        if not newInterval:
            return intervals

        # declare variables
        combined = []
        # start by defining the new value as just the given interval
        new_val = newInterval
        index = 1

        for interval in intervals:
            # skip over any malformed items
            if not interval: continue
            # if the updated interval is below the next one, we are done.
            if new_val[1] + 1 < interval[0]:
                index -= 1
                break
            index += 1
            # if our search point is too low, add it to the list, and keep looking
            if new_val[0] > interval[1] + 1:
                combined.append(interval)
                continue
            # expand our updated interval
            new_val[0] = min(new_val[0],interval[0])
            new_val[1] = max(new_val[1],interval[1])

        # now we apply the updated interval that we found
        combined.append(new_val)
        # and any other items in the interval to the right
        combined.extend(intervals[index:])
        return combined






# test.input=InputType(
# intervals=[[1, 2], [3, 5], [6, 7], [8, 10], [12, 16]],
# newInterval=[4, 8])


################################################################################
    def __init__(self) -> None:
        """Have a common way to reference the solution function"""
        # ---- <IMPLEMENT> -------------------------------------
        self.solve = self.insert

    def get_tests(self) -> Generator[TestCases, None, None]:
        """return all of the given test cases"""
        # ---- <IMPLEMENT> -------------------------------------
        test_cases = [
            TestCases(
                _in=In(
                    intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]],
                    newInterval = [4,8]),
                _out=outputType([[1,2],[3,10],[12,16]])
            ),
            TestCases(
                _in=In(
                    intervals = [[4,5],[7,8]],
                    newInterval = [1,2]),
                _out=outputType([[1,2],[4,5],[7,8]])
            ),
            TestCases(
                _in=In(
                    intervals = [[1,2],[7,8]],
                    newInterval = [4,5]),
                _out=outputType([[1,2],[4,5],[7,8]])
            ),
            TestCases(
                _in=In(
                    intervals = [[1,3],[7,8]],
                    newInterval = [2,5]),
                _out=outputType([[1,5],[7,8]])
            ),
            TestCases(
                _in=In(
                    intervals = [[1,3],[7,8]],
                    newInterval = [3,7]),
                _out=outputType([[1,8]])
            ),
            TestCases(
                _in=In(
                    intervals = [[1,3],[7,8]],
                    newInterval = [10,12]),
                _out=outputType([[1,3],[7,8], [10,12]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [9,11]),
                _out=outputType([[5,7],[9,11]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [1,3]),
                _out=outputType([[1,3],[5,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [1,4]),
                _out=outputType([[1,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [1,5]),
                _out=outputType([[1,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [1,6]),
                _out=outputType([[1,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [1,7]),
                _out=outputType([[1,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [1,8]),
                _out=outputType([[1,8]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [4,8]),
                _out=outputType([[4,8]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [5,9]),
                _out=outputType([[5,9]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [6,9]),
                _out=outputType([[5,9]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [7,9]),
                _out=outputType([[5,9]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = [5,7]),
                _out=outputType([[5,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[]],
                    newInterval = [5,7]),
                _out=outputType([[5,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[5,7]],
                    newInterval = []),
                _out=outputType([[5,7]])
            ),
            TestCases(
                _in=In(
                    intervals = [[]],
                    newInterval = []),
                _out=outputType([[]])
            ),
        ]
        for test in test_cases:
            yield test

    def run_testcases(self) -> None:
        """run all of the test cases on the given function instance"""
        print(f"\n{'='*40}")
        verbose = False
        for i, expect in enumerate(self.get_tests()):
            passes = False
            actual = self.solve(**dataclasses.asdict(expect._in))
            if actual == expect._out:
                passes = True
            pass_str = "PASS" if passes else "FAIL"
            if verbose or not passes:
                print(f"{i:2}: {pass_str}; {expect._in=}; {expect._out=}; {actual=}")
            else:
                print(f"{i:2}: {pass_str}")

        print(f"{'='*40}")



################################################################################


if __name__ == "__main__":
    solution = Solution()
    solution.run_testcases()
