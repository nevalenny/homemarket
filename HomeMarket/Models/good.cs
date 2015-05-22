namespace HomeMarket.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class good
    {
        public good()
        {
            Orders = new HashSet<Order>();
        }

        public int ID { get; set; }

        [Required]
        public string Name { get; set; }

        public string Description { get; set; }

        public decimal? Price { get; set; }

        public string Picture { get; set; }

        public int? Available { get; set; }

        public bool isVisible { get; set; }

        public int CategoryID { get; set; }

        public virtual category category { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
    }
}
