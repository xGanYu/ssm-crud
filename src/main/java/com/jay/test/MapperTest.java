package com.jay.test;

import com.jay.bean.Department;
import com.jay.bean.Employee;
import com.jay.dao.DepartmentMapper;
import com.jay.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {

        //1.创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//
//        EmployeeMapper bean = ioc.getBean(EmployeeMapper.class);


//        departmentMapper.insertSelective(new Department(1,"开发部"));
//        departmentMapper.insertSelective(new Department(2,"测试部"));


//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));

        //批量插入多个员工
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String str = UUID.randomUUID().toString().substring(0,5) + i;
//            mapper.insertSelective(new Employee(null,str,"M",str + "@qq.com",1));
//        }

        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        for(Employee employee : employees){
            System.out.println(employee);
        }

    }
}
