using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NLog;
using HomeMarket.Logic;

namespace HomeMarket
{
    public partial class Checkout : System.Web.UI.Page
    {
        public Models.Repository repository = new Models.Repository();
        private static Logger logger = LogManager.GetCurrentClassLogger();

        public static decimal dTotalSum = 0;
        public static int iTotalCount = 0;
        public static bool isItemsRemoved = false;
        public static bool isNotEnoughMoney = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if(Context.User.Identity.IsAuthenticated)
                {
                    isItemsRemoved = false;
                    isNotEnoughMoney = false;
                    CartActions userCart = new CartActions();
                    List<Models.CartItem> ds_items = userCart.GetCartItems();
                    bool isCartNotEmpty = (ds_items.Count>0);
                    if (isCartNotEmpty)
                    {
                        // remove overstock items
                        foreach (Models.CartItem item in ds_items)
                        {
                            while (item.Quantity > item.Good.Available)
                            {
                                userCart.RemoveFromCart(item.GoodId);
                                item.Quantity--;
                                isItemsRemoved = true;
                            }
                        }

                        rp_order.DataSource = ds_items;
                        dTotalSum = userCart.TotalSum();
                        iTotalCount = userCart.TotalCount();
                        rp_order.DataBind();

                        var receipt = userCart.BuyAll();
                        rp_receipt.DataSource = receipt;
                        if (rp_order.Items.Count > receipt.Count)
                        {
                            isNotEnoughMoney = true;
                        }
                        rp_receipt.DataBind();
                    }
                }
            }
        }
    }
}