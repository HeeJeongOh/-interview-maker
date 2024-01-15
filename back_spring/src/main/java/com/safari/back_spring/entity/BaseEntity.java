package com.safari.back_spring.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "base_entity")
public class BaseEntity {
    @Id
    @Column(name = "bid")
    private int bid;
    @Column(name = "gender")
    private int gender;

    @Column(name = "cycle")
    private int cycle;

    @Column(name = "question")
    private String question;

    public BaseEntity() {
    }

    public int getBid() {
        return bid;
    }

    public int getGender() {
        return gender;
    }


    public int getCycle() {
        return cycle;
    }

    public String getQuestion() {
        return question;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public void setCycle(int cycle) {
        this.cycle = cycle;
    }

    public void setQuestion(String question) {
        this.question = question;
    }
}