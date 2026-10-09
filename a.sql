-- =========================================================
-- TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG (SQL SERVER)
-- =========================================================


GO

GO

-- 1. Bảng account
CREATE TABLE account (
    userName VARCHAR(50) NOT NULL PRIMARY KEY,
    password VARCHAR(60) NULL,
    email VARCHAR(50) NULL,
    chuc_vu VARCHAR(50) NULL
);
GO

-- Dữ liệu mẫu account
INSERT INTO account (userName, password, email, chuc_vu) VALUES
('admin', '123', 'duy2505@gmail.com', 'admin'),
('bobo', '123456', 'hgiabao2k3@gmail.com', 'nhanvien'),
('dat', '123', 'dat@gmail.com', 'admin'),
('dong', '123', 'dong@gmail.com', 'ketoan'),
('duc', '123', 'duc@gmail.com', 'nhanvien'),
('hoangdat', '123', 'dat111@gmail.com', 'admin'),
('nhi', '123', 'nhi@gmail.com', 'admin'),
('thienan', '123', 'a11611112003@gmail.com', 'nhanvien');
GO

-- 2. Bảng nhanvien
CREATE TABLE nhanvien (
    ma_nhan_vien VARCHAR(50) NOT NULL PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    ho_ten VARCHAR(50) NOT NULL,
    gioi_tinh VARCHAR(10) CHECK (gioi_tinh IN ('Nam','Nữ')) NOT NULL,
    ngay_sinh DATE NOT NULL,
    SDT VARCHAR(15) UNIQUE NOT NULL,
    ngay_vao_lam DATE NOT NULL,
    trang_thai VARCHAR(20) DEFAULT 'Đang làm' CHECK (trang_thai IN ('Đang làm','Nghỉ việc')),
    CONSTRAINT fk_nhanvien_account FOREIGN KEY (user_name) REFERENCES account(userName)
);
GO

-- Dữ liệu mẫu nhanvien
INSERT INTO nhanvien (ma_nhan_vien, user_name, ho_ten, gioi_tinh, ngay_sinh, SDT, ngay_vao_lam, trang_thai) VALUES
('1', 'admin', 'Khanh duy', 'Nam', '2003-05-25', '0915642495', '2025-03-03', 'Đang làm'),
('2', 'bobo', 'Gia Bao', 'Nam', '2003-02-12', '1111111111', '2025-03-04', 'Đang làm'),
('3', 'hoangdat', 'Hoang Dat', 'Nam', '2003-09-12', '2', '2025-03-10', 'Đang làm'),
('4', 'thienan', 'Thien An', 'Nữ', '2003-09-12', '3223', '2025-03-10', 'Đang làm');
GO

-- 3. Bảng kho
CREATE TABLE kho (
    maKho VARCHAR(50) NOT NULL PRIMARY KEY,
    ten_kho VARCHAR(100) NOT NULL,
    dia_chi VARCHAR(MAX) NOT NULL,
    so_dien_thoai VARCHAR(20) NULL,
    nguoi_quan_ly VARCHAR(50) NULL,
    trang_thai VARCHAR(20) DEFAULT 'Hoạt động' CHECK (trang_thai IN ('Hoạt động','Tạm ngưng','Bảo trì')),
    ngay_cap_nhat DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_kho_nhanvien FOREIGN KEY (nguoi_quan_ly) REFERENCES account(userName) ON DELETE SET NULL ON UPDATE CASCADE
);
GO

-- Dữ liệu mẫu kho
INSERT INTO kho (maKho, ten_kho, dia_chi, so_dien_thoai, nguoi_quan_ly, trang_thai, ngay_cap_nhat) VALUES
('KHO1', 'Kho Hải Phòng', '81 Quán Nam', '0313721626', 'hoangdat', 'Hoạt động', '2025-01-01 14:18:30'),
('KHO2', 'Kho Hà Nội', '39 Lê Đức thọ', '0313789543', 'bobo', 'Hoạt động', '2025-03-25 15:45:18'),
('KHO3', 'Kho Đà Nẵng', '79 Quán Nam', '0321456789', 'admin', 'Hoạt động', '2025-05-19 15:11:59');
GO

-- 4. Bảng nhacungcap
CREATE TABLE nhacungcap (
    ma_nha_cung_cap VARCHAR(50) NOT NULL PRIMARY KEY,
    ten_nha_cung_cap VARCHAR(50) NULL,
    Sdt VARCHAR(50) NULL,
    dia_chi VARCHAR(150) NULL
);
GO

-- Dữ liệu mẫu nhacungcap
INSERT INTO nhacungcap (ma_nha_cung_cap, ten_nha_cung_cap, Sdt, dia_chi) VALUES
('NCC1', 'Phong Vũ', '0793214682', 'Số, 8A Lê hồng Phong'),
('NCC2', 'HACOM', '0795065566', 'Số 79, Đông Khê'),
('NCC3', 'Công ty A', '0123456789', '79A Hà Nội');
GO

-- 5. Bảng khachhang
CREATE TABLE khachhang (
    id_khach_hang VARCHAR(50) NOT NULL PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    Sdt VARCHAR(15) NOT NULL,
    dia_chi VARCHAR(MAX) NULL
);
GO

-- Dữ liệu mẫu khachhang
INSERT INTO khachhang (id_khach_hang, ho_ten, Sdt, dia_chi) VALUES
('KH01', 'Tran dat', '0793214682', 'Đông Khê'),
('KH02', 'Duy Beo', '0793456789', 'Hồng Bàng'),
('KH03', 'Duc', '0123456789', 'Trang cat');
GO

-- 6. Bảng sanpham
CREATE TABLE sanpham (
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    ten_sanpham VARCHAR(255) NOT NULL,
    loai VARCHAR(100) NULL,
    co_the_ban INT DEFAULT 0,
    ton_kho INT DEFAULT 0,
    ngay_khoi_tao DATETIME NULL,
    donvitinh VARCHAR(50) NULL,
    chitietsanpham VARCHAR(255) NOT NULL,
    don_gia FLOAT NULL,
    baohanhcuahang VARCHAR(50) NULL
);
GO

-- Dữ liệu mẫu sanpham
INSERT INTO sanpham (id, ten_sanpham, loai, co_the_ban, ton_kho, ngay_khoi_tao, donvitinh, chitietsanpham, don_gia, baohanhcuahang) VALUES
('LT01', 'ASUS VIVOBOOK X509JAA', 'Laptop', 17, 20, '2024-12-02 17:00:00', 'Chiếc', 'I5-1035G1,Onboard,RAM 8,SSD 256,15.6''FHD', 100, '12'),
('LT02', 'LENOVO 80TV', 'Laptop', 6, 9, '2025-06-06 17:00:00', 'Chiếc', 'I5-7200U,Onboard,RAM 8,SSD 128,15.6''FHD', 100, '12'),
('LT03', 'DELL 5289', 'Laptop', 0, 0, '2024-12-09 17:00:00', 'Chiếc', 'I5-7300H,Onboard,RAM 8,SSD 120,12.5''HD', 0, '0'),
('LT04', 'DELL VOSTRO 3446', 'Laptop', 0, 0, '2025-01-09 17:00:00', 'Chiếc', 'I5-4210U,Onboard,RAM 8,SSD 120+HDD 500,14" HD', 0, '0'),
('LT05', 'HP PROBOOK 640 G1', 'Laptop', 0, 0, '2024-10-12 17:00:00', 'Chiếc', 'I5-4200M,Onboard,RAM 8,SSD 120,12.5" HD', 0, '0'),
('LT06', 'ASUS X441UA', 'Laptop', 0, 0, '2024-04-15 17:00:00', 'Chiếc', 'I3-6006U,Onboard,RAM 8,SSD 120,14" HD', 0, '0'),
('LT07', 'DELL 7270', 'Laptop', 0, 0, '2024-04-22 17:00:00', 'Chiếc', 'I5-6200U,Onboard,RAM 8,SSD 120,12.5" HD', 0, '0'),
('LT08', 'DELL LATITUDE E7270', 'Laptop', 0, 0, '2024-04-03 17:00:00', 'Chiếc', 'I5-6200U,Onboard,RAM 8,SSD 120,12.5" HD', 0, '0'),
('LT09', 'DELL LATITUDE E7270', 'Laptop', 0, 0, '2024-08-10 17:00:00', 'Chiếc', 'I5-6200U,Onboard,RAM 8,SSD 120,12.5" HD', 0, '0'),
('LT10', 'HP 348G4', 'Laptop', 0, 0, '2024-10-10 17:00:00', 'Chiếc', 'I5-7200U,Onboard,RAM 8,SSD 256,14" HD', 0, '0'),
('LT11', 'ACER ASPIRE A315-54', 'Laptop', 0, 0, '2024-10-21 17:00:00', 'Chiếc', 'I3-8145U,Onboard,RAM 8,SSD 256,15.6" FHD', 0, '0'),
('LT12', 'DELL VOSTRO 15 - 3568', 'Laptop', 0, 0, '2024-07-31 17:00:00', 'Chiếc', 'I3-6006U,Onboard,RAM 8,SSD 128,15.6" HD', 0, '0'),
('LT13', 'LENOVO 82C4', 'Laptop', 0, 0, '2024-05-31 17:00:00', 'Chiếc', 'I5-1035G1,Onboard,RAM 8,SSD 256,14" FHD', 0, '0'),
('LT14', 'DELL LATITUDE E5470', 'Laptop', 0, 0, '2024-09-17 17:00:00', 'Chiếc', 'I5-6300U,Onboard,RAM 8,SSD 128,14" HD', 0, '0'),
('LT15', 'DELL LATITUDE 5450', 'Laptop', 0, 0, '2024-08-20 17:00:00', 'Chiếc', 'I5-5200U,Onboard,RAM 4,SSD 120,14" HD', 0, '0'),
('LT16', 'DELL LATITUDE 3490', 'Laptop', 0, 0, '2024-09-01 17:00:00', 'Chiếc', 'I3-6006U,Onboard,RAM 8,SSD 120,14" HD', 0, '0'),
('LT17', 'HP 15S', 'Laptop', 0, 0, '2024-07-13 17:00:00', 'Chiếc', 'PENTIUM N5000,Onboard,RAM 8,SSD 120,15.6" FHD', 0, '0'),
('LT18', 'HP NOTEBOOK', 'Laptop', 0, 0, '2024-07-29 17:00:00', 'Chiếc', 'I3-6006U,Onboard,RAM 8,SSD 120+HDD 500,15.6" FHD', 0, '0'),
('LT19', 'DELL 5370', 'Laptop', 0, 0, '2024-10-01 17:00:00', 'Chiếc', 'I5-8250U,Onboard,RAM 8,SSD 256,13.3" FHD', 0, '0'),
('LT20', 'MAC PRO 2022', 'Laptop', 0, 0, '2024-04-20 17:00:00', 'Chiếc', 'APPLE M2,Onboard,RAM 16,SSD 500,13.3" 2K', 0, '0'),
('LT21', 'DELL INSPIRON 14 5410', 'Laptop', 0, 0, '2024-11-26 17:00:00', 'Chiếc', 'I5-11300H,MX450-2GB,RAM 8,SSD 512,14" FHD', 0, '0'),
('LT22', 'HP LAPTOP 14', 'Laptop', 0, 0, '2024-05-24 17:00:00', 'Chiếc', 'R5-7520U,Onboard,RAM 16,SSD 512,14" FHD', 0, '0'),
('LT23', 'DELL LATITUDE 7290', 'Laptop', 0, 0, '2024-09-11 17:00:00', 'Chiếc', 'I5-8250U,Onboard,RAM 8,SSD 256,12.5" FHD', 0, '0'),
('LT24', 'HP PAVILION 14', 'Laptop', 0, 0, '2024-12-05 17:00:00', 'Chiếc', 'I7-1255U,Onboard,RAM 8,SSD 512,14" FHD', 0, '0'),
('LT25', 'HP PROBOOK 440 G8', 'Laptop', 0, 0, '2024-04-05 17:00:00', 'Chiếc', 'I7-1165G7,Onboard,RAM 8,SSD 256,14" FHD', 0, '0'),
('LT26', 'HP 15S', 'Laptop', 0, 0, '2024-06-05 17:00:00', 'Chiếc', 'I3-11G4,Onboard,RAM 8,SSD 500,15.6" FHD', 0, '0'),
('LT27', 'DELL INSPIRON 15 3515', 'Laptop', 0, 0, '2024-05-06 17:00:00', 'Chiếc', 'AMD 3050U,Onboard,RAM 8,SSD 256,15.6" FHD', 0, '0'),
('LT28', 'ACER SWIFT SF 315-52', 'Laptop', 0, 0, '2024-05-14 17:00:00', 'Chiếc', 'I3-8130U,Onboard,RAM 8,SSD 128,15.6" FHD', 0, '0'),
('LT29', 'DELL VOSTRO 14 5410', 'Laptop', 0, 0, '2024-10-31 17:00:00', 'Chiếc', 'I5-11300H,Onboard,RAM 8,SSD 512,14" FHD', 0, '0'),
('LT30', 'MAC PRO 2015', 'Laptop', 0, 0, '2024-05-08 17:00:00', 'Chiếc', 'I5,Onboard,RAM 8,SSD 256,13.3" HD', 0, '0'),
('LT31', 'DELL INSPIRON 14 5410', 'Laptop', 0, 0, '2024-10-17 17:00:00', 'Chiếc', 'I5-11300H,MX450-2GB,RAM 16,SSD 500,14" FHD', 0, '0'),
('LT32', 'HP LAPTOP 14', 'Laptop', 0, 0, '2024-06-27 17:00:00', 'Chiếc', 'R5-7520U,Onboard,RAM 16,SSD 512,14" HFD', 0, '0'),
('LT33', 'DELL LATITUDE 7290', 'Laptop', 0, 0, '2024-12-26 17:00:00', 'Chiếc', 'I5-8250U,Onboard,RAM 8,SSD 256,12.5" HD', 0, '0'),
('LT34', 'HP PAVILION 14', 'Laptop', 0, 0, '2024-12-31 17:00:00', 'Chiếc', 'I7-1256U,Onboard,RAM 16,SSD 512,14" FHD', 0, '0'),
('LT35', 'HP PROBOOK 440 G8', 'Laptop', 0, 0, '2024-09-30 17:00:00', 'Chiếc', 'I7-1165G7,Onboard,RAM 16,SSD 256,14" FHD', 0, '0'),
('LT36', 'HP 15S', 'Laptop', 0, 0, '2025-02-20 17:00:00', 'Chiếc', 'I3-1115G4,Onboard,RAM 8,SSD 500,15.6" FHD', 0, '0'),
('LT37', 'DELL INSPIRON 15 3515', 'Laptop', 0, 0, '2024-10-16 17:00:00', 'Chiếc', 'AMD 3050U,Onboard,RAM 8,SSD 256,15.6"', 0, '0'),
('LT38', 'ACER SWIFT SF 315-52', 'Laptop', 0, 0, '2025-02-03 17:00:00', 'Chiếc', 'I3-8130U,Onboard,RAM 8,SSD 128,15.6" FHD', 0, '0'),
('LT39', 'DELL VOSTRO 14 5410', 'Laptop', 0, 0, '2024-11-24 17:00:00', 'Chiếc', 'I5-11300H,Onboard,RAM 16,SSD 512,14" FHD', 0, '0'),
('LT40', 'MAC PRO 2015', 'Laptop', 0, 0, '2024-08-30 17:00:00', 'Chiếc', 'I5,Onboard,RAM 8,SSD 256,13.3" 2K', 0, '0'),
('LT41', 'DELL 5502', 'Laptop', 0, 0, '2024-06-04 17:00:00', 'Chiếc', 'I5-1135G7,Onboard,RAM 16,SSD 512,15.6" FHD', 0, '0'),
('LT42', 'DELL INSPIRON 16 5625', 'Laptop', 0, 0, '2024-10-01 17:00:00', 'Chiếc', 'AMD RYZEN 5 5625U,Onboard,RAM 8,SSD 512,16" FHD', 0, '0'),
('LT43', 'DELL INSPIRON 16 5640', 'Laptop', 0, 0, '2024-11-18 17:00:00', 'Chiếc', 'CORE I7 150U,Onboard,RAM 16,SSD 1TB,16" FHD', 0, '0'),
('LT44', 'MSI THIN GF63 12VE', 'Laptop', 0, 0, '2024-10-13 17:00:00', 'Chiếc', 'I5-12450H,RTX-4050,RAM 16,SSD 512,15.6" FHD', 0, '0'),
('LT45', 'ASUS TUF F15 FX506 HF', 'Laptop', 0, 0, '2024-05-19 17:00:00', 'Chiếc', 'I5-11400H,RTX-2050,RAM 16,SSD 512,15.6" FHD', 0, '0'),
('LT46', 'DELL G15 5510', 'Laptop', 0, 0, '2024-08-22 17:00:00', 'Chiếc', 'I5-10200H,GTX-1650,RAM 16,SSD 500,15.6" FHD', 0, '0'),
('LT47', 'ASUS ROG G531GT', 'Laptop', 0, 0, '2025-02-23 17:00:00', 'Chiếc', 'I5-9300H,GTX-1650,RAM 16,SSD 500,15.6" FHD', 0, '0'),
('LT48', 'ASUS TUF F15 FX507ZC4', 'Laptop', 0, 0, '2024-04-26 17:00:00', 'Chiếc', 'I5-12500H,RTX-3050,RAM 16,SSD 500,15.6" FHD', 0, '0'),
('LT49', 'ASUS TUF F15 FX506HC', 'Laptop', 0, 0, '2025-01-06 17:00:00', 'Chiếc', 'I5-11400H,RTX-3050,RAM 16,SSD 500,15.6" FHD', 0, '0'),
('LT50', 'DELL PRECISION 7510', 'Laptop', 0, 0, '2024-05-08 17:00:00', 'Chiếc', 'I7-6820HQ,QUADRO M1000M,RAM 16,SSD 500,15.6" FHD', 0, '0'),
('LT51', 'Macbook', 'Laptop', 0, 0, '2025-04-02 17:00:00', 'Chiếc', 'M1, RX 550, Ram 8, SSD 500, 2K', 0, '12'),
('MAIN01', 'Mainboard Asus 0302', 'Mainboard', 0, 0, '2025-04-06 17:00:00', 'Chiếc', 'Main asus socket 1151', 0, '0'),
('RAM01', 'Ram KingSton 32A59', 'Ram', 0, 0, '2025-03-25 17:00:00', 'Chiếc', '32Gb Bus 2666', 0, '12'),
('RAM02', 'Ram Kingston S', 'Ram', 0, 0, '2025-04-02 17:00:00', 'Chiếc', '16 GB', 0, '0'),
('TEST', 'test', 'abc', 0, 0, '2025-06-06 17:00:00', 'abvc', 'abc', 0, '12'),
('VGA1', 'RTX 2050', 'Card man hinh', 0, 0, '2025-04-13 17:00:00', 'Chiếc', '4GB', 0, '12');
GO

-- 7. Bảng phieunhap
CREATE TABLE phieunhap (
    maPhieu VARCHAR(50) NOT NULL PRIMARY KEY,
    thoi_gian_tao DATETIME DEFAULT GETDATE(),
    nguoi_tao VARCHAR(50) NULL,
    ma_nha_cung_cap VARCHAR(50) NULL,
    tong_tien FLOAT NOT NULL,
    CONSTRAINT FK_PhieuNhap_Account FOREIGN KEY (nguoi_tao) REFERENCES account(userName),
    CONSTRAINT FK_PhieuNhap_NhaCungCap FOREIGN KEY (ma_nha_cung_cap) REFERENCES nhacungcap(ma_nha_cung_cap)
);
GO

-- Dữ liệu mẫu phieunhap
INSERT INTO phieunhap (maPhieu, thoi_gian_tao, nguoi_tao, ma_nha_cung_cap, tong_tien) VALUES
('n1', '2025-06-07 15:16:37', 'admin', 'NCC1', 2000),
('n2', '2025-06-07 15:16:59', 'admin', 'NCC1', 1000);
GO

-- 8. Bảng chitietphieunhap
CREATE TABLE chitietphieunhap (
    maPhieu VARCHAR(50) NOT NULL,
    maMay VARCHAR(50) NOT NULL,
    maKho VARCHAR(50) NOT NULL,
    so_luong INT NULL,
    don_gia FLOAT NULL,
    baohanhnhacungcap VARCHAR(255) NULL,
    PRIMARY KEY (maPhieu, maMay, maKho),
    CONSTRAINT fk_chitietphieunhap_kho FOREIGN KEY (maKho) REFERENCES kho(maKho) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_chitietphieunhap_phieunhap FOREIGN KEY (maPhieu) REFERENCES phieunhap(maPhieu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_chitietphieunhap_sanpham FOREIGN KEY (maMay) REFERENCES sanpham(id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Dữ liệu mẫu chitietphieunhap
INSERT INTO chitietphieunhap (maPhieu, maMay, maKho, so_luong, don_gia, baohanhnhacungcap) VALUES
('n1', 'LT01', 'KHO1', 10, 100, '12'),
('n1', 'LT02', 'KHO1', 10, 100, '12'),
('n2', 'LT01', 'KHO1', 10, 100, '12');
GO

-- 9. Bảng phieuxuat
CREATE TABLE phieuxuat (
    maPhieu VARCHAR(50) NOT NULL PRIMARY KEY,
    thoi_gian_tao DATETIME DEFAULT GETDATE(),
    nguoi_tao VARCHAR(50) NOT NULL,
    tong_tien FLOAT NOT NULL,
    id_khach_hang VARCHAR(50) NULL,
    CONSTRAINT FK_PhieuXuat_Account FOREIGN KEY (nguoi_tao) REFERENCES account(userName),
    CONSTRAINT fk_phieuxuat_khachhang FOREIGN KEY (id_khach_hang) REFERENCES khachhang(id_khach_hang)
);
GO

-- Dữ liệu mẫu phieuxuat
INSERT INTO phieuxuat (maPhieu, thoi_gian_tao, nguoi_tao, tong_tien, id_khach_hang) VALUES
('x2', '2025-06-07 15:26:15', 'admin', 100, 'KH01');
GO

-- 10. Bảng chitietphieuxuat
CREATE TABLE chitietphieuxuat (
    maPhieu VARCHAR(50) NOT NULL,
    maMay VARCHAR(50) NOT NULL,
    maKho VARCHAR(50) NOT NULL,
    so_luong INT NULL,
    don_gia FLOAT NULL,
    maPhieuNhap VARCHAR(50) NULL,
    PRIMARY KEY (maPhieu, maMay, maKho),
    CONSTRAINT fk_chitietphieuxuat_kho FOREIGN KEY (maKho) REFERENCES kho(maKho) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_chitietphieuxuat_phieuxuat FOREIGN KEY (maPhieu) REFERENCES phieuxuat(maPhieu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_chitietphieuxuat_sanpham FOREIGN KEY (maMay) REFERENCES sanpham(id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Dữ liệu mẫu chitietphieuxuat
INSERT INTO chitietphieuxuat (maPhieu, maMay, maKho, so_luong, don_gia, maPhieuNhap) VALUES
('x2', 'LT02', 'KHO1', 1, 100, 'n1');
GO

-- 11. Bảng chitietsoluongsanpham
CREATE TABLE chitietsoluongsanpham (
    ma_san_pham VARCHAR(50) NOT NULL,
    san_pham_chua_kiem_tra INT DEFAULT 0,
    san_pham_loi INT DEFAULT 0,
    san_pham_ktv INT DEFAULT 0,
    maPhieu VARCHAR(50) NOT NULL,
    PRIMARY KEY (ma_san_pham, maPhieu),
    CONSTRAINT chitietsoluongsanpham_ibfk_1 FOREIGN KEY (ma_san_pham) REFERENCES sanpham(id),
    CONSTRAINT fk_ctslsp_phieunhap FOREIGN KEY (maPhieu) REFERENCES phieunhap(maPhieu) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Dữ liệu mẫu chitietsoluongsanpham
INSERT INTO chitietsoluongsanpham (ma_san_pham, san_pham_chua_kiem_tra, san_pham_loi, san_pham_ktv, maPhieu) VALUES
('LT01', 1, 1, 1, 'n1'),
('LT02', 1, 1, 1, 'n1');
GO

-- 12. Bảng congnonhacungcap
CREATE TABLE congnonhacungcap (
    ma_cong_no VARCHAR(50) NOT NULL PRIMARY KEY,
    ma_phieu_nhap VARCHAR(50) NOT NULL,
    ngay_phat_sinh DATE NOT NULL,
    so_tien_no DECIMAL(15,2) NOT NULL,
    trang_thai VARCHAR(20) DEFAULT 'chua_tra',
    ghi_chu VARCHAR(MAX) NULL,
    CONSTRAINT fk_ma_phieu_nhap FOREIGN KEY (ma_phieu_nhap) REFERENCES phieunhap(maPhieu) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- 13. Bảng thanhtoancongno
CREATE TABLE thanhtoancongno (
    ma_thanh_toan VARCHAR(50) NOT NULL PRIMARY KEY,
    ma_cong_no VARCHAR(50) NOT NULL,
    ngay_thanh_toan DATE NOT NULL,
    so_tien_thanh_toan DECIMAL(15,2) NOT NULL,
    phuong_thuc VARCHAR(50) NULL,
    ghi_chu VARCHAR(MAX) NULL,
    CONSTRAINT fk_ma_cong_no FOREIGN KEY (ma_cong_no) REFERENCES congnonhacungcap(ma_cong_no) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- 14. Bảng phieubaohanh
CREATE TABLE phieubaohanh (
    ma_phieu_bao_hanh INT IDENTITY(1,1) PRIMARY KEY,
    ma_phieu_nhap VARCHAR(50) NOT NULL,
    thoi_gian_nhan DATETIME NULL,
    nguoi_gui VARCHAR(50) NULL,
    ghi_chu VARCHAR(MAX) NULL,
    CONSTRAINT phieubaohanh_ibfk_1 FOREIGN KEY (ma_phieu_nhap) REFERENCES phieunhap(maPhieu),
    CONSTRAINT phieubaohanh_ibfk_2 FOREIGN KEY (nguoi_gui) REFERENCES nhanvien(ma_nhan_vien)
);
GO

-- 15. Bảng chitietbaohanh
CREATE TABLE chitietbaohanh (
    ma_chi_tiet INT IDENTITY(1,1) PRIMARY KEY,
    ma_phieu_bao_hanh INT NOT NULL,
    ma_san_pham VARCHAR(50) NOT NULL, -- Sửa thành VARCHAR(50) ở đây
    so_luong INT DEFAULT 1,
    mo_ta_loi VARCHAR(MAX) NULL,
    ket_qua_bao_hanh VARCHAR(MAX) NULL,
    CONSTRAINT chitietbaohanh_ibfk_1 FOREIGN KEY (ma_phieu_bao_hanh) REFERENCES phieubaohanh(ma_phieu_bao_hanh) ON DELETE CASCADE,
    CONSTRAINT fk_bh FOREIGN KEY (ma_san_pham) REFERENCES sanpham(id)
);
GO

-- 16. Bảng phieukiem
CREATE TABLE phieukiem (
    ma_phieu VARCHAR(50) NOT NULL PRIMARY KEY,
    ma_kho VARCHAR(50) NOT NULL,
    nguoi_kiem VARCHAR(50) NOT NULL,
    ngay_kiem DATE NOT NULL,
    trang_thai VARCHAR(50) DEFAULT 'Đang kiểm',
    ghi_chu VARCHAR(MAX) NULL,
    CONSTRAINT FK_nguoi_kiem FOREIGN KEY (nguoi_kiem) REFERENCES account(userName),
    CONSTRAINT phieukiem_ibfk_1 FOREIGN KEY (ma_kho) REFERENCES kho(maKho) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- 17. Bảng doitra
CREATE TABLE doitra (
    ma_doi_tra VARCHAR(50) NOT NULL PRIMARY KEY,
    ma_phieu VARCHAR(50) NULL,
    ma_may VARCHAR(50) NULL,
    ma_kho VARCHAR(50) NULL,
    so_luong INT NULL,
    ngay_doi_tra DATE NULL,
    ly_do VARCHAR(MAX) NULL,
    trang_thai VARCHAR(50) NULL,
    CONSTRAINT fk_doitra_phieuxuat FOREIGN KEY (ma_phieu, ma_may, ma_kho) REFERENCES chitietphieuxuat(maPhieu, maMay, maKho) ON UPDATE CASCADE
);
GO

INSERT INTO doitra (ma_doi_tra, ma_phieu, ma_may, ma_kho, so_luong, ngay_doi_tra, ly_do, trang_thai) VALUES
('dt2', 'x2', 'LT02', 'KHO1', 1, '2025-06-07', 'abc', 'Đã tiếp nhận');
GO

-- =========================================================
-- STORED PROCEDURES (T-SQL)
-- =========================================================

CREATE PROCEDURE spThemKhachHang 
    @p_id_khach_hang VARCHAR(20), 
    @p_ho_ten VARCHAR(100), 
    @p_sdt VARCHAR(20), 
    @p_dia_chi VARCHAR(255)
AS
BEGIN
    INSERT INTO khachhang (id_khach_hang, ho_ten, Sdt, dia_chi)
    VALUES (@p_id_khach_hang, @p_ho_ten, @p_sdt, @p_dia_chi);
END;
GO

CREATE PROCEDURE spThemNCC 
    @p_ma_nha_cung_cap VARCHAR(50), 
    @p_ten_nha_cung_cap VARCHAR(50), 
    @p_Sdt VARCHAR(50), 
    @p_dia_chi VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM NhaCungCap WHERE ma_nha_cung_cap = @p_ma_nha_cung_cap)
    BEGIN
        RAISERROR('Mã nhà cung cấp đã tồn tại!', 16, 1);
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO NhaCungCap (ma_nha_cung_cap, ten_nha_cung_cap, Sdt, dia_chi)
        VALUES (@p_ma_nha_cung_cap, @p_ten_nha_cung_cap, @p_Sdt, @p_dia_chi);
    END
END;
GO

CREATE PROCEDURE spThemTaiKhoan 
    @p_userName VARCHAR(50), 
    @p_password VARCHAR(255), 
    @p_email VARCHAR(100), 
    @p_chuc_vu VARCHAR(50)
AS
BEGIN
    INSERT INTO account (userName, password, email, chuc_vu)
    VALUES (@p_userName, @p_password, @p_email, @p_chuc_vu);
END;
GO