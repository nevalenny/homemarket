using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace HomeMarket.Models
{
    public class CartItem
    {
        public string ID { get; set; }

        public string UserId { get; set; }

        public int Quantity { get; set; }

        public System.DateTime DateCreated { get; set; }

        public int GoodId { get; set; }

        public virtual Good Good { get; set; }

    }
}