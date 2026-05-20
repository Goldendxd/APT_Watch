package com.alughadi.entity;

import java.sql.Timestamp;

/**
 * User — represents a single user row from the "users" table.
 *
 * Columns used:
 *   id, username, email, password, role,
 *   full_name, phone, gender, profile_image,
 *   address, city, province,
 *   is_active, last_login, created_at, updated_at
 *
 * Columns that were in old code but are NOT in the actual DB schema
 * (date_of_birth, country, district, localUnits, ward, is_verified)
 * have been removed to keep this class honest.
 */
public class User {

    // --- core identity fields (always present) ---
    private int       id;
    private String    username;
    private String    email;
    private String    password;
    private String    role;

    // --- optional profile fields (filled in by updateProfile) ---
    private String    full_name;
    private String    phone;
    private String    gender;
    private String    profile_image;
    private String    address;
    private String    city;
    private String    province;

    // --- account state fields ---
    private int       is_active;
    private Timestamp last_login;
    private Timestamp created_At;
    private Timestamp updated_At;

    // ------------------------------------------------------------------
    // Constructors
    // ------------------------------------------------------------------

    /** Minimal constructor used when registering a new user. */
    public User(String username, String email, String password) {
        this.username = username;
        this.email    = email;
        this.password = password;
    }

    /**
     * Constructor used by the DAO when reading a user back from the DB.
     * Only sets the core columns — profile fields are set via setters afterwards.
     */
    public User(int id, String username, String email, String password,
                Timestamp createdAt, Timestamp updatedAt) {
        this.id         = id;
        this.username   = username;
        this.email      = email;
        this.password   = password;
        this.created_At = createdAt;
        this.updated_At = updatedAt;
    }

    // ------------------------------------------------------------------
    // Getters & Setters
    // ------------------------------------------------------------------

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }

    public String getUsername()                   { return username; }
    public void   setUsername(String username)    { this.username = username; }

    public String getEmail()                  { return email; }
    public void   setEmail(String email)      { this.email = email; }

    public String getPassword()                   { return password; }
    public void   setPassword(String password)    { this.password = password; }

    public String getRole()               { return role; }
    public void   setRole(String role)    { this.role = role; }

    public String getFull_name()                      { return full_name; }
    public void   setFull_name(String full_name)      { this.full_name = full_name; }

    public String getPhone()                  { return phone; }
    public void   setPhone(String phone)      { this.phone = phone; }

    public String getGender()                 { return gender; }
    public void   setGender(String gender)    { this.gender = gender; }

    public String getProfile_image()                          { return profile_image; }
    public void   setProfile_image(String profile_image)      { this.profile_image = profile_image; }

    public String getAddress()                    { return address; }
    public void   setAddress(String address)      { this.address = address; }

    public String getCity()               { return city; }
    public void   setCity(String city)    { this.city = city; }

    public String getProvince()                   { return province; }
    public void   setProvince(String province)    { this.province = province; }

    public int  getIs_active()                { return is_active; }
    public void setIs_active(int is_active)   { this.is_active = is_active; }

    public Timestamp getLast_login()                      { return last_login; }
    public void       setLast_login(Timestamp last_login) { this.last_login = last_login; }

    public Timestamp getCreated_At()                        { return created_At; }
    public void       setCreated_At(Timestamp created_At)   { this.created_At = created_At; }

    public Timestamp getUpdated_At()                        { return updated_At; }
    public void       setUpdated_At(Timestamp updated_At)   { this.updated_At = updated_At; }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', email='" + email +
               "', role='" + role + "', is_active=" + is_active + "}";
    }
}
