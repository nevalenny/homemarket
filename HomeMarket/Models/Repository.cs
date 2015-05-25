using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeMarket.Models
{
    public class Repository
    {
        private MarketContext context = new MarketContext();

        public IEnumerable<category> Categories
        {
            get { return context.categories; }
        }
        public IEnumerable<Good> Goods
        {
            get { return context.goods; }
        }

    }
}