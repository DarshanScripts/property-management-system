USE PropertyManagementSystem;

CREATE TABLE PropertyOwnerMaster (
    OwnerId INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    DOB DATE,
    Gender CHAR(1),
    EmailId VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    Password VARCHAR(255) NOT NULL,
    RegisterDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO PropertyOwnerMaster (FullName, DOB, Gender, EmailId, PhoneNumber, Password)
VALUES
    ("Abhishek Prafulbhai Hingu", "1990-05-15", "M", "abhishek@example.com", "1234567890", "password123"),
    ("Bhalala Hemani Kamlesh", "1985-08-22", "F", "hemani@example.com", "9876543210", "securepass"),
    ("Attaas Saiyed Arkam Saiyedzaed", "1978-12-10", "M", "arkam@example.com", "5551234567", "pass123"),
    ("Chaudhari Jainishkumar Sureshbhai", "1995-04-30", "M", "jainish@example.com", "8885551234", "abc123"),
    ("Borada Vaibhavkumar Ambabhai", "1982-07-18", "M", "vaibhav@example.com", "7774441234", "qwerty");


CREATE TABLE PropertyMaster (
    PropertyId INT AUTO_INCREMENT PRIMARY KEY,
    OwnerId INT,
    PropertyName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Type VARCHAR(50),
    AdditionalFeatures TEXT,
    RentPerMonth DECIMAL(10, 2),
    ImagePath VARCHAR(255),
    Status VARCHAR(20),
    RegisterDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (OwnerId) REFERENCES PropertyOwnerMaster(OwnerId)
);

INSERT INTO PropertyMaster (OwnerId, PropertyName, Address, Type, AdditionalFeatures, RentPerMonth, ImagePath, Status)
VALUES
    (1, "Beautiful Villa", "123 Main St", "House", "Swimming Pool, Garden", 2000.00, "/images/villa.jpg", "Available"),
    (2, "Cozy Apartment", "456 Oak Ave", "Apartment", "Furnished", 1200.00, "/images/apartment.jpg", "Rented"),
    (3, "Spacious Condo", "789 Pine Rd", "Condo", "Balcony, Gym", 1800.00, "/images/condo.jpg", "Available"),
    (4, "Charming Cottage", "101 Maple Ln", "House", "Fireplace", 1500.00, "/images/cottage.jpg", "Available"),
    (5, "Modern Loft", "202 Elm Blvd", "Apartment", "Open Floor Plan", 1600.00, "/images/loft.jpg", "Rented");


CREATE TABLE TenantMaster (
    TenantId INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    DOB DATE,
    Gender CHAR(1),
    EmailId VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    Password VARCHAR(255) NOT NULL,
    RegisterDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO TenantMaster (FullName, DOB, Gender, EmailId, PhoneNumber, Password)
VALUES
    ("Desai Parita Rajnishbhai", "1993-09-25", "F", "parita@example.com", "5557891234", "pass123"),
    ("Dhyey Desai", "1988-03-12", "M", "dhyey@example.com", "7774567890", "securepass"),
    ("Chodvadiya Radhikaben Sureshbhai", "1997-06-18", "F", "radhika@example.com", "8883331234", "abc123"),
    ("Dholakiya Aksharkumar Mansukhbhai", "1990-11-08", "M", "akshar@example.com", "9995551234", "qwerty"),
    ("Dhruvi Priyankkumar Naik", "1985-04-30", "F", "dhruvi@example.com", "6662221234", "password123");


CREATE TABLE LeaseDetail (
    LeaseID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyId INT,
    TenantId INT,
    StartDate DATE,
    EndDate DATE,
    RentAmount DECIMAL(10, 2),
    LeaseStatus VARCHAR(20),
    RegistrationDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PropertyId) REFERENCES PropertyMaster(PropertyId),
    FOREIGN KEY (TenantId) REFERENCES TenantMaster(TenantId)
);

INSERT INTO LeaseDetail (PropertyId, TenantId, StartDate, EndDate, RentAmount, LeaseStatus)
VALUES
    (1, 1, "2023-01-01", "2023-12-31", 2000.00, "Active"),
    (2, 2, "2023-02-15", "2023-08-15", 1200.00, "Active"),
    (3, 3, "2023-03-10", "2023-09-10", 1800.00, "Inactive"),
    (4, 4, "2023-04-05", "2023-10-05", 1500.00, "Active"),
    (5, 5, "2023-05-20", "2023-11-20", 1600.00, "Inactive");



DELIMITER //

DROP PROCEDURE IF EXISTS addProperty //

CREATE PROCEDURE addProperty(IN ownerId INT, IN propName VARCHAR(255), IN address VARCHAR(255), IN type VARCHAR(255), IN addFeat VARCHAR(255), IN rent DECIMAL(10,2), IN imgPath VARCHAR(255), IN status VARCHAR(255))
BEGIN
	INSERT INTO PropertyMaster (OwnerId, PropertyName, Address, Type, AdditionalFeatures, RentPerMonth, ImagePath, Status) VALUES(ownerId,propName,address,type,addFeat,rent,imgPath,status);
END //

DELIMITER ;