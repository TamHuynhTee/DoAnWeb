using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NhaThuoc.Models;

namespace NhaThuoc.Controllers
{
    public class ThuocController : Controller
    {
        NHATHUOCEntities db = new NHATHUOCEntities();

        /* Get list of products (admin only) */
        [Authorize(Roles = "admin")]
        public PartialViewResult listProduct()
        {
            var listPro = (from u in db.Thuocs select u).ToList();
            return PartialView("~/Views/Partial/Admin/_ProductManage.cshtml", listPro);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult list()
        {
            var listPro = (from u in db.Thuocs select u).ToList();
            return PartialView("~/Views/Partial/Admin/_ProductList.cshtml", listPro);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult addProduct()
        {
            return PartialView("~/Views/Partial/Admin/_ProductAdd.cshtml");
        }
        [Authorize(Roles = "admin")]
        public JsonResult Add(string name, DateTime madeday, DateTime useupto, string type,
            int instock, string productimage, double price, string effect)
        {
            Thuoc th = new Thuoc();
            bool exist = db.Thuocs.Any(x => x.TenSP == name);
            if(exist)
            {
                return Json(new { status = false, message = "Sản phẩm đã tồn tại trong kho, chỉ được cập nhật" }, JsonRequestBehavior.AllowGet);
            }
            th.TenSP = name;
            th.NgaySX = madeday;
            th.HanSD = useupto;
            th.Loai = type;
            th.TrongKho = instock;
            th.AnhMinhHoa = productimage;
            th.DonGia = price;
            th.CongDung = effect;
            db.Thuocs.Add(th);
            db.SaveChanges();
            return Json(new { status = true, message = "Thêm thành công" }, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult modifyProduct(int maSP)
        {
            var sp = db.Thuocs.Find(maSP);
            return PartialView("~/Views/Partial/Admin/_ProductModify.cshtml", sp);
        }
        [Authorize(Roles = "admin")]
        public JsonResult modifyPro(int id, string name, DateTime madeday, DateTime useupto, string type,
            int instock, string productimage, double price, string effect)
        {
            var th = db.Thuocs.Find(id);
            th.TenSP = name;
            th.NgaySX = madeday;
            th.HanSD = useupto;
            th.Loai = type;
            th.TrongKho = instock;
            th.AnhMinhHoa = productimage;
            th.DonGia = price;
            th.CongDung = effect;
            db.Entry(th).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return Json(new { message = "Đã cập nhật" }, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "admin")]
        public JsonResult removeProduct(int maSP)
        {
            if(db.GioHangs.Any(x=>x.MaSP == maSP))
                return Json(new { status = false, message = "Không thể xóa do đã có khách mua." }, JsonRequestBehavior.AllowGet);
            var sp = db.Thuocs.Find(maSP);
            db.Thuocs.Remove(sp);
            db.SaveChanges();
            return Json(new { status = true, message = "Đã xóa sản phẩm" },JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "admin")]
        public PartialViewResult search(string text, string type)
        {
            List<Thuoc> productList = new List<Thuoc>();
            text = text.ToLower();
            switch (type)
            {
                case "id": productList = (from u in db.Thuocs where u.MaSP.ToString() == text select u).ToList(); break;
                case "name": productList = (from u in db.Thuocs where u.TenSP.ToLower().Contains(text) select u).ToList(); break;
                case "kind": productList = (from u in db.Thuocs where u.Loai1.TenLoai.ToLower().Contains(text) select u).ToList(); break;
                default: break;
            }
            return PartialView("~/Views/Partial/Admin/Search/_ProductSearch.cshtml", productList);
        }

        public PartialViewResult Detail(int id)
        {
            var detail = db.Thuocs.Find(id);
            return PartialView("~/Views/Partial/_SPDetail.cshtml", detail);
        }
        
        public PartialViewResult Review(int id)
        {
            var reviews = (from u in db.DanhGiaSPs where u.MaSP == id select u).ToList();
            return PartialView("~/Views/Partial/_SPReview.cshtml", reviews);
        }
        [Authorize]
        public JsonResult AddReview(int id, string kh, string reviewtxt)
        {
            DanhGiaSP dg = new DanhGiaSP();
            dg.TaiKhoan = kh;
            dg.MaSP = id;
            dg.NoiDungDinhGia = reviewtxt;
            dg.ThoiGianDang = DateTime.Now;
            db.DanhGiaSPs.Add(dg);
            db.SaveChanges();
            return Json(new { reviewtxt = reviewtxt, user = kh, time = DateTime.Now.ToString("dd-MM-yyyy HH:mm") },JsonRequestBehavior.AllowGet);
        }
    }
}