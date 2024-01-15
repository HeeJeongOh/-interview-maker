import os
import re
import pickle
import functions

basePath = os.path.dirname(__file__)
folderPath = os.path.join(basePath, "jaccard_eng")
filePath = os.path.join(folderPath, "jaccard_eng_tokenized.pkl")

# List를 특수문자 제거하고 토큰화한다
def tokenizer(inputs) :
    results = []
    for input in inputs :
        tmp = re.sub("[^\w\s\d]", "", input)
        results.append(tmp.split())
    return results
        
def loadData() :
    try :
        with open(filePath, 'rb') as file :
            results = pickle.load(file)
        # print(f"Jaccard_eng 파일 불러오기 완료")

        return results
    except :
        # print(f"Jaccard_eng 파일 올바르지 않음, 재생성")
        questionFilePath = os.path.join(basePath, "question_list_eng.txt")
        questions = []

        # 질문지 파일 읽어오기
        with open(questionFilePath, 'r', encoding = 'utf-8') as file :
            lines = file.readlines()
        
        # 질문들을 배열에 넣기, 
        questions = []
        for line in lines :
            questions.append(line.split("\n")[0])

        # 토큰화해서 저장하기
        results = tokenizer(questions)

        with open(filePath, 'wb') as file :
            pickle.dump(results, file)

        # print("Jaccard_eng 생성 완료")

        return results

def getSimilarity(sentenses) :
    # 들어온 데이터 번역하기
    sentenses_eng = functions.translate_list(sentenses)

    # 데이터 불러오기
    results_data = loadData()

    # 불러온 데이터 형태소 가공하기
    results_input = tokenizer(sentenses_eng)
    jaccard_val_results = []
    for i, input in enumerate(results_input) :
        sum = 0
        for data in results_data :
            # 자카드 유사도는 합집합 대 교집합의 비율 구하는 것. 합집합, 교집합 구하기
            union_val = set(data).union(set(input))
            intersection_val = set(data).intersection(set(input))

            # 자카드 유사도 구하기
            jaccard_val = len(intersection_val) / len(union_val)
            sum += jaccard_val
            # print(f"{input} 과 {data} 의 비교 결과")
            # print(f"Union : {union_val}, Intersection : {intersection_val}")
            # print(f"자카드 유사도 : {sum / len(results_data)}")

        jaccard_val_results.append([sentenses[i], sum / len(results_data)])
    
    return jaccard_val_results