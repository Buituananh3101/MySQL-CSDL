-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE QuanLyVuLua;
GO

USE QuanLyVuLua;
GO

-- 2. Tạo bảng Giống lúa
CREATE TABLE GiongLua (
    MaGiong INT IDENTITY(1,1) PRIMARY KEY,
    TenGiong NVARCHAR(100) NOT NULL UNIQUE,
    LuongGiong FLOAT NOT NULL,          -- kg/sào
    GiaGiong DECIMAL(18, 2) NOT NULL,    -- đ/kg
    GiaBanThoc DECIMAL(18, 2) NOT NULL,  -- đ/kg
    NhomGiong NVARCHAR(50) NOT NULL      -- 'Chất lượng cao' hoặc 'Thường'
);
GO

-- 3. Tạo bảng Sổ theo dõi các hộ
CREATE TABLE SoTheoDoi (
    MaHo INT IDENTITY(1,1) PRIMARY KEY,
    ChuHo NVARCHAR(100) NOT NULL,
    VuMua NVARCHAR(50) NOT NULL,         -- 'Đông Xuân', 'Hè Thu', 'Thu Đông'
    MaGiong INT NOT NULL,
    DienTich FLOAT NOT NULL,             -- Số sào
    NangSuat INT NOT NULL,               -- kg/sào
    ChiPhiPhanThuoc DECIMAL(18, 2) NOT NULL,
    SanLuong FLOAT NOT NULL,             -- kg
    TongChiPhi DECIMAL(18, 2) NOT NULL,
    LoiNhuan DECIMAL(18, 2) NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_SoTheoDoi_GiongLua FOREIGN KEY (MaGiong) 
        REFERENCES GiongLua(MaGiong)
);
GO

-- 4. Thêm dữ liệu mẫu vào bảng Giống lúa (theo đề bài)
INSERT INTO GiongLua (TenGiong, LuongGiong, GiaGiong, GiaBanThoc, NhomGiong) 
VALUES 
    (N'ST25', 1.5, 45000, 11500, N'Chất lượng cao'),
    (N'Bắc Thơm số 7', 1.4, 35000, 9000, N'Chất lượng cao'),
    (N'Khang Dân 18', 1.6, 25000, 7500, N'Thường'),
    (N'Nếp cái hoa vàng', 1.5, 40000, 12000, N'Thường');
GO