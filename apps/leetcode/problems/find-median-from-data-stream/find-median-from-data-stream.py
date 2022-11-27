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

from typing import Any

level = 0
indent = "  "
right_indent = "-"*80
last_output={}
def print_self(func):
    def wrapper(self,*args,**kwargs) -> Any:
        global level
        def print_self() -> None:
            global last_output
            this_output=str(self)
            if this_output == last_output.get(func.__name__):
                return
            last_output[func.__name__] = this_output
            print(f"{right_indent} {this_output}")
        print_self()
        print(f"{indent*level}{func.__name__}({args},{kwargs})"" {")
        level += 1
        rval = func(self,*args,**kwargs)
        level -= 1
        print(f"{indent*level}"'}'f" -> {rval}")
        print_self()
        return rval
    return wrapper

class Heap:
    def __init__(self) -> None:
        print()
        self.h = list()
        self.count = 0

    @print_self
    def push(self, value: int) -> None:
        rval = self.update(value,0)
        self.count += 1
        return rval

    @print_self
    def get(self, idx: int) -> int:
        self.h[idx], self.h[-1] = self.h[-1], self.h[idx]
        rval = self.h.pop()
        self.update(value=self.h[idx],index=idx)
        self.count -= 1
        return rval

    @print_self
    def update(self, value: int, index: int, round: int = 0) -> None:
        if index + 1 >= self.count:
            self.h.append(value)
            return value
        bigger,smaller = value,self.h[index]
        if smaller > bigger:
            bigger,smaller = smaller,bigger
        self.h[index] = smaller
        offset= (( (self.count + 1)>>round ) & 1)
        print(offset)
        return self.update(value=bigger,index=index*2+1+offset, round = round - 1)

    def __str__(self) -> str:
        rval = str(f"({self.count}) {self.h}\n")
        width = 1
        count = 1
        power_count = 0
        import math
        while math.pow(2,power_count) < self.count:
            power_count += 1
        power_count = math.pow(2,power_count)

        for val in self.h:
            rval += f"{val:^{int(power_count/width)*2}}"
            if count == width:
                rval += "\n"
                width *= 2
                count = 1
            else:
                count += 1
        rval +="\n"
        return rval

if __name__ == "__main__":
    # solution = Solution()
    # solution.run_testcases()
    h = Heap()
    for i in range(2,5):
        h.push(i**2)
        h.push(i)
        h.push(-i)
        h.push(i+1)
        h.push(2*i)

    for i in range(2,5):
        h.get(i*2)
    # print("====")
    # print([j*5+i for j in range(3) for i in range(5)])