package com.safari.back_spring.controller;

import com.safari.back_spring.entity.BaseEntity;
import com.safari.back_spring.entity.GeneratedEntity;
import com.safari.back_spring.model.Base;
import com.safari.back_spring.model.Generated;
import com.safari.back_spring.model.Request;
import com.safari.back_spring.service.GeneratedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class GeneratedController {
    @Autowired
    GeneratedService generatedService;

    // generated/get으로 매핑됨
    @PostMapping(value = "/generated/get")
    // Request Entity를 사용한다. post를 사용하는 이유는 링크에 정보가 드러나지 않도록 하기 위함
    public List<Generated> getGeneratedQuestion(@RequestBody Request request){
        List<Generated> generateds = generatedService.getGeneratedQuestion(request);
        System.out.println(generateds.stream());
        return generateds;
    }

//    @PostMapping(value = "/generated/add")
//    public String addBase(@RequestBody GeneratedEntity generatedEntity){
//        return generatedService.addGeneration(generatedEntity);
//    }

//    @PostMapping(value = "/generated/update")
//    public String updateBase(@RequestBody GeneratedEntity generatedEntity){
//        return generatedService.updateGeneration(generatedEntity);
//    }
//
//    @DeleteMapping(value = "/generated/delete")
//    public String deleteBase(@RequestBody GeneratedEntity generatedEntity){
//        return generatedService.deleteGeneration(generatedEntity);
//    }


}
