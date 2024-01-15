package com.safari.back_spring.entity;

import com.safari.back_spring.model.Generated;
import jakarta.persistence.*;

@Entity
public class GeneratedEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int gid;

    // foreign key
    private int bid;
    private String question;

    private long score;

    public GeneratedEntity() {
    }

    public GeneratedEntity(Generated generated) {
        this.bid = generated.getBid();
        this.question = generated.getQuestion();
        this.score = generated.getScore();
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setScore(long score) {
        this.score = score;
    }
}
