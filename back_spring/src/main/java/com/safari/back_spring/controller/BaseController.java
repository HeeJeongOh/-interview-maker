package com.safari.back_spring.controller;

import com.safari.back_spring.entity.BaseEntity;
import com.safari.back_spring.model.Base;
import com.safari.back_spring.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@CrossOrigin()
public class BaseController {
    @Autowired
    BaseService baseService;

    // url/base/get으로 접속하면 되도록 매핑
    @GetMapping(value = "/base/get")
    // gender, cycle이라는 값은 int형 매개변수로써 링크에 담겨야 함
    public Base getBaseQuestion(@RequestParam(name="gender") int gender, @RequestParam(name="cycle") int cycle ){
        // 담겨온 매개변수는 getBaseQuestion 함수에 매개변수로 들어간다. 
        return baseService.getBaseQuestion(gender, cycle);
    }
//
//    @PostMapping(value = "/base/add")
//    public String addBase(@RequestBody BaseEntity base){
//        return baseService.addBase(base);
//    }
//
//    @PostMapping(value = "/base/update")
//    public String updateBase(@RequestBody BaseEntity base){
//        return baseService.updateBase(base);
//    }
//
//    @DeleteMapping(value = "/base/delete")
//    public String deleteBase(@RequestBody BaseEntity base){
//        return baseService.deleteBase(base);
//    }
}
