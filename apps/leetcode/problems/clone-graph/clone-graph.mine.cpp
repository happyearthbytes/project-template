//  Given a reference of a node in a connected undirected graph.
// Return a deep copy (clone) of the graph.
// Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.
// class Node {
//     public int val;
//     public List<Node> neighbors;
// }

# include <algorithm>
# include <iterator>
# include <vector>
# include <iostream>
# include <cassert>
# include <unordered_map>


// Definition for a Node.
class Node {
public:
    int val;
    std::vector<Node*> neighbors;
    Node() {
        val = 0;
        neighbors = std::vector<Node*>();
    }
    void print() {
      std::cout << val << ": ";
      for (Node* n : neighbors) {
        std::cout << n << " ";
      }
      std::cout << std::endl;

    }
    Node(int _val) {
        val = _val;
        neighbors = std::vector<Node*>();
    }
    Node(int _val, std::vector<Node*> _neighbors) {
        val = _val;
        neighbors = _neighbors;
    }
};


// n0 - n1, n2
// n1 - n5
// n2 - n0, n3, n4
// n3
// n4 - n5
// n5

class Solution {
public:
    std::unordered_map<int, Node*> hm;
    Node* calculate(Node* node) {
        if ( node == NULL ) return NULL;
        if ( hm.count(node->val) ) return hm[node->val];
        Node* new_copy = new Node();
        hm[node->val] = new_copy;
        new_copy->val = node->val;
        for (Node* n : node->neighbors) {
            new_copy->neighbors.push_back(calculate(n));
        }
        return new_copy;
    }

    typedef Node* t_result;
    typedef Node* t_input;
    t_result result;
    t_result expected;
    t_input in_val;

    void run(void) {
        Node in_val[] = {Node(2),Node(4),Node(6),Node(8),Node(7),Node(5)};
        std::vector<Node*> other1{&in_val[1]};
        std::vector<Node*> other3{&in_val[2], &in_val[3]};
        std::vector<Node*> other2{other1};
        in_val[0].neighbors = other2;
        in_val[1].neighbors = other3;

        result = calculate(in_val);
    }
    void set_expect(void) {
        Node expected = Node();
        // int src[] = {8,7};
        // expected.assign(std::begin(src), std::end(src));
    }

    void test(void) {
        set_expect();
        run();
        std::cout << "Input: ";
        // std::cout << in_val << std::endl;

        // for (const auto& i: in_val)
        //     std::cout << i << ' ';
        // std::cout << std::endl;

        std::cout << "Expected: ";
        // std::cout << expected << std::endl;

        // for (const auto& i: expected)
        //     std::cout << i << ' ';
        // std::cout << std::endl;

        std::cout << "Result: ";

        std::cout << result->val << std::endl;

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
