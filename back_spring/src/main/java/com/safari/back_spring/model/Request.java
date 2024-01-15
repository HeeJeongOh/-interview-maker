package com.safari.back_spring.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Request {
    int user_cycle;
    int user_gender;
    int bid;
    String question;
    String answer;


    public Request() {
    }

    public int getUser_cycle() {
        return user_cycle;
    }

    public void setUser_cycle(int user_cycle) {
        this.user_cycle = user_cycle;
    }

    public int getUser_gender() {
        return user_gender;
    }

    public void setUser_gender(int user_gender) {
        this.user_gender = user_gender;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
