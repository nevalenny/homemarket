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
                    foreach (Models.CartItem item in ds_items)
                    {
                        while(item.Quantity > item.Good.Available)
                        {
                            userCart.RemoveFromCart(item.GoodId);
                            item.Quantity--;
                            isItemsRemoved = true;
                        }
                    }
                    rp_order.DataSource = ds_items;
                    dTotalSum = userCart.TotalSum();
                    iTotalCount = userCart.TotalCount();

                    // TODO payment logic here
                    repository.User.WalletBalance -= dTotalSum;

                    rp_order.DataBind();

                    rp_receipt.DataSource = userCart.BuyAll();
                    if(rp_order.Items.Count>rp_receipt.Items.Count)
                    {
                        isNotEnoughMoney = true;
                    }
                    rp_receipt.DataBind();
                }
            }
        }
    }
}