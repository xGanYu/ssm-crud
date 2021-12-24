package com.jay.service;

import com.jay.bean.Employee;
import com.jay.bean.EmployeeExample;
import com.jay.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工(分页)
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存
     * @param employee
     */
    public void saveEmp(Employee employee) {
        System.out.println(employee);
        employeeMapper.addEmp(employee);
    }

    /**
     * 检验员工是否可用
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        //等于null 说明可用
        if(employeeMapper.queryEmpByEmpName(empName) == null){
            return true;
        }
        return false;
    }

    /**
     * 按照员工id查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.queryEmpById(id);
        System.out.println(employee);
        return employee;
    }

    /**
     * 员工修改
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }



    public void deleteEmp(Integer id) {

    }
}
