package com.safari.back_spring;

import com.safari.back_spring.entity.BaseEntity;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.BufferedReader;
import java.io.FileReader;

@SpringBootApplication
public class BackSpringApplication {

    public static void main(String[] args) {
        SpringApplication.run(BackSpringApplication.class, args);

        String csvFilePath = "src/data/based_data.csv";
        try {
            BufferedReader lineReader = new BufferedReader(new FileReader(csvFilePath));
            CSVParser records = CSVParser.parse(lineReader, CSVFormat.EXCEL.withFirstRecordAsHeader().withIgnoreHeaderCase().withTrim());

            SessionFactory factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(BaseEntity.class).buildSessionFactory();

            Session session = factory.openSession();
            session.beginTransaction();

            for (CSVRecord record : records) {
                BaseEntity base = new BaseEntity();
                base.setBid(Integer.parseInt(record.get(0)));
                base.setCycle(Integer.parseInt(record.get(1)));
                base.setGender(Integer.parseInt(record.get(2)));
                base.setQuestion(record.get(3));
                session.save(base);
            }
            session.getTransaction().commit();
        }catch(Exception e){
        e.printStackTrace();
        }
    }
}
