package com.safari.back_spring.repository;

import com.safari.back_spring.entity.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BaseRepository extends JpaRepository<BaseEntity, Integer> {
}