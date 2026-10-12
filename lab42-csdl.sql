-- 1. Tạo cơ sở dữ liệu BanHang
--CREATE DATABASE BanHang;
GO

-- 2. Chỉ định sử dụng cơ sở dữ liệu vừa tạo
--USE BanHang;
GO

-- 3. Tạo bảng tblUser
CREATE TABLE tblUser (
    userName NVARCHAR(50) PRIMARY KEY,
    passWord NVARCHAR(50) NOT NULL
);
GO

-- 4. Tạo bảng tblHang
CREATE TABLE tblHang (
    MaHang NVARCHAR(50) PRIMARY KEY,
    TenHang NVARCHAR(50) NOT NULL,
    ChatLieu NVARCHAR(50),
    SoLuong INT DEFAULT 0,
    DonGiaNhap FLOAT,
    DonGiaBan FLOAT
);
GO

USE BanHang;
GO

-- 1. Thêm 5 dòng dữ liệu vào bảng tblUser
INSERT INTO tblUser (userName, passWord)
VALUES 
    ('admin', 'admin@123'),
    ('nhanvien01', 'nv0123'),
    ('nhanvien02', 'nv4567'),
    ('ketoan', 'ketoan2024'),
    ('quanly', 'quanlyboss');
GO

-- 2. Thêm 5 dòng dữ liệu vào bảng tblHang
INSERT INTO tblHang (MaHang, TenHang, ChatLieu, SoLuong, DonGiaNhap, DonGiaBan)
VALUES 
    ('MH01', N'Áo sơ mi nam', N'Cotton', 50, 150000, 250000),
    ('MH02', N'Quần tây nữ', N'Kaki', 30, 180000, 320000),
    ('MH03', N'Áo khoác gió', N'Polyester', 100, 120000, 200000),
    ('MH04', N'Váy liền thân', N'Lụa', 20, 300000, 550000),
    ('MH05', N'Áo thun Unisex', N'Cotton 100%', 200, 80000, 150000);
GO

USE BanHang;
GO
ALTER TABLE tblHang ADD Anh NVARCHAR(255);
ALTER TABLE tblHang ADD GhiChu NVARCHAR(MAX);