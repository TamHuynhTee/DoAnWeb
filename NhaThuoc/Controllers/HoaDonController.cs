using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NhaThuoc.Models;

namespace NhaThuoc.Controllers
{
    public class HoaDonController : Controller
    {
        NHATHUOCEntities db = new NHATHUOCEntities();
        /* Get list of bills (admin only)*/
        [Authorize(Roles = "admin")]
        public PartialViewResult listBill()
        {
            var listHD = (from u in db.HoaDons where u.TrangThai == "Đã nhận đơn" select u).ToList();
            return PartialView("~/Views/Partial/Admin/_BillManage.cshtml", listHD);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult listReceived()
        {
            var listHD = (from u in db.HoaDons where u.TrangThai == "Đã nhận đơn" select u).ToList();
            return PartialView("~/Views/Partial/Admin/_BillReceived.cshtml", listHD);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult listProccessing()
        {
            var listHD = (from u in db.HoaDons where u.TrangThai == "Đang xử lý" select u).ToList();
            return PartialView("~/Views/Partial/Admin/_BillProccessing.cshtml", listHD);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult listCompleted()
        {
            var listHD = (from u in db.HoaDons where u.TrangThai == "Đã giao hàng" select u).ToList();
            return PartialView("~/Views/Partial/Admin/_BillCompleted.cshtml", listHD);
        }
        [Authorize(Roles = "admin")]
        public JsonResult toProccess(int hd)
        {
            var hoadon = db.HoaDons.Find(hd);
            hoadon.TrangThai = "Đang xử lý";
            db.Entry(hoadon).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return Json(new { message = "Đã chuyển đơn đi xử lý" }, JsonRequestBehavior.AllowGet);
        }
        // Chưa thêm chức năng cộng doanh thu
        [Authorize(Roles = "admin")]
        public JsonResult toComplete(int hd)
        {
            var hoadon = db.HoaDons.Find(hd);
            hoadon.TrangThai = "Đã giao hàng";
            var dt = db.DoanhThus.Find(DateTime.Now.Date);
            if(dt == null)
            {
                DoanhThu doanhthu = new DoanhThu();
                doanhthu.Ngay = DateTime.Now.Date;
                doanhthu.DoanhThuNgay = hoadon.TongThanhToan;
                db.DoanhThus.Add(doanhthu);
            }
            else
            {
                dt.DoanhThuNgay += hoadon.TongThanhToan;
                db.Entry(dt).State = System.Data.Entity.EntityState.Modified;
            }
            hoadon.NgayNhanHang = DateTime.Now.Date;
            var daban = (from u in db.GioHangs where u.MaHD == hd select u).ToList();
            foreach(var item in daban)
            {
                item.Thuoc.DaBan += item.SoLuong;
                db.Entry(item.Thuoc).State = System.Data.Entity.EntityState.Modified;
            }
            db.Entry(hoadon).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();

            return Json(new { message = "Giao thành công, đã hoàn thành đơn hàng và cộng doanh thu" }, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult search(string text, string type)
        {
            List<HoaDon> billList = new List<HoaDon>();
            text = text.ToLower();
            switch (type)
            {
                case "id": billList = (from u in db.HoaDons where u.MaHD.ToString() == text select u).ToList(); break;
                case "name": billList = (from u in db.HoaDons where u.TenKhach.ToLower().Contains(text) select u).ToList(); break;
                case "email": billList = (from u in db.HoaDons where u.EmailXacNhan.ToLower().Contains(text) select u).ToList(); break;
                case "phone": billList = (from u in db.HoaDons where u.SDTDatHang.ToLower().Contains(text) select u).ToList(); break;
                case "address": billList = (from u in db.HoaDons where u.DiaChiNhanHang.ToLower().Contains(text) select u).ToList(); break;
                default: break;
            }
            return PartialView("~/Views/Partial/Admin/Search/_BillSearch.cshtml", billList);
        }
        // Lịch sử mua hàng
        [Authorize(Roles = "user")]
        public PartialViewResult Purchased(string username)
        {
            var kh = (from u in db.KhachHangs where u.Username == username select u.MaKH).FirstOrDefault();
            var billList = (from u in db.HoaDons where u.MaKH == kh select u).ToList();
            return PartialView("~/Views/Partial/_PaymentHistory.cshtml", billList);
        }
        [Authorize(Roles = "user")]
        public PartialViewResult BillDetail(int id)
        {
            var hd = db.HoaDons.Find(id);
            var gio = (from u in db.GioHangs where u.MaHD == id select u).ToList();
            PaymentInfo model = new PaymentInfo();
            model.hd = hd;
            model.gio = gio;
            foreach(var item in gio)
            {
                model.tongSL += item.SoLuong;
                model.tongSP++;
            }
            return PartialView("~/Views/Partial/_PaymentDetail.cshtml", model);
        }
        [Authorize(Roles = "user")]
        public JsonResult Cancel(int idDon, int idKhach)
        {
            var giohang = (from u in db.GioHangs
                           where u.MaHD == idDon
                           select u).ToList();
            var hoadon = db.HoaDons.Find(idDon);
            // Hoàn lại toàn bộ số lượng vào kho và xóa giỏ
            foreach (var item in giohang)
            {
                item.Thuoc.TrongKho += item.SoLuong;
                db.Entry(item.Thuoc).State = EntityState.Modified;
                db.GioHangs.Remove(item);
            }
            db.HoaDons.Remove(hoadon);
            var khach = db.KhachHangs.Find(idKhach);
            khach.SoLanHuyDon++;
            if (khach.SoLanHuyDon >= 4)
            {
                var block_user = db.TaiKhoans.Find(khach.Username);
                block_user.Block = true;
                db.Entry(block_user).State = EntityState.Modified;
            }
            db.Entry(khach).State = EntityState.Modified;
            db.SaveChanges();
            return Json(new { times = khach.SoLanHuyDon }, JsonRequestBehavior.AllowGet);
        }
    }
}