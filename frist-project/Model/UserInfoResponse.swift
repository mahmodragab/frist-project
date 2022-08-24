//
//  UserInfoResponse.swift
//  frist-project
//
//  Created by abdallah ragab on 14/08/2022.
//

import Foundation

// MARK: - UserInfoResponse
struct UserInfoResponse: Codable {
    let data: UserInfo?
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let secondNameArabic: String?
    let id, healthcareCenterID: Int?
    let thirdName: String?
    let userTypeID: Int?
    let profileCompleted, isAcceptedTermsOfUse: Bool?
    let fullNameArabic, occupation: String?
    let cityID: Int?
    let nationality: Nationality?
    let occupationSector, residencyType, religion: Int?
    let requirePasswordChange, isUnderaged: Bool?
    let motherNationalID, healthcareCenter, dateOfBirth: String?
    let employmentStatus: Int?
    let isConfirmedNationalAddress: Bool?
    let passportNumber: String?
    let maritalStatusID, educationLevel: Int?
    let updatedAt: String?
    let cityCoordinates: CityCoordinates?
    let isAcceptedPrivacyPolicy: Bool?
    let email, lastName: String?
    let birthOrder: Int?
    let lastNameArabic, birthCountry, district, createdAt: String?
    let secondName, motherName, residenceCountry, healthID: String?
    let birthTime: String?
    let firstName: String?
    let districtID: Int?
    let cityArabic: String?
    let isVerified: Bool?
    let firstNameArabic, gender, phoneNumber, city: String?
    let thirdNameArabic: String?
    let mobileIsVerified: Bool?
    let fullNameEnglish, nationalID: String?
    let parentUserID: String?
    let districtArabic: String?
    
    

    enum CodingKeys: String, CodingKey {
        case secondNameArabic = "second_name_arabic"
        case id
        case healthcareCenterID = "healthcare_center_id"
        case thirdName = "third_name"
        case userTypeID = "user_type_id"
        case profileCompleted = "profile_completed"
        case isAcceptedTermsOfUse = "is_accepted_terms_of_use"
        case fullNameArabic = "full_name_arabic"
        case occupation
        case cityID = "city_id"
        case nationality
        case occupationSector = "occupation_sector"
        case residencyType = "residency_type"
        case religion
        case requirePasswordChange = "require_password_change"
        case isUnderaged = "is_underaged"
        case motherNationalID = "mother_national_id"
        case healthcareCenter = "healthcare_center"
        case dateOfBirth = "date_of_birth"
        case employmentStatus = "employment_status"
        case isConfirmedNationalAddress = "is_confirmed_national_address"
        case passportNumber = "passport_number"
        case maritalStatusID = "marital_status_id"
        case educationLevel = "education_level"
        case updatedAt = "updated_at"
        case cityCoordinates = "city_coordinates"
        case isAcceptedPrivacyPolicy = "is_accepted_privacy_policy"
        case email
        case lastName = "last_name"
        case birthOrder = "birth_order"
        case lastNameArabic = "last_name_arabic"
        case birthCountry = "birth_country"
        case district
        case createdAt = "created_at"
        case secondName = "second_name"
        case motherName = "mother_name"
        case residenceCountry = "residence_country"
        case healthID = "health_id"
        case birthTime = "birth_time"
        case firstName = "first_name"
        case districtID = "district_id"
        case cityArabic = "city_arabic"
        case isVerified = "is_verified"
        case firstNameArabic = "first_name_arabic"
        case gender
        case phoneNumber = "phone_number"
        case city
        case thirdNameArabic = "third_name_arabic"
        case mobileIsVerified = "mobile_is_verified"
        case fullNameEnglish = "full_name_english"
        case nationalID = "national_id"
        case parentUserID = "parent_user_id"
        case districtArabic = "district_arabic"
    }
}

// MARK: - CityCoordinates
struct CityCoordinates: Codable {
    let lat, long: String?
}

// MARK: - Nationality
struct Nationality: Codable {
    let code: String?
    let id, nicCode: Int?
    let name, nameArabic: String?

    enum CodingKeys: String, CodingKey {
        case code, id
        case nicCode = "nic_code"
        case name
        case nameArabic = "name_arabic"
    }
}
