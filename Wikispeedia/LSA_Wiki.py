from mechanize import Browser
import pandas as pd
import numpy as np


def init(word) :
    br = Browser()
    br.open('http://lsa.colorado.edu/cgi-bin/LSA-select.html')
    br.select_form(nr=0)
    br["LSAFactors"] = "300"
    br["LSAspace"] = ["General_Reading_up_to_1st_year_college 	 (300 factors)"]
    br["LSATermCnt"] = ["10"]
    br["CmpType"] = ["doc"]
    br["txt1"] = word
    return br


if __name__ == '__main__':
    lines = list()
    with open('/home/nvedansh/IITM/SEM-2/NLP/Project/wikispeedia_paths-and-graph/paths_finished.tsv') as f:
        for line in f:
            lines.append(line.split('\t'))

    all_nodes = set()
    paths = list()
    for line in lines:
        nodes = line[3].split(';')
        all_nodes.add(nodes[-1])

    all_nodes = list(all_nodes)

    results = {}
    count = 0
    for word in all_nodes:
        br = init(word)
        br.submit()
        try:
            df = pd.read_html(br.response().read(), header=0)
        except ValueError:
            continue
        br.response().close()
        results[word] = df[0]['Term'].tolist()
        count += 1
        print(count, word, results[word])

    del br

    np.save("/home/nvedansh/IITM/SEM-2/NLP/Project/dictionary.npy", results)