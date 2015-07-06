using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeMarket
{
    public partial class Statistics : System.Web.UI.Page
    {
        private Models.MarketContext _db = new Models.MarketContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if(User.IsInRole("admins"))
                {
                    var l_orders = _db.Orders.Select(o => o)
                        .Join(_db.goods, o => o.GoodID, g => g.ID, (o, g) => 
                            new { Date = o.Date, ID=o.OrderID ,UserID = o.UserID, ItemName = g.Name, Amount = o.Amount, Price = o.Price })
                    .Join(_db.Users, o => o.UserID, u => u.UserID, (o, u) =>
                        new { Date = o.Date, ID=o.ID, UserName = u.UserName, ItemName = o.ItemName, Amount = o.Amount, Price = o.Price }).OrderBy(o=>o.Date).ToList();
                    rp_orders.DataSource = l_orders;
                    rp_orders.DataBind();
                }
            }
        }
    }
}