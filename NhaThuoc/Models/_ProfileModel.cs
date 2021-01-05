using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhaThuoc.Models
{
    public class _ProfileModel
    {
        public string Ho_Dem { get; set; }
        public string Ten { get; set; }
        public string SDT { get; set; }
        public string Email { get; set; }
        public string DiaChi { get; set; }
        public bool? GioiTinh { get; set; }
        public string Username { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string AnhDaiDien { get; set; }
    }
}