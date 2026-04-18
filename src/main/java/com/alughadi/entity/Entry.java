package com.alughadi.entity;

import java.sql.Timestamp;
import java.util.Date;

public class Entry {
    private int id;
    private String username;
    private String full_name;
    private String phone;
    private Date date_of_birth;
    private String gender;
    private String email;
    private String profile_image;
    private String address;
    private String country;
    private String city;
    private String province;
    private String district;
    private String localUnits;
    private String ward;
    private int is_active;
    private int is_verified;
    private Timestamp created_At;
    private Timestamp updated_At;
    private Timestamp last_login;

    public Entry(int id, String full_name, String username, String phone, Date date_of_birth, String gender,
                 String profile_image, String address, String country, String city, String province,
                 String district, String localUnits, String email, String ward, int is_active, int is_verified, Timestamp created_At,
                 Timestamp updated_At, Timestamp last_login) {
        this.id = id;
        this.username = username;
        this.full_name = full_name;
        this.phone = phone;
        this.date_of_birth = date_of_birth;
        this.gender = gender;
        this.profile_image = profile_image;
        this.address = address;
        this.country = country;
        this.email = email;
        this.city = city;
        this.province = province;
        this.district = district;
        this.localUnits = localUnits;
        this.ward = ward;
        this.is_active = is_active;
        this.is_verified = is_verified;
        this.created_At = created_At;
        this.updated_At = updated_At;
        this.last_login = last_login;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getUsername(){
        return username;
    }
    public void setUsername(String username){
        this.username = username;
    }
    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail(){
       return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfile_image() {
        return profile_image;
    }

    public void setProfile_image(String profile_image) {
        this.profile_image = profile_image;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getLocalUnits() {
        return localUnits;
    }

    public void setLocalUnits(String localUnits) {
        this.localUnits = localUnits;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public int getIs_active() {
        return is_active;
    }

    public void setIs_active(int is_active) {
        this.is_active = is_active;
    }

    public int getIs_verified() {
        return is_verified;
    }

    public void setIs_verified(int is_verified) {
        this.is_verified = is_verified;
    }

    public Timestamp getCreated_At() {
        return created_At;
    }

    public void setCreated_At(Timestamp created_At) {
        this.created_At = created_At;
    }

    public Timestamp getUpdated_At() {
        return updated_At;
    }

    public void setUpdated_At(Timestamp updated_At) {
        this.updated_At = updated_At;
    }

    public Timestamp getLast_login() {
        return last_login;
    }

    public void setLast_login(Timestamp last_login) {
        this.last_login = last_login;
    }

    @Override
    public String toString() {
        return "Entry{" +
                "id=" + id +
                ", full_name='" + full_name + '\'' +
                ", username='" + username + '\'' +
                ", phone='" + phone + '\'' +
                ", date_of_birth=" + date_of_birth +
                ", gender='" + gender + '\'' +
                ", profile_image='" + profile_image + '\'' +
                ", address='" + address + '\'' +
                ", country='" + country + '\'' +
                ", city='" + city + '\'' +
                ", province='" + province + '\'' +
                ", district='" + district + '\'' +
                ", localUnits='" + localUnits + '\'' +
                ", ward='" + ward + '\'' +
                ", email='" + email + '\'' +
                ", is_active=" + is_active +
                ", is_verified=" + is_verified +
                ", created_At=" + created_At +
                ", updated_At=" + updated_At +
                ", last_login=" + last_login +
                '}';
    }
}
