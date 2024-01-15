package com.safari.back_spring.service;


import com.safari.back_spring.entity.BaseEntity;
import com.safari.back_spring.entity.GeneratedEntity;
import com.safari.back_spring.model.Base;
import com.safari.back_spring.model.Generated;
import com.safari.back_spring.model.Request;
import com.safari.back_spring.repository.GeneratedRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Service
public class GeneratedService {
    @Autowired
    GeneratedRepository generatedRepository;

    public List<Generated> getGeneratedQuestion(Request request){
        List<Generated> sample = new ArrayList<>();
        try {
            String os = System.getProperty("os.name");
            System.out.println("Operating System: " + os);

            ProcessBuilder pb;
            if (os.contains("Windows")) {
                // @@@@ 실행 환경 Windows일 경우에 사용
                // 파이썬 파일의 경로 설정
                String serviceFolderPath = "src\\data\\serviceFolder\\main.py";
                String argvs = "--q='" + request.getQuestion() + "' --a='" + request.getAnswer() + "' --age=" + request.getUser_cycle() + " --gender=" + request.getUser_gender();
                System.out.println("python " + serviceFolderPath + " " + argvs);

                // ProcessBuilder를 통해 커맨드창에서 필요한 명령어를 수행할 것
                pb = new ProcessBuilder("powershell", "python", serviceFolderPath, argvs);
                pb.redirectErrorStream(true);
            }

            // @@@@ 실행 환경 MAC일 경우에 사용
            else {
                // 파이썬 파일의 경로 설정
                String serviceFolderPath = "src/data/serviceFolder/";
                String argvs = "--q='" + request.getQuestion() + "' --a='" + request.getAnswer() + "' --age=" + request.getUser_cycle() + " --gender=" + request.getUser_gender();
                
                /// Anaconda와 함께 사용할 경우 사용
                /// Anaconda와 함께 사용할 때, Activate가 올바르지 않은 경로라고 나오면 직접 로컬에서 어디있는지 찾아내야 함
                String activateEnvCommand = "source /opt/homebrew/anaconda3/bin/activate interview_question_maker && python " + serviceFolderPath + "main.py " + argvs;

                /// 그냥 활용할 때 사용. 기준은 Python 3.9.13임
                // String activateEnvCommand = "python3 " + serviceFolderPath + "main.py " + argvs;
                System.out.println(activateEnvCommand);
                // ProcessBuilder를 통해 커맨드창에서 필요한 명령어를 수행할 것
                // 맥에서는 리눅스와 같음
                pb = new ProcessBuilder("/bin/zsh","-c", activateEnvCommand);
                pb.redirectErrorStream(true);
            }

            // 프로세스 시작
            Process process = pb.start();

            // 프로세스에서의 출력을 읽기 위해서는 BufferedReader가 필요하다
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;

            // reader의 모든 내용을 읽기
            while ((line = reader.readLine()) != null) {
                String[] tmp = line.split(",");
                if (tmp.length != 2) {
                    System.out.println("길이가 2가 되지 않는 문자열 : " + tmp[0]);
                    continue;
                }
                Generated g = new Generated();
                g.setBid(request.getBid());
                g.setQuestion(tmp[0]);
                g.setScore(Integer.parseInt(tmp[1]));

                System.out.println(g.toString());
                sample.add(g);
                addGeneration(new GeneratedEntity(g));
            }

            // 프로세스 종료까지 기다리기
            int exitCode = process.waitFor();
            System.out.println("Exited with code " + exitCode);
            return sample;
        } catch (IOException | InterruptedException e) {
            // 입력 오류 혹은 유저의 종료 오류 캐치하기
            e.printStackTrace();
            return sample;
        }

            /*
            request = {
                "user_cycle": 0,
                "user_gender": 0,
                "bid": 0,
                "question": "반가워요",
                "answer": "안녕하세요"
            }

            1. GPT로부터 답변 얻어오기

            2. generations에 삽입하기

            List<GeneratedEntity> generations = generatedRepository.findAll();
            List<Generated> requestedGenerations = new ArrayList<>();
            generations.stream().forEach(e -> {
                Generated generated = new Generated();
                BeanUtils.copyProperties(e, generated);
                requestedGenerations.add(generated);
            });
            return requestedGenerations;
            */
    }

    public String addGeneration(GeneratedEntity generatedEntity){
        try{
            generatedRepository.save(generatedEntity);
            return "Added Successfully";
        }catch(Exception e){
            throw e;
        }
    }
//
//    public String deleteGeneration(GeneratedEntity generatedEntity){
//        try{
//            if(!generatedRepository.existsById(generatedEntity.getBid())){
//                generatedRepository.delete(generatedEntity);
//                return "Deleted Successfully";
//            }
//            else{
//                return "Does NOT Exists";
//            }
//        }catch(Exception e){
//            throw e;
//        }
//    }
//
//
//    public String updateGeneration(GeneratedEntity generatedEntity){
//        try{
//            if(!generatedRepository.existsById(generatedEntity.getBid())){
//                generatedRepository.save(generatedEntity);
//                return "Updated Successfully";
//            }
//            else{
//                return "Does NOT Exists";
//            }
//        }catch(Exception e){
//            throw e;
//        }
//    }

}
