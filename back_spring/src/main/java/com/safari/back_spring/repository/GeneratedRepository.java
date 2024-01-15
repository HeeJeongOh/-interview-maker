package com.safari.back_spring.repository;

import com.safari.back_spring.entity.GeneratedEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GeneratedRepository extends JpaRepository<GeneratedEntity, Integer> {
}