CREATE OR ALTER VIEW vw_BienDongKho
AS
-- 1. Nhập kho đã xác nhận: Tăng tồn tại MaKho
SELECT CAST(ISNULL(pn.NgayXacNhan, pn.NgayLap) AS DATETIME) AS NgayGiaoDich,
       pn.MaKho,
       ct.MaHang,
       CAST('PHIEU_NHAP' AS VARCHAR(30)) AS LoaiChungTu,
       pn.MaPhieuNhap AS MaChungTu,
       ct.SoLuong AS SoLuongTang,
       CAST(0 AS DECIMAL(18,2)) AS SoLuongGiam
FROM PhieuNhap pn
JOIN ChiTietPhieuNhap ct ON ct.MaPhieuNhap = pn.MaPhieuNhap
WHERE pn.TrangThai = 'DA_XAC_NHAN'

UNION ALL

-- 2. Xuất kho đã xác nhận (Xuất bán, xuất nội bộ): Giảm tồn
SELECT CAST(ISNULL(px.NgayXacNhan, px.NgayLap) AS DATETIME) AS NgayGiaoDich,
       px.MaKho,
       ctpx.MaHang,
       CAST(px.LoaiPhieuXuat AS VARCHAR(30)) AS LoaiChungTu,
       px.MaPhieuXuat AS MaChungTu,
       CAST(0 AS DECIMAL(18,2)) AS SoLuongTang,
       ctpx.SoLuongXuat AS SoLuongGiam
FROM PhieuXuat px
JOIN ChiTietPhieuXuat ctpx ON ctpx.MaPhieuXuat = px.MaPhieuXuat
WHERE px.TrangThai = 'DA_XAC_NHAN' AND px.LoaiPhieuXuat <> 'XUAT_HUY'

UNION ALL

-- 3. Chuyển kho đã xuất / đã nhận: Trừ tồn kho nguồn
SELECT CAST(ISNULL(pc.ThoiDiemXuat, pc.NgayLap) AS DATETIME) AS NgayGiaoDich,
       pc.MaKhoNguon AS MaKho,
       ct.MaHang,
       CAST('CHUYEN_XUAT' AS VARCHAR(30)) AS LoaiChungTu,
       pc.MaPhieuChuyen AS MaChungTu,
       CAST(0 AS DECIMAL(18,2)) AS SoLuongTang,
       ct.SoLuong AS SoLuongGiam
FROM PhieuChuyenKho pc
JOIN ChiTietPhieuChuyenKho ct ON ct.MaPhieuChuyen = pc.MaPhieuChuyen
WHERE pc.TrangThai IN ('DA_XUAT', 'DA_NHAN')

UNION ALL

-- 4. Chuyển kho đã nhận: Cộng tồn kho đích theo SỐ LƯỢNG THỰC NHẬN (chống cộng khống phần hao hụt)
SELECT CAST(ISNULL(pc.ThoiDiemNhan, ISNULL(pc.ThoiDiemXuat, pc.NgayLap)) AS DATETIME) AS NgayGiaoDich,
       pc.MaKhoDich AS MaKho,
       ct.MaHang,
       CAST('CHUYEN_NHAP' AS VARCHAR(30)) AS LoaiChungTu,
       pc.MaPhieuChuyen AS MaChungTu,
       ISNULL(ct.SoLuongNhan, ct.SoLuong) AS SoLuongTang,
       CAST(0 AS DECIMAL(18,2)) AS SoLuongGiam
FROM PhieuChuyenKho pc
JOIN ChiTietPhieuChuyenKho ct ON ct.MaPhieuChuyen = pc.MaPhieuChuyen
WHERE pc.TrangThai = 'DA_NHAN'

UNION ALL

-- 5. Cân bằng kiểm kê: Tăng hoặc Giảm tùy theo số lượng điều chỉnh (+ / -)
SELECT CAST(ISNULL(pdc.NgayDuyet, pdc.NgayLap) AS DATETIME) AS NgayGiaoDich,
       pkk.MaKho,
       ctpkk.MaHang,
       CAST('KIEM_KE' AS VARCHAR(30)) AS LoaiChungTu,
       pkk.MaPhieuKiemKe AS MaChungTu,
       CASE WHEN ctpdc.SoLuongDieuChinh > 0 THEN ctpdc.SoLuongDieuChinh ELSE CAST(0 AS DECIMAL(18,2)) END AS SoLuongTang,
       CASE WHEN ctpdc.SoLuongDieuChinh < 0 THEN -ctpdc.SoLuongDieuChinh ELSE CAST(0 AS DECIMAL(18,2)) END AS SoLuongGiam
FROM PhieuDieuChinh pdc
JOIN PhieuKiemKe pkk ON pkk.MaPhieuKiemKe = pdc.MaPhieuKiemKe
JOIN ChiTietPhieuDieuChinh ctpdc ON ctpdc.MaPhieuDieuChinh = pdc.MaPhieuDieuChinh
JOIN ChiTietPhieuKiemKe ctpkk ON ctpkk.MaCTKiemKe = ctpdc.MaCTKiemKe
WHERE pdc.TrangThai = 'DA_DUYET'

UNION ALL

-- 6. Trả hàng nhà cung cấp: Giảm tồn kho tại MaKho
SELECT CAST(ISNULL(pth.NgayTra, pth.NgayLap) AS DATETIME) AS NgayGiaoDich,
       pth.MaKho,
       ctpth.MaHang,
       CAST('TRA_HANG_NHAP' AS VARCHAR(30)) AS LoaiChungTu,
       pth.MaPhieuTraHang AS MaChungTu,
       CAST(0 AS DECIMAL(18,2)) AS SoLuongTang,
       ctpth.SoLuong AS SoLuongGiam
FROM PhieuTraHangNhap pth
JOIN ChiTietPhieuTraHangNhap ctpth ON ctpth.MaPhieuTraHang = pth.MaPhieuTraHang
WHERE pth.TrangThai = 'DA_TRA_HANG';
GO


-----------------------------------------------
CREATE OR ALTER VIEW vw_TonKhoHienTai
AS
SELECT MaKho,
       MaHang,
       CAST(SUM(SoLuongTang - SoLuongGiam) AS DECIMAL(18,2)) AS SoLuongTon
FROM vw_BienDongKho
GROUP BY MaKho, MaHang;
GO