using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;
using HomeMarket.Models;


namespace HomeMarket.Account
{
    public partial class Register : Page
    {
        private Models.MarketContext _db = new Models.MarketContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            try
            {
                var user = _db.Users.First(u => u.UserName == RegisterUser.UserName);
                var tb = (TextBox)RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("tb_name");
                if (tb != null) { user.Name = tb.Text; }
                _db.SaveChanges();
            }
            catch (Exception ex)
            {

            }
            FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);

            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (!OpenAuth.IsLocalUrl(continueUrl))
            {
                continueUrl = "~/Categories";
            }

            Response.Redirect(continueUrl);
        }
    }
}