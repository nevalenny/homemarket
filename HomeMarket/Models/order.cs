namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Order
    {
        public Guid ID { get; set; }

        public DateTime? Date { get; set; }

        public Guid? UserID { get; set; }

        public int? GoodID { get; set; }

        public int Amount { get; set; }

        public decimal Price { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int OrderID { get; set; }

        public virtual Good good { get; set; }

        public virtual User User { get; set; }
    }

    public partial class OrderOut
    {

        public DateTime? Date { get; set; }

        public string UserName { get; set; }

        public string ItemName { get; set; }

        public int Amount { get; set; }

        public decimal Price { get; set; }

    }
}
