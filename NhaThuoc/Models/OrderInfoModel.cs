using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhaThuoc.Models
{
    public class OrderInfoModel
    {
        public KhachHang khach { get; set; }
        public List<GioHang> gio { get; set; }
        public string TrangThai { get; set; }
        public double tongTien { get; set; }
        public int tongSP { get; set; }
        public int tongSL { get; set; }
    }
}