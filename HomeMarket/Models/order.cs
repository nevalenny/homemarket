namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class order
    {
        public int ID { get; set; }

        public DateTime? Date { get; set; }

        public int? UserID { get; set; }

        public int? GoodID { get; set; }

        public int Amount { get; set; }

        public decimal Price { get; set; }

        public virtual good good { get; set; }

        public virtual user user { get; set; }
    }
}
