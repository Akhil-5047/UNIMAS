package com.vimal.unimas.model.faculty;

public class Attend {
    String sroll;
    int course_id;
    String adate;
    String status;


    public Attend() {
    }

    public String getSroll() {
        return sroll;
    }

    public void setSroll(String sroll) {
        this.sroll = sroll;
    }

    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    public String getAdate() {
        return adate;
    }

    public void setAdate(String adate) {
        this.adate = adate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Attend(String sroll, int course_id, String adate, String status) {
        this.sroll = sroll;
        this.course_id = course_id;
        this.adate = adate;
        this.status = status;
    }
}
