-- Tạo database
CREATE DATABASE QuanLyKhoVatLieu;
GO

USE QuanLyKhoVatLieu;
GO

-- 1. Bảng MẶT HÀNG (Lưu thông tin vật tư và số lượng tồn kho)
CREATE TABLE MatHang (
    MaMH VARCHAR(10) PRIMARY KEY,      -- Mã mặt hàng (VD: VT01)
    TenMH NVARCHAR(100) NOT NULL,      -- Tên mặt hàng (VD: Xi măng PCB40)
    DVT NVARCHAR(50) NOT NULL,         -- Đơn vị tính (VD: Bao, Cây)
    TonDauKy INT NOT NULL,             -- Tồn kho ban đầu
    TonHienTai INT NOT NULL            -- Tồn kho hiện tại (cập nhật khi lập/xóa phiếu)
);
GO

-- 2. Bảng PHIẾU NHẬP - XUẤT (Lưu thông tin các giao dịch)
CREATE TABLE PhieuNhapXuat (
    SoPhieu VARCHAR(10) PRIMARY KEY,   -- Số phiếu (VD: PN0001, PX0002)
    LoaiPhieu NVARCHAR(20) NOT NULL,   -- Phân loại: 'Nhập kho' hoặc 'Xuất kho'
    MaMH VARCHAR(10) NOT NULL,         -- Khóa ngoại liên kết tới Mặt hàng
    SoLuong INT NOT NULL CHECK (SoLuong > 0), -- Số lượng nhập/xuất
    DonGia DECIMAL(18, 0) NOT NULL CHECK (DonGia > 0), -- Đơn giá
    ThanhTien DECIMAL(18, 0) NOT NULL, -- Thành tiền (Số lượng * Đơn giá)
    NgayLap DATE NOT NULL,             -- Ngày lập phiếu
    
    -- Tạo khóa ngoại
    CONSTRAINT FK_Phieu_MatHang FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH)
);
GO

-- ========================================================
-- CHÈN DỮ LIỆU MẪU BAN ĐẦU CHO BẢNG MẶT HÀNG 
-- (Theo đúng bảng yêu cầu của đề bài)
-- ========================================================
INSERT INTO MatHang (MaMH, TenMH, DVT, TonDauKy, TonHienTai)
VALUES 
    ('VT01', N'Xi măng PCB40', N'Bao', 500, 500),
    ('VT02', N'Thép phi 10', N'Cây', 300, 300),
    ('VT03', N'Gạch đặc', N'Viên', 20000, 20000),
    ('VT04', N'Cát vàng', N'm³', 80, 80),
    ('VT05', N'Sơn nước 18L', N'Thùng', 40, 40);
GO