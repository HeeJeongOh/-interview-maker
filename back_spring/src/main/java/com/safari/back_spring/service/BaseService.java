package com.safari.back_spring.service;

import com.safari.back_spring.model.Base;
import com.safari.back_spring.entity.BaseEntity;
import com.safari.back_spring.repository.BaseRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class BaseService {
    @Autowired
    BaseRepository baseRepository;

    public Base getBaseQuestion(int gender, int cycle){
        try{
            // BaseEntity는 Database의 테이블을 의미. findAll은 모든 원소를 가져오는 것
            // Database의 BaseEntity 테이블에서 모든 원소를 가져와 bases에 저장
            List<BaseEntity> bases = baseRepository.findAll();
            // Base는 정보를 담을 객체. requestsedBases는 현재 gender, cycle을 고려하여 요청 가능한 질문 리스트
            List<Base> requestedBases = new ArrayList<>();
            // bases 기반 for문
            bases.stream().forEach(e -> {
                if ((e.getGender() == gender || e.getGender() == 0) && e.getCycle() == cycle){
                    Base base = new Base();
                    BeanUtils.copyProperties(e, base);
                    requestedBases.add(base);
                }
            });
            // requetedBases에서 랜덤한 원소 하나를 가져와서 리턴한다.
            return requestedBases.get(new Random().nextInt(requestedBases.size()));
        }catch (Exception e){throw e;
        }
    }

    // 새 BaseEntity(기본질문)을 추가하는 함수
    public String addBase(BaseEntity baseEntity){
        try{
            // ID(Primary Key)가 중복되는지 확인하고, 없다면 save한다.
            if(!baseRepository.existsById(baseEntity.getBid())){
                baseRepository.save(baseEntity);
                return "Added Successfully";
            }
            else{
                return "Already Exists";
            }
        }catch(Exception e){
            throw e;
        }
    }

    // BaseEntity를 제거하는 함수
    public String deleteBase(BaseEntity baseEntity){
        try{
            // 해당 ID를 가지는 질문이 존재하는지 확인하고, 존재한다면 삭제한다
            if(baseRepository.existsById(baseEntity.getBid())){
                baseRepository.delete(baseEntity);
                return "Deleted Successfully";
            }
            else{
                return "Does NOT Exists";
            }
        }catch(Exception e){
            throw e;
        }
    }

    // BaseEntity를 수정하는 함수
    public String updateBase(BaseEntity baseEntity){
        try{
            // ID를 가지는 질문이 존재하는지 확인하고, save한다
            // 바로 Save가 가능?? 삭제하고 재생성해야 하는 것 아닌가?
            if(baseRepository.existsById(baseEntity.getBid())){
                baseRepository.save(baseEntity);
                return "Updated Successfully";
            }
            else{
                return "Does NOT Exists";
            }
        }catch(Exception e){
            throw e;
        }
    }
}
