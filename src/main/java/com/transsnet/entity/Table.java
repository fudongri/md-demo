package com.transsnet.entity;

import lombok.Data;

import java.util.List;

@Data
public class Table {
    private String name;
    private List<Column> columns;

    private String ddl;

    public Table(String name) {
        this.name = name;
    }
}