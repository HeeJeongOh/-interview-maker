# -*- coding: utf-8 -*-

import jaccard_eng
import functions
import use_gpt
import time
import sys

QUESTION_COUNT = 8
RETURN_COUNT = 3
# 0, 1, 2, 3으로 전달된 유저 나이를 대략적으로 판단하기 위함 
USERAGE_DICT = {
    '0' : 15,
    '1' : 30,
    '2' : 50,
    '3' : 70
}
USERGENDER_DICT = {
    '1' : "남성",
    '2' : "여성"
}

def mainFunction(args) :
    
    # ChatGPT를 통해 Question, Answer에 따른 결과를 불러옴
    # 혹시 글자수가 너무 커져서 4096 토큰을 넘어가면 오류가 날 수 있음
    # 그런 경우에는 16000개 토큰까지 처리 가능한 16K를 사용한다.
    question = args.q
    answer = args.a
    userAge = USERAGE_DICT[str(args.age)]
    userGender = USERGENDER_DICT[str(args.gender)]
    
    # startTime = time.time()
    responses = use_gpt.getAnswer(question, answer, userAge, userGender, QUESTION_COUNT)

    # print(f"답변을 받아오는 데에 소요된 시간 : {time.time() - startTime}")
    # middleTime = time.time()

    analyze_result = jaccard_eng.getSimilarity(responses)
    # print(f"분석 소요 시간 : {time.time() - middleTime}")

    analyze_result.sort(key = lambda x:x[1], reverse = True)

    return_values = []
    # 이상값이 존재할 수 있으니 이상값 제거하기(0번째)
    for i in range(1, 1 + RETURN_COUNT) :
        return_values.append(analyze_result[i])

    # print(f"총 소요 시간 : {time.time() - startTime}")

    return return_values


# # 그냥 출력부로 사용하는 부분
# question = "형제 자매들 중 몇 째로 태어났고, 그래서 좋았던 점과 싦었던 점은 무엇이었나요?"
# answer = "형제 자매 중 첫째였어요. 저는 첫째여서 자유로웠기 때문에 좋았고, 싫었던 점은 딱히 없는 것 같아요."
# userAge = 1
# userGender = 1

# returns = mainFunction(question, answer, userAge, userGender)
# for v in returns :
#     print(v)
import argparse

def parse_args():
    parser = argparse.ArgumentParser()
    # question, answer, userAge, userGender
    parser.add_argument("--q", default="질문", type=str)
    parser.add_argument("--a", default="답변", type=str)
    parser.add_argument("--age", default=-1, type=int)
    parser.add_argument("--gender", default=-1, type=int)
    args = parser.parse_args()

    return args

# 쉘에서 실행하기 위해 다 입력받는 형태로 수정했음
if __name__ == "__main__" :
#     returns = mainFunction(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
#     for v in returns :
#         print(v)
    args = parse_args()
    returns = mainFunction(args)
    for v in returns :
        print(f"{v[0]},{round(v[1] * 1000)}")