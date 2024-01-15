import os
import time
from googletrans import Translator

# Prompt 1
def getSettingMessage(age, gender, question_count) :
    settingMessage = f"""
        지금부터 당신(ChatGPT)은 인터뷰를 수행하는 기자입니다. 당신은 응답자에게 이어질 질문을 제시할 것입니다.

        제가 이전의 질문과 그에 대한 응답자의 응답을 제시하면, 당신은 응답자의 답변을 이해하고 다음에 이어질 질문을 제시할 것입니다.

        질문과 응답은 다음과 같은 형식으로 진행됩니다.
        1. 이전의 질문과 그에 대한 응답이 주어집니다.
        2. 이어지는 인터뷰에 사용할 수 있는 {question_count}가지의 질문을 당신이 제시합니다.

        다음 질문부터 당신의 응답은 아래의 부분을 어겨서는 안 됩니다.

        1. 당신의 대답에는 질문 {question_count}가지만이 들어있어야 합니다.
        2. 본문에 대한 응답이나 답변에 대한 설명등은 모두 배제되어야 합니다.
        3. 당신의 대답 형식은 아래와 같아야 합니다.
        4. 이미 본문에서 알 수 있는 내용에 대해 다시 묻지 않아야 합니다.
        ------------------------
        1. Question 1
        2. Question 2
        3. Question 3
        ...
        ------------------------

        당신이 인터뷰하고자 하는 대상은 """ + str(age) + "살 " + str(gender) + "입니다." + """

        잘 이해했다면 "이해했습니다" 라고 대답하고 저의 다음 질문을 기다려주세요
    """

    messages = []
    messages.append({
        "role" : "user",
        "content" : settingMessage
    })

    messages.append({
        "role" : "assistant",
        "content" : "이해했습니다. 다음 질문을 기다립니다."
    })

    return messages

# 데이터가 저장된 파일을 보고 promptNum, question_count, questions, answers, reponses를 돌려준다
def readFile(filePath) :
    # filePath에 존재하는 파일명을 이용하여 PromptNum, question_count 가져오기, 근데 안해도 될 듯?..
    promptNum = filePath.split("/")[-1][6:7]
    question_count = filePath.split("/")[-1][8:10]
    

    print(f"promptNum = {promptNum}, question_count = {question_count}")
    with open(filePath, 'r') as file :
        lines = file.readlines()
    
    # 질문, 응답이 시작되는 부분 찾기
    while True :
        if not ('Question :' in lines[0]) :
            del lines[0]
        else :
            break
    
    responses = []

    ### 이건 질문별로 따로 responses를 나눠주고 싶을 때 사용하면 됨.
    # questions = []
    # answers = []
    # num_Q = -1
    # for line in lines :
    #     if "Question" in line :
    #         questions.append(line.split("\n")[0].split(":")[-1])
    #         num_Q += 1
    #         responses.append([])
    #     elif "Answer" in line :
    #         answers.append(line.split("\n")[0].split(":")[-1])
    #     else :
    #         responses[num_Q].append(line.split("\n")[0])
    # return promptNum, question_count, questions, answers, responses

    ### 여기는 그냥 responses만 쭉 뽑을때 쓰기
    for line in lines :
        if "Question" in line :
            None
        elif "Answer" in line : 
            None
        elif line == "\n" :
            None
        else :
            responses.append(line.split("\n")[0])
    return promptNum, question_count, responses


def translate_list(questions) :
    # 번역기 생성
    translator = Translator()

    # lower과 upper이 다르다면 영어라는 것, 한국어로 번역하기
    if questions[0].lower() != questions[0].upper() :
        destination = 'ko'
    # 아니면 영어로 번역하기
    else :
        destination = 'en'
        

    # 번역 
    questions_eng = []
    for line in questions :
        # 쉬는시간 안주면 구글번역기가 뭐라고 함...
        time.sleep(1.0)
        # print(line)
        # 번역 실패하는 경우가 존재하는데, 코드가 멈추므로 일단 넘기기
        try :
            input_lan = translator.detect(line).lang
            result = translator.translate(line, src = input_lan, dest = destination)
            questions_eng.append(result.text)
        except :
            continue

    return questions_eng

def translate_str(question) :
    # 번역기 생성
    translator = Translator()

    # lower과 upper이 다르다면 영어라는 것, 한국어로 번역하기
    if question.lower() != question.upper() :
        destination = 'ko'
    # 아니면 영어로 번역하기
    else :
        destinatoin = 'en'
    
    # 번역 
    input_lan = translator.detect(question).lang
    return translator.translate(question, src = input_lan, dest = destination)