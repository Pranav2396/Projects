import networkx as nx
import numpy as np

G = nx.DiGraph()
lines = list()
with open('/home/nvedansh/IITM/SEM-2/NLP/Project/wikispeedia_paths-and-graph/paths_finished.tsv') as f:
    for line in f:
        lines.append(line.split('\t'))

# with open('/home/nvedansh/IITM/SEM-2/NLP/Project/wikispeedia_paths-and-graph/paths_unfinished.tsv') as f:
#     for line in f:
#         lines.append(line.split('\t'))

all_nodes = set()
paths = list()
for line in lines:
    nodes = line[3].split(';')
    for i in nodes:
        all_nodes.add(i)
    paths.append(nodes)

all_nodes.remove('<')
G.add_nodes_from(list(all_nodes))

edges = list()
for path in paths:
    index = 0
    while index < len(path) - 1:
        if path[index + 1] == '<':
            path.pop(index)
            path.pop(index)
            index -= 1
            continue
        edges.append((path[index], path[index + 1]))
        index += 1

for edge in edges:
    G.add_edge(edge[0], edge[1])

pr = nx.pagerank(G)
output = []
for nodes in all_nodes:
    output.append([nodes, -np.log2(pr[nodes])])


with open('/home/nvedansh/IITM/SEM-2/NLP/Project/pagerank.txt', 'w') as file:
    file.writelines('\t'.join(str(j) for j in i) + '\n' for i in output)

