using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using NLog;
using HomeMarket.Logic;

namespace HomeMarket
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        public Models.Repository repository = new Models.Repository();
        private static Logger logger = LogManager.GetCurrentClassLogger();

        public static decimal dTotalSum = 0;
        public static int iTotalCount = 0;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Context.User.Identity.IsAuthenticated)
            {
                lv_master.DataBind();
            }
        }

        protected void btn_show_cart_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            sm_master.RegisterAsyncPostBackControl(btn);
        }

        protected void btn_show_cart_Click(object sender, EventArgs e)
        {
            UpdatePanel up = lv_modals.FindControl("up_cart") as UpdatePanel;
            Repeater rp = up.FindControl("rp_cart") as Repeater;
            if (rp!=null)
            {                                 
                CartActions userCart = new CartActions();
                rp.DataSource = userCart.GetCartItems();
                dTotalSum = userCart.TotalSum();
                iTotalCount = userCart.TotalCount();
                rp.DataBind();
                up.Update();
            }
            
        }

        protected void rp_cart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Button btn = e.CommandSource as Button;
            int iGoodId = -1;
            Int32.TryParse(e.CommandArgument.ToString(), out iGoodId);
            switch (e.CommandName)
            {
                case "RemoveItem":
                    if (iGoodId != -1)
                    {
                        UpdatePanel up = lv_modals.FindControl("up_cart") as UpdatePanel;
                        Repeater rp = up.FindControl("rp_cart") as Repeater;
                        if (rp != null)
                        {
                            CartActions userCart = new CartActions();
                            userCart.RemoveFromCart(iGoodId);
                            rp.DataSource = userCart.GetCartItems();
                            dTotalSum = userCart.TotalSum();
                            iTotalCount = userCart.TotalCount();
                            rp.DataBind();
                            up.Update();
                        }

                    }
                    break;
            }
        }

        protected void btn_buy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Checkout");
        }
    }
}