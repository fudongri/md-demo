package com.transsnet.md.entity;

import lombok.*;

import java.util.List;

@Data
@ToString
public class Table {
    private String name;
    private List<Column> columns;

    public Table(String name) {
        this.name = name;
    }
}