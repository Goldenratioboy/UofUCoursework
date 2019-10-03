import sys

bstTrees = set()

#Node Class to help represent a binary search tree
class Node:
    def __init__(self, key):
        self.left = None
        self.right = None
        self.val = key


#Inserts a Node into a BST
def insertIntoTree(root,Node):
    if root is None:
        root = Node
    else:
        if root.val < Node.val:
            if root.right is None:
                root.right = Node
            else:
                insertIntoTree(root.right, Node)

        else:
            if root.left is None:
                root.left = Node
            else:
                insertIntoTree(root.left, Node)

def printTree(root): #Helper method to print out the values of BST in order. Make sure we're building them correctly
    if root:
        printTree(root.left)
        print(root.val)
        printTree(root.right)

def compareTree(a, b): # Takes in two trees and compares them one node at a time
    if a is None and b is None:
        return True
    
    if a is not None and b is not None:
        return compareTree(a.left, b.left) and compareTree(a.right, b.right)

    return False

#Read first line to get params
params = sys.stdin.readline().split()
n = int(params[0]) #Number of celing prototypes
k = int(params[1]) #Number of Nodes per tree

#could add check here to print 1 if k is 1, because that means we have a bunch of 1 node trees

#Create our BSTs
for i in sys.stdin:
    potentialNodes = i.split() # leave as strings for now? Can compare with ASCII for BST placement.
    root = Node(int(potentialNodes[0]))
    
    for x in range(1,k): #skip over first iteration since root is assigned
        insertIntoTree(root, Node(int(potentialNodes[x])))
        #print(potentialNodes[x])
    
    #After creating a tree we'll compare it with our list of unique trees
    #Unfortunately we'll have to compare this to every tree in the list
    result = False
    for t in bstTrees:
        result = compareTree(t, root)
        if result is True:
            break

    if result is False: #If result is false that means we found no similar tree structures
        bstTrees.add(root)
    
print(len(bstTrees))
