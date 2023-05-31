package com.vimal.unimas.controller;

import com.vimal.unimas.model.AuthenticationRequest;
import com.vimal.unimas.model.Student;
import com.vimal.unimas.model.faculty.Faculty;
import com.vimal.unimas.model.faculty.HOD_Dept;
import com.vimal.unimas.services.AdminServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
public class AdminController {

    @Autowired
    AdminServices adminServices;


    @GetMapping("/gettoppers")
    @ResponseBody
    public ResponseEntity<?> getToppers(@CookieValue(value="dept_id") String dept_id, HttpServletResponse response){
        if(dept_id == null || dept_id.equals("-1") ){
            return ResponseEntity.status(400).body("Bad Request. LogOut and LogIn again properly");
        }
        int dept =  Integer.parseInt(dept_id);
        List<Object> toppers = adminServices.getToppers(dept);
        return ResponseEntity.status(200).body(toppers);
    }


    @GetMapping("/getfac")
    @ResponseBody
    public ResponseEntity<?> getFac(@CookieValue(value="dept_id") String dept_id, HttpServletResponse response){
        if(dept_id == null || dept_id.equals("-1")  ){
            return ResponseEntity.status(400).body("Bad Request. LogOut and LogIn again properly");
        }
        int dept =  Integer.parseInt(dept_id);
        System.out.println(dept_id);
        List<Faculty> faculties = adminServices.getFaculty(dept);
        return ResponseEntity.status(200).body(faculties);
    }


    @GetMapping("/getstu")
    @ResponseBody
    public ResponseEntity<?> getStudents(@CookieValue(value="dept_id") String dept_id, HttpServletResponse response){
        if(dept_id == null || dept_id.equals("-1") ){
            return ResponseEntity.status(400).body("Bad Request. LogOut and LogIn again properly");
        }
        int dept =  Integer.parseInt(dept_id);
        List<Student> students = adminServices.getStudents(dept);
        return ResponseEntity.status(200).body(students);
    }


    @PutMapping("/updatepassword")
    @ResponseBody
    public  ResponseEntity<?> updatePassword( @RequestBody AuthenticationRequest req){
        System.out.println(req.getEmail() + " oo " + req.getPassword());

            int x = adminServices.updatepassword(req.getEmail(), req.getPassword());

            System.out.println(x);
            if(x > 0){
                return  new ResponseEntity<>("Password updated Successfully", HttpStatus.OK);
            }
            else{
                return  new ResponseEntity<>("Password could not be updated. Transaction Failed", HttpStatus.BAD_REQUEST);
            }

    }

    @PutMapping("/updatehod")
    @ResponseBody
    public  ResponseEntity<?> updateHOD(@RequestBody HOD_Dept req){
        int x = adminServices.assignHOD(req.getFid(), req.getDept());

        System.out.println(x);
        if(x > 0){
            return  new ResponseEntity<>("Password updated Successfully", HttpStatus.OK);
        }
        else{
            return  new ResponseEntity<>("Password could not be updated. Transaction Failed", HttpStatus.BAD_REQUEST);
        }
    }



}
