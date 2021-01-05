using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhaThuoc.Models
{
    public class CustomerModel
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Phone { get; set; }
        public bool Gender { get; set; }
        public string Avatar { get; set; }
        public string Address { get; set; }
        public DateTime Birthday { get; set; }
    }
}