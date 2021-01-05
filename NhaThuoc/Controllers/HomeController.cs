using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NhaThuoc.Models;
using PagedList;

namespace NhaThuoc.Controllers
{
    public class HomeController : Controller
    {
        NHATHUOCEntities db = new NHATHUOCEntities();
        public ActionResult Index(int? page)
        {
            if (page == null)
                page = 1;
            int pageSize = 20;
            var sanPham = (from u in db.Thuocs
                           orderby u.DaBan descending
                           select u).ToList();
            int pageNumber = (page ?? 1);
            return View(sanPham.ToPagedList(pageNumber, pageSize));
        }

        public PartialViewResult categorySearch(string cate)
        {
            List<Thuoc> model = new List<Thuoc>();
            if(cate == "OTHER")
                model = (from u in db.Thuocs
                         where u.Loai == "GC" || u.Loai == "PN" || u.Loai == "TB" || u.Loai == "SRTH"
                         orderby u.DaBan descending
                         select u).ToList();
            else
                model = (from u in db.Thuocs where u.Loai == cate orderby u.DaBan descending select u).ToList();
            return PartialView("~/Views/Partial/_HomeSearch.cshtml", model);
        }

        public PartialViewResult priceSearch(string price)
        {
            List<Thuoc> model = new List<Thuoc>();
            switch(price)
            {
                case "<100": model = (from u in db.Thuocs where u.DonGia < 100000 select u).ToList(); break;
                case "100-300": model = (from u in db.Thuocs where u.DonGia >= 100000 && u.DonGia <= 300000 select u).ToList(); break;
                case "300-500": model = (from u in db.Thuocs where u.DonGia >= 300000 && u.DonGia <= 500000 select u).ToList(); break;
                case ">500": model = (from u in db.Thuocs where u.DonGia > 500000 select u).ToList(); break;
                default: break;
            }
            return PartialView("~/Views/Partial/_HomeSearch.cshtml", model);
        }

        public PartialViewResult textSearch(string txt, string filter)
        {
            List<Thuoc> model = new List<Thuoc>();
            txt = txt.ToLower();
            switch(filter)
            {
                case "name": model = (from u in db.Thuocs where u.TenSP.ToLower().Contains(txt) orderby u.DaBan descending select u).ToList();break;
                case "type": model = (from u in db.Thuocs where u.Loai1.TenLoai.ToLower().Contains(txt) orderby u.DaBan descending select u).ToList();break;
                default: break;
            }
            return PartialView("~/Views/Partial/_HomeSearch.cshtml", model);
        }

        [Authorize(Roles = "admin")]
        public ActionResult Admin()
        {
            return View();
        }

        [Authorize(Roles = "admin")]
        public JsonResult dailyRevenue()
        {
            var dt = (from u in db.DoanhThus select u).ToArray();
            return Json(dt, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Error()
        {
            return View();
        }
        
        public ActionResult Revenue()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
    }
}