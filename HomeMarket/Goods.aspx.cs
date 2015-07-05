using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Routing;
using NLog;
using HomeMarket.Logic;

namespace HomeMarket
{
    public partial class Goods : System.Web.UI.Page
    {
        private Models.Repository repository = new Models.Repository();
        private static Logger logger { get; set; }

        public static int iCategoryID = 0;
        public static string sCategoryName = "No Category";

        public Models.category currentCategory = new Models.category();
        public static Models.Good emptyGood = new Models.Good();
        public static Models.Good addGood = new Models.Good();
        public static Models.Good editGood = new Models.Good();
        public static Models.Good deleteGood = new Models.Good();

        public static String s_img_empty = "/Images/gem.png";
        public static String s_img_loading = "/Images/loading_spinner.gif";

        protected Goods()
        {
            logger = LogManager.GetCurrentClassLogger();
        }

        protected IEnumerable<Models.Good> GetGoodsByCategoryID(int Id)
        {
            return (from good in repository.Goods orderby good.Name where good.CategoryID == Id select good);
        }

        protected Models.Good GetGoodByID(int Id)
        {
            try
            { return (from good in repository.Goods where good.ID == Id select good).First(); }
            catch (System.InvalidOperationException ex)
            {
                logger.ErrorException("Error retrieving item by ID", ex);
            }

            Models.Good goodEmpty = new Models.Good();
            goodEmpty.Available = 0;
            goodEmpty.Price = 0;

            return goodEmpty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Int32.TryParse(RouteData.Values["CategoryID"].ToString().Equals("") ? "0" : RouteData.Values["CategoryID"].ToString(), out iCategoryID);
            try
            {
                currentCategory = (from category in repository.Categories where category.ID == iCategoryID select category).First();
            }
            catch (Exception ex)
            {
                sCategoryName = "No Category";
                iCategoryID = 0;
                logger.WarnException("Error getting category", ex);
            }
            sCategoryName = currentCategory.Name;
            iCategoryID = currentCategory.ID;
            Page.Title = sCategoryName;

            if (!IsPostBack)
            {
                try
                {
                    if (User.IsInRole("admins"))
                    {
                        // show invisible goods for admin
                        sds_goods.SelectCommand = "SELECT [ID], [Name], [Description], [Picture], [isVisible], [Price], [Available] FROM [Goods] WHERE [isDeleted] = 'false' AND [CategoryID] = @CategoryID ORDER BY [Name] ASC";
                    }

                    sds_goods.SelectParameters.Clear();
                    sds_goods.SelectParameters.Add("CategoryID", iCategoryID.ToString());
                    rpt_goods.DataSource = sds_goods;
                    rpt_goods.DataBind();

                }
                catch (Exception ex)
                {
                    logger.ErrorException("Error occured on accessing DataBase", ex);
                }
            }

            lv_modals.DataBind();
        }


        protected void btn_sync_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager sm = Master.FindControl("sm_master") as ScriptManager;
            if (sm != null) sm.RegisterPostBackControl(btn);
        }

        protected void btn_async_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager sm = Master.FindControl("sm_master") as ScriptManager;
            if (sm != null) sm.RegisterAsyncPostBackControl(btn);
        }


        protected void rpt_goods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Button btn = e.CommandSource as Button;
            int iGoodID = -1;
            Int32.TryParse(e.CommandArgument.ToString(), out iGoodID);

            switch (e.CommandName)
            {
                case "EditGood":
                    if (iGoodID != -1)
                    {
                        editGood = GetGoodByID(iGoodID);

                        TextBox tb_name = (TextBox)lv_modals.FindControl("tb_edit_good_name");
                        if (tb_name != null)
                        {
                            tb_name.Text = editGood.Name;
                            tb_name.Enabled = true;
                        }

                        TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_edit_good_description");
                        if (tb_desc != null)
                        {
                            tb_desc.Text = editGood.Description;
                            tb_desc.Enabled = true;
                        }

                        TextBox tb_price = (TextBox)lv_modals.FindControl("tb_edit_good_price");
                        if (tb_price != null)
                        {
                            tb_price.Text = editGood.Price.ToString();
                            tb_price.Enabled = true;
                        }

                        TextBox tb_available = (TextBox)lv_modals.FindControl("tb_edit_good_available");
                        if (tb_available != null)
                        {
                            tb_available.Text = editGood.Available.ToString();
                            tb_available.Enabled = true;
                        }

                        CheckBox cb_iv = (CheckBox)lv_modals.FindControl("cb_edit_good_isvisible");
                        if (cb_iv != null)
                        {
                            cb_iv.Checked = editGood.isVisible;
                            cb_iv.Enabled = true;
                        }

                        Image img = (Image)lv_modals.FindControl("img_edit_good");
                        if (img != null) img.ImageUrl = editGood.Picture;

                        ((UpdatePanel)lv_modals.FindControl("up_edit_good")).Update();

                    }
                    break;
                case "DeleteGood":
                    if (iGoodID != -1)
                    {
                        deleteGood = GetGoodByID(iGoodID);

                        Label lb_name = (Label)lv_modals.FindControl("lb_delete_good_name");
                        if (lb_name != null) lb_name.Text = deleteGood.Name;

                        Label lb_desc = (Label)lv_modals.FindControl("lb_delete_good_description");
                        if (lb_desc != null) lb_desc.Text = deleteGood.Description;

                        Image img = (Image)lv_modals.FindControl("img_delete_good");
                        if (img != null) img.ImageUrl = deleteGood.Picture;

                        ((UpdatePanel)lv_modals.FindControl("up_delete_good")).Update();

                    }
                    break;
                case "AddGoodToCart":
                    if (iGoodID != -1 && !btn.Text.Equals("Not available"))
                    {
                        CartActions userCart = new CartActions();
                        userCart.AddToCart(iGoodID);
                    }
                    break;
            }
        }

        protected void btn_edit_save_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                sds_goods.UpdateParameters.Clear();
                sds_goods.UpdateParameters.Add("ID", editGood.ID.ToString());

                TextBox tb_name = (TextBox)lv_modals.FindControl("tb_edit_good_name");
                if (tb_name != null) sds_goods.UpdateParameters.Add("Name", tb_name.Text);

                TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_edit_good_description");
                if (tb_desc != null) sds_goods.UpdateParameters.Add("Description", tb_desc.Text);

                TextBox tb_price = (TextBox)lv_modals.FindControl("tb_edit_good_price");
                if (tb_price != null) sds_goods.UpdateParameters.Add("Price", tb_price.Text.Replace(",", ".")); // TODO implement culture specific decimal separator

                TextBox tb_available = (TextBox)lv_modals.FindControl("tb_edit_good_available");
                if (tb_available != null) sds_goods.UpdateParameters.Add("Available", tb_available.Text);

                CheckBox cb_iv = (CheckBox)lv_modals.FindControl("cb_edit_good_isvisible");
                if (cb_iv != null) sds_goods.UpdateParameters.Add("isVisible", cb_iv.Checked ? "1" : "0");

                Image img = (Image)lv_modals.FindControl("img_edit_good");
                if (img != null) sds_goods.UpdateParameters.Add("Picture", editGood.Picture); // TODO implement picture loading

                try
                {
                    sds_goods.Update();
                }
                catch (Exception ex)
                {
                    logger.ErrorException("Error updating database", ex);
                }

                Response.Redirect("~/Goods/" + iCategoryID.ToString());
            }
        }


        protected void btn_delete_save_Click(object sender, EventArgs e)
        {
            sds_goods.DeleteParameters.Clear();
            sds_goods.DeleteParameters.Add("ID", deleteGood.ID.ToString());

            try
            {
                sds_goods.Delete();
            }
            catch (Exception ex)
            {
                logger.ErrorException("Error trying to update database for deleting item", ex);
                return;
            }

            Response.Redirect("~/Goods/" + iCategoryID.ToString());
        }

        protected void btn_add_good_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                sds_goods.InsertParameters.Clear();

                sds_goods.InsertParameters.Add("CategoryID", iCategoryID.ToString());

                TextBox tb_name = (TextBox)lv_modals.FindControl("tb_add_good_name");
                if (tb_name != null) sds_goods.InsertParameters.Add("Name", tb_name.Text);

                TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_add_good_description");
                if (tb_desc != null) sds_goods.InsertParameters.Add("Description", tb_desc.Text);

                TextBox tb_price = (TextBox)lv_modals.FindControl("tb_add_good_price");
                if (tb_price != null) sds_goods.InsertParameters.Add("Price", tb_price.Text.Replace(",", ".")); // TODO implement culture specific decimal separator

                TextBox tb_available = (TextBox)lv_modals.FindControl("tb_add_good_available");
                if (tb_available != null) sds_goods.InsertParameters.Add("Available", tb_available.Text);

                Image img = (Image)lv_modals.FindControl("img_add_good");
                if (img != null) ;
                sds_goods.InsertParameters.Add("Picture", s_img_empty); //TODO implement picture loading

                try
                {
                    sds_goods.Insert();
                }
                catch (Exception ex)
                {
                    logger.ErrorException("Error trying to insert database record for item", ex);
                    return;
                }
            }
            Response.Redirect("~/Goods/" + iCategoryID.ToString());
        }
    }
}