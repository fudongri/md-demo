package com.transsnet.entity;

import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class Table {
    private String name;
    private List<Column> columns;

    private String ddl;

    public Table(String name) {
        this.name = name;
    }
}