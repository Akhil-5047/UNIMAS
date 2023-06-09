package com.vimal.unimas.controller;


import com.vimal.unimas.model.*;
import com.vimal.unimas.services.StudentServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class StudentController {

    @Autowired
    StudentServices studentService;

    @GetMapping("/myprofile")
    public ResponseEntity<?>  myProfile(@CookieValue(value="sroll") String sroll){
        if(sroll.length() < 9){
            return ResponseEntity.status(400).body("Bad Request");
        }
        Student s = studentService.getStudent(sroll);
        return ResponseEntity.status(200).body(s);
    }
    @GetMapping("/myprofile2")
    public ResponseEntity<?>  myProfile2(@RequestBody String sroll){

        Student s = studentService.getStudent(sroll);
        return ResponseEntity.status(200).body(s);
    }

    @GetMapping("/getcurrattend")
    @ResponseBody
    public ResponseEntity<?> getCurrAttend(@CookieValue(value="sroll") String sroll) {
        if(sroll.length() < 9){
            return ResponseEntity.status(400).body("Bad Request");
        }
        return ResponseEntity.status(200).body(studentService.getCurrentAttendance(sroll));
    }


    @GetMapping("/getattend")
    @ResponseBody
    public ResponseEntity<?> getAttend(@CookieValue(value="sroll") String sroll) {
        if(sroll.length() < 9){
            return ResponseEntity.status(400).body("Bad Request");
        }
        return ResponseEntity.status(200).body(studentService.getAttendance(sroll));
    }


//    @PathVariable String sroll
    @GetMapping("/srollgrades")
    @ResponseBody
    public ResponseEntity<?> getStudentGradesBySroll(@CookieValue(value="sroll" ) String sroll){
        if(sroll.length() < 9){
            return ResponseEntity.status(400).body("Bad Request");
        }
        List<StudentGrades> sgrades = studentService.getGradesBySroll(sroll);
        List<StudentGPA> sgpa = studentService.getCGBySroll(sroll);
//        List<StudentGPA> sgpa2 = studentService.getGrades(sroll);
        StudentDetails studentDetails = new StudentDetails( sgrades, sgpa);
        return ResponseEntity.status(200).body(studentDetails);
    }

    @GetMapping("/srollreg")
    @ResponseBody
    public ResponseEntity<?> getStudentRegistrationBySroll(@CookieValue(value="sroll" ) String sroll){
        if(sroll.length() < 9){
            return ResponseEntity.status(400).body("Bad Request");
        }
        List<RegisteredCourses> coursesList = studentService.getStudentRegistrationDetails(sroll);
        boolean registered = studentService.isRegistered(sroll);
        List<OfferedCourses> offeredCourses =  studentService.getOfferedCourses(sroll);


        StudentRegistrationDetails studentDetails = new StudentRegistrationDetails(coursesList, registered, offeredCourses);
        return ResponseEntity.status(200).body(studentDetails);
    }


    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<?> register(@CookieValue(value="sroll" ) String sroll, @RequestBody List<Integer> courseIDs){
        if(sroll.length() < 9){
            return ResponseEntity.status(400).body("Bad Request");
        }
        String errors = studentService.registerStudent(sroll, courseIDs);
        if(errors.length() > 0){
            return ResponseEntity.status(400).body(errors);
        }
        else   return  ResponseEntity.status(200).body("All OK");
    }

    @PostMapping("/student")
    @ResponseBody
    public ResponseEntity<String> addStudentController(@RequestBody Student stu){
        String sroll = studentService.addStudent(stu,"pass");
        System.out.println("Hi " + sroll);
        if(sroll.length() == 9){
            return  new ResponseEntity<>("New Student added Successful" + " Sroll is " + sroll, HttpStatus.OK);
        }
        else{
            return  new ResponseEntity<>("New Student could not be added. Transaction Failed. Error is : " + sroll, HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("/student")
    @ResponseBody
    public ResponseEntity<String> updateStudentController(@RequestBody Student stu){
        if(studentService.updateStudent(stu) > 0){
            return  new ResponseEntity<>("Student modified Successfully", HttpStatus.OK);
        }
        else{
            return  new ResponseEntity<>("Student couldnot be updated. Transaction Failed", HttpStatus.BAD_REQUEST);
        }
    }

}
