package com.jay.bean;

public class Department {
    private Integer deptId;

    private String deptName;

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public Department() {
    }

    public Department(Integer id, String deptName) {
        this.deptId = id;
        this.deptName = deptName;
    }

    public void setDeptName(String deptName) {

        this.deptName = deptName == null ? null : deptName.trim();
    }
}