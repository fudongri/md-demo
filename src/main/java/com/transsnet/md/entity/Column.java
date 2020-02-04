package com.transsnet.md.entity;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Column {
    private String field;
    private String type;
    private String comment;

}