package com.jay.dao;

import com.jay.bean.Employee;
import com.jay.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeMapper {

    List<Employee> selectByExampleWithDept(EmployeeExample example);

    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    void addEmp(Employee employee);

    //根据名字查询是否存在 等于null说明不存在
    Employee queryEmpByEmpName(String empName);

    Employee queryEmpById(Integer id);

    void updateByPrimaryKeySelective(Employee employee);
    void updateByPrimaryKeySelective1(Employee employee);
    void deleteByPrimaryKey(Integer id);

    void deleteEmp(Integer id);

}