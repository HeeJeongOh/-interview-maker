import openai
import functions
from functions import getSettingMessage

# API-KEY
openai.api_key = ''

# messages에 user의 말을 전해주는 역할
def messagesAppender(target, str) :
    target.append({
        "role": "user",
        "content": str
    })
    
    return target

# User가 마지막인 Messages를 제공하면, 수정된 Messages와 Chat_response를 제공한다.
def getResponseFromGPT(messages) :
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages = messages,

        temperature=0.5,
        max_tokens=1000,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )

    chat_response = response.choices[0].message.content
    return chat_response

# 글자수 제한에 걸리는 상황 회피를 위해 16K 사용
def getResponseFromGPT_16K(messages) :
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo-16k",
        messages = messages,

        temperature=0.5,
        max_tokens=1000,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0
    )

    chat_response = response.choices[0].message.content
    return chat_response

# 실제 chatgpt에게 question_count개의 답변을 받아온다
def getAnswer(question, answer, userAge, userGender, question_count) :
    # 처음 메세지를 전달한 상황이라면, 세팅메세지를 먼저 주고 그 다음 질문 답변을 제시해야 함.
    messages = getSettingMessage(userAge, userGender, question_count)

    # 이후 그대로 질문, 답변 전달하기
    user_qa = "Question : " + question + "\n" + "Answer : " + answer
    messagesAppender(messages, user_qa)
    try :
        chat_response = getResponseFromGPT(messages)
    except :
        # 4096토큰을 초과하면 오류 날 수 있음. 수정
        chat_response = getResponseFromGPT_16K(messages)

    responses_kor = []
    for v in chat_response.split("\n") :
        # 대답 처리 과정에서 오류가 생기면 그냥 하나 넘기고 처리하기.
        try :
            # 1. 의 형식으로 대답을 할 때도 있고, Question 1: 의 형식으로 답을 줄 때도 있어서 두 가지 경우 모두 고려하여 제거해주기
            if (":" in v ) :
                tmp = v.split(":")[1][1:]
                # 결과를 영어로 줄 때도 있음! 이런 경우에는 한국어로 번역하기
                if tmp.lower() != tmp.upper() :
                    tmp = functions.translate_str(tmp)

                # 한글로 번역한 결과를 추가해주기 
                responses_kor.append(tmp)
            else :
                tmp = v.split(".")[1][1:]
                # 결과를 영어로 줄 때도 있음! 이런 경우에는 한국어로 번역하기
                if tmp.lower() != tmp.upper() :
                    tmp = functions.translate_str(tmp)

                # 한글로 번역한 결과를 추가해주기
                responses_kor.append(tmp)
        except Exception as e:
            print(e)
            continue
        
    return responses_kor
