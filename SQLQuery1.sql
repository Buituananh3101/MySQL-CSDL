select * from tblHDBan
select * from tblChatLieu
select * from tblChiTietHDBan
select * from tblHang
select * from tblKhach
select * from tblNhanVien

delete from tblChiTietHDBan where MaHang='{MaHang}'

update tblHDBan
set TongTien = TongTien + '{}'
where MaHDBan='{}'

select * from tblHang where Mahang='{Mahang}'

insert into tblKhach
values('{}','{}','{}','{}')

select * from tblKhach where DienThoai = '{}'

select TongTien
from tblHDBan
where MaHDBan = '{MaHDBan}'

select * 
from tblHDBan h join tblKhach k on h.MaKhach=k.Makhach


select NgayBan
from tblHDBan
where MaHDBan = '{MaHDBan}'

select c.MaHang, h.TenHang, h.DonGiaBan, c.SoLuong, c.GiamGia, c.ThanhTien
from tblChiTietHDBan c join tblHang h on c.MaHang=h.Mahang
where c.MaHDBan = 

