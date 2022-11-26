#!/usr/bin/env python3
# https://leetcode.com/problems/reverse-linked-list

# Given the head of a singly linked list, reverse the list, and return the reversed list.




import dataclasses
from dataclasses import dataclass
from typing import Generator, NewType

if(False): print(dataclasses)


# Definition for singly-linked list.
class ListNode(object):
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
        self.pointer = self
    def __iter__(self):
        return self
    def __next__(self):
        if self.pointer.next:
            self.pointer = self.pointer.next
            return self.pointer
        else:
            raise StopIteration
    def __str__(self):
        return str(f"{self.val}->{self.next}")

# ---- <IMPLEMENT> -------------------------------------
# outputType = NewType('outputType', List[List[int]])
outputType = NewType('outputType', ListNode)
@dataclass
class In:
    # ---- <IMPLEMENT> -------------------------------------
    head: ListNode
    # newInterval: List[List[int]]
    def __iter__(self):
        iter(dataclass.astuple(self))

@dataclass
class TestCases:
    _in: In
    _out: outputType

################################################################################

# ---- <IMPLEMENT> -------------------------------------
class Solution(object):
    def reverseList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        previous = None
        while(head):
            item = head
            head = head.next
            item.next = previous
            previous = item
        print(previous)

################################################################################
    # ---- <IMPLEMENT> -------------------------------------
    def __init__(self) -> None:
        """Have a common way to reference the solution function"""
        self.solve = self.reverseList

    def get_tests(self) -> Generator[TestCases, None, None]:
        """return all of the given test cases"""
        # ---- <IMPLEMENT> -------------------------------------
        items = [
            ListNode(val=10,next=None),
            ListNode(val=20,next=None),
            ListNode(val=30,next=None),
            ListNode(val=40,next=None),
            ListNode(val=50,next=None),
            ListNode(val=60,next=None),
        ]
        prev = None
        for item in items:
            item.next = prev
            prev = item
            # print(item)

        e_items = [
            ListNode(val=10,next=None),
        ]
        ListNode(val=1,next=None)
        test_cases = [
            TestCases(
                _in=In( head = items[5]),
                _out=e_items[0]
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
