-- Tạo database
CREATE DATABASE QuanLyVienPhi;
GO

USE QuanLyVienPhi;
GO

-- 1. Bảng BỆNH NHÂN (Lưu thông tin cá nhân và thẻ BHYT)
CREATE TABLE BenhNhan (
    MaBN VARCHAR(20) PRIMARY KEY,       -- Mã bệnh nhân (VD: BN260915)
    HoTen NVARCHAR(100) NOT NULL,       -- Họ tên bệnh nhân
    NamSinh INT NOT NULL CHECK (NamSinh > 1900 AND NamSinh <= YEAR(GETDATE())),
    CoTheBHYT BIT NOT NULL DEFAULT 0,   -- 1: Có thẻ, 0: Không thẻ
    MaTheBHYT VARCHAR(15),              -- Mã thẻ (nếu có, 15 ký tự)
    MucHuong INT,                       -- Mức hưởng (80, 95, 100)
    TuyenKham BIT                       -- 1: Đúng tuyến, 0: Trái tuyến
);
GO

-- 2. Bảng DỊCH VỤ (Lưu danh sách các dịch vụ và giá tiền để dễ bảo trì)
CREATE TABLE DichVu (
    MaDV VARCHAR(10) PRIMARY KEY,
    TenDV NVARCHAR(100) NOT NULL,
    GiaDV DECIMAL(18,0) NOT NULL
);
GO

-- 3. Bảng HÓA ĐƠN / PHIẾU THANH TOÁN (Lưu tổng kết viện phí)
CREATE TABLE HoaDon (
    MaHD INT IDENTITY(1,1) PRIMARY KEY, -- Mã hóa đơn tự tăng
    MaBN VARCHAR(20) NOT NULL,          -- Khóa ngoại đến bảng Bệnh Nhân
    NgayLap DATETIME NOT NULL DEFAULT GETDATE(),
    SoNgayGiuong INT NOT NULL DEFAULT 0,
    TongChiPhi DECIMAL(18,0) NOT NULL,  -- Tổng chi phí
    BHYTChiTra DECIMAL(18,0) NOT NULL,  -- Số tiền BHYT trả
    BenhNhanTra DECIMAL(18,0) NOT NULL, -- Số tiền Bệnh nhân phải trả
    
    CONSTRAINT FK_HoaDon_BenhNhan FOREIGN KEY (MaBN) REFERENCES BenhNhan(MaBN)
);
GO

-- 4. Bảng CHI TIẾT HÓA ĐƠN (Lưu các dịch vụ bệnh nhân đã sử dụng)
-- Bảng này giúp tính toán chính xác và xem lại chi tiết sau này
CREATE TABLE ChiTietHoaDon (
    MaHD INT NOT NULL,
    MaDV VARCHAR(10) NOT NULL,
    PRIMARY KEY (MaHD, MaDV),
    CONSTRAINT FK_CTHD_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    CONSTRAINT FK_CTHD_DichVu FOREIGN KEY (MaDV) REFERENCES DichVu(MaDV)
);
GO

-- ========================================================
-- CHÈN DỮ LIỆU MẪU BAN ĐẦU CHO BẢNG DỊCH VỤ 
-- (Theo đúng bảng giá của đề bài)
-- ========================================================
INSERT INTO DichVu (MaDV, TenDV, GiaDV) VALUES
    ('DV01', N'Khám bệnh', 50000),
    ('DV02', N'Xét nghiệm máu', 120000),
    ('DV03', N'Siêu âm', 150000),
    ('DV04', N'Điện tim', 80000),
    ('DV05', N'Chụp X-quang', 180000),
    ('DV06', N'Giường bệnh/ngày', 250000);
GO