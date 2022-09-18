pragma solidity ^0.8.9;

contract SemanticGraph {

        // different types of edge
        bytes32 constant IS_TYPE_OF = "semantic.edge.isTypeOf";
        bytes32 constant IS_PART_OF = "semantic.edge.isPartOf";
        bytes32 constant HAS_ATTRIBUTE = "semantic.edge.hasAttribute";
        bytes32 constant HAS_ID = "semantic.edge.has_ID";
        bytes32 constant HAS_NAME = "semantic.node.hasName";

        // different types of node
        bytes32 constant PFP = "semantic.node.pfp";
        bytes32 constant COLLECTION = "semantic.node.collection";

        // the semantic graph with edges as triples (node, node, edge)
        mapping(bytes32 => mapping(bytes32 => bytes32)) graph;

        // the neighboring nodes of a node
        mapping(bytes32 => bytes32[]) neighbors;

        // update an edge 
        function update(bytes32 from, bytes32 relationship, bytes32 to) public {
                if (graph[from][to] == "") {
                        neighbors[from].push(to);
                }
                graph[from][to] = relationship;
        }

        // IS_TYPE_OF inference 
        function isTypeOf(bytes32 node, bytes32 theType) public returns (bool) {
                for (uint256 i = 0; i < neighbors[node].length; i++) {
                        bytes32 neighbor = neighbors[node][i];
                        bytes32 edge = graph[node][neighbor];
                        if (edge == IS_TYPE_OF) {
                                if (neighbor == theType ) {
                                        return true;
                                } else {
                                        return isTypeOf(neighbor, theType);
                                }
                        }
                }
                return false;
        }

        function prototype() public {

                // add edges
                update("BAYC 1356", HAS_ID, "1356");
                update("BAYC 1356", IS_TYPE_OF, PFP);
                update("BAYC 1356", IS_PART_OF, "BAYC");
                update("BAYC", HAS_NAME, "BAYC");
                update("BAYC", IS_TYPE_OF, COLLECTION);

                // inference
                isTypeOf("Punk 7407", "semantic.node.propeller_hat");

        }

}
