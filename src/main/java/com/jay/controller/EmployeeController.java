package com.jay.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jay.bean.Employee;
import com.jay.bean.Msg;
import com.jay.service.EmployeeService;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.io.FileWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 处理员工crud请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据(分页)
     * @return
     */
    /**
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){

        //引入PageHelper分页插件
        //在查询之前只需要调用  第一个参数是第几页 第二个是一页查多少个
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employeeList = employeeService.getAll();
        //使用pageInfo来包装查询的结果 只需要将pageInfo交给页面就行了
        //pageInfo第二个参数是连续显示的页数
        PageInfo pageInfo = new PageInfo(employeeList,5);
        model.addAttribute("pageInfo",pageInfo);

        return "list";
    }
     */

    /**
     * 需要导入jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employeeList = employeeService.getAll();
        //使用pageInfo来包装查询的结果 只需要将pageInfo交给页面就行了
        //pageInfo第二个参数是连续显示的页数
        PageInfo pageInfo = new PageInfo(employeeList,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 员工保存
     * 1.支持jsr303校验 要导入 Hibernate-Validator
     *
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method=RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败 在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError: fieldErrors){
                System.out.println("错误的字段名:" + fieldError.getField());
                System.out.println("错误信息:" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否同名
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String  empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";

        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg"," 用户名必须是6-16位数字和字母的组合或2-5位中文");
        }

        //返回true  说明可用
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            //不可用
            return Msg.fail().add("va_msg","用户名不可用1");
        }
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     *
     * 根据id保存
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println("将要更新的员工数据:" + employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 单个和批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        //如果包含-  就是批量删除
        if(ids.contains("-")){
            String[] str_ids = ids.split("-");
            for (int i = 0;i < str_ids.length;i++){
                employeeService.deleteEmpById(Integer.parseInt(str_ids[i]));
            }
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }
        return Msg.success();
    }
}

