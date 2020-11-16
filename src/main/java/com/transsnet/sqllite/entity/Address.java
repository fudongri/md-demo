package com.transsnet.sqllite.entity;

import lombok.Data;

/**
 * @author fdr
 */
@Data
public class Address {
    private String _id;
    private String state;
    private String town;
    private String area;
    private String street;
}